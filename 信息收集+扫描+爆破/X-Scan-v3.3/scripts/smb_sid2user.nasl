#
# This script was written by Tenable Network Security
#
# This script is released under Tenable Plugins License
#

if(description)
{
 script_id(10399);
 script_bugtraq_id(959);
 script_cve_id("CVE-2000-1200");
 script_version ("$Revision: 1.48 $");
 
 name["english"] = "SMB use domain SID to enumerate users";
 
 script_name(english:name["english"]);
 
 desc["english"] = "

This script uses the Domain SID to enumerates
the users ID from 1000 to 1200 (or whatever you
set this to, in the preferences)

Risk factor : None";

 script_description(english:desc["english"]);
 
 summary["english"] = "Enumerates users";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2005 Tenable Network Security");
 family["english"] = "Windows";
 script_family(english:family["english"]);
 
 script_dependencies("netbios_name_get.nasl",
 		     "smb_login.nasl",
		     "smb_dom2sid.nasl");
 script_require_keys("SMB/transport", "SMB/name", "SMB/login", "SMB/password", "SMB/domain_sid");
 script_require_ports(139, 445);
 script_add_preference(name:"Start UID : ", type:"entry", value:"1000");
 script_add_preference(name:"End UID : ", type:"entry", value:"1200");
 
 exit(0);
}

include("smb_func.inc");


#---------------------------------------------------------#
# call LsaLookupSid with only one sid			  #
#---------------------------------------------------------#

function get_name (handle, sid, rid)
{
 local_var fsid, psid, name, type, user, names;

 fsid = sid[0] + raw_byte (b: ord(sid[1])+1) + substr(sid,2,strlen(sid)-1) + raw_dword (d:rid);

 psid = NULL;
 psid[0] = fsid;

 names = LsaLookupSid (handle:handle, sid_array:psid);
 if (isnull(names))
   return NULL;

 name = names[0];
 type = get_dword (blob:name, pos:0);
 user = substr (name, 4, strlen(name)-1);

 return user;
}


#---------------------------------------------------------#
# hexstr() to raw_string() conversion			  #
#---------------------------------------------------------#

function hexsid_to_rawsid(s)
{
 local_var i, j, ret;
 
 for(i=0;i<strlen(s);i+=2)
 {
  if(ord(s[i]) >= ord("0") && ord(s[i]) <= ord("9"))
  	j = int(s[i]);
  else
  	j = int((ord(s[i]) - ord("a")) + 10);

  j *= 16;
  if(ord(s[i+1]) >= ord("0") && ord(s[i+1]) <= ord("9"))
  	j += int(s[i+1]);
  else
  	j += int((ord(s[i+1]) - ord("a")) + 10);
  ret += raw_string(j);
 }
 return ret;
}


port = kb_smb_transport();
if(!port)port = 139;
if(!get_port_state(port))exit(0);
__start_uid = script_get_preference("Start UID : ");
__end_uid   = script_get_preference("End UID : ");

if(__end_uid < __start_uid)
{
 t  = __end_uid;
 __end_uid = __start_uid;
 __start_uid = t;
}

if(!__start_uid)__start_uid = 1000;
if(!__end_uid)__end_uid = __start_uid + 200;

__no_enum = string(get_kb_item("SMB/Users/0"));
if(__no_enum)exit(0);

__no_enum = string(get_kb_item("SMB/Users/1"));
if(__no_enum)exit(0);


# we need the  netbios name of the host
name = kb_smb_name();
if(!name)exit(0);

login = kb_smb_login();
pass  = kb_smb_password();
if(!login)login = "";
if(!pass)pass = "";

domain = kb_smb_domain(); 


# we need the SID of the domain
sid = get_kb_item("SMB/domain_sid");
if(!sid)exit(0);

sid = hexsid_to_rawsid (s:sid);

soc = open_sock_tcp(port);
if(!soc)exit(0);

session_init (socket:soc,hostname:name);
ret = NetUseAdd (login:login, password:pass, domain:domain, share:"IPC$");
if (ret != 1)
{
 close (soc);
 exit (0);
}

handle = LsaOpenPolicy (desired_access:0x20801);
if (isnull(handle))
{
  NetUseDel();
  exit (0);
}

num_users = 0;
set_kb_item(name:"SMB/Users/enumerated", value:TRUE);
report = string("The domain SID could be used to enumerate the names of the users\n",
		"of this domain. \n",
		"(we only enumerated users name whose ID is between ",
		__start_uid," and ", __end_uid, "\n",
		"for performance reasons)\n",
		"This gives extra knowledge to an attacker, which\n",
		"is not a good thing : \n");
		

n = get_name(handle:handle, sid:sid, rid:500);
if(n)
 {
 num_users = num_users + 1;
 report = report + string("- Administrator account name : ", n, " (id 500)\n");
 set_kb_item(name:string("SMB/Users/", num_users), value:n);
 set_kb_item(name:"SMB/AdminName", value:n);
 }


n = get_name(handle:handle, sid:sid, rid:501);
if(n)
 {
  report = report + string("- Guest account name : ", n, " (id 501)\n");
  num_users = num_users + 1;
  set_kb_item(name:string("SMB/Users/", num_users), value:n);
 }

#
# Retrieve the name of the users between __start_uid and __start_uid
#
mycounter = __start_uid;
while(1)
{
 n = get_name(handle:handle, sid:sid, rid:mycounter);
 if(n)
 {
  report = report + string("- ", n, " (id ", mycounter, ")\n");
  num_users = num_users + 1;
  set_kb_item(name:string("SMB/Users/", num_users), value:n);
 }
 else if(mycounter > __end_uid)break;
 
 if(mycounter > (5 * __end_uid))break;
 
 
 mycounter++;
}


LsaClose (handle:handle);
NetUseDel ();

report = report + string(
	"\nRisk factor : None\n",
	"Solution : filter incoming connections this port\n");

	
if(num_users > 0)
{
 security_note(data:report, port:port);
}
