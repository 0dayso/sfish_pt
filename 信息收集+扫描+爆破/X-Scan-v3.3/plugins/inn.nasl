#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(10129);
 script_version ("$Revision: 1.25 $");
 script_cve_id("CVE-1999-0705","CVE-1999-0043","CVE-1999-0247");
 script_bugtraq_id(1443, 616, 687);
 script_xref(name:"OSVDB", value:"1093");
 script_xref(name:"OSVDB", value:"1450");
 script_xref(name:"OSVDB", value:"16030");

 script_name(english:"INN < 1.6 Multiple Vulnerabilities");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote NNTP server is affected by multiple vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"According to its banner, the remote version of INN is older than
version 1.6.  A number of security holes have been found older
versions of INN, some of which may allow arbitrary command execution." );
 script_set_attribute(attribute:"see_also", value:"http://www.cert.org/advisories/CA-1997-08.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?3132c982" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to version 1.6 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );
script_end_attributes();

 
 script_summary(english:"Checks INN version");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 1999-2009 Tenable Network Security, Inc.");
 script_family(english:"Gain a shell remotely");
 script_dependencie("find_service1.nasl");
 script_require_ports("Services/nntp", 119);
 exit(0);
}

#
# The script code starts here
#


# Read the banner from the knowledge base,
# or get it by connecting to the server
# manually


port = get_kb_item("Services/nntp");
if(!port)port = 119;

key = string("nntp/banner/", port);
banner = get_kb_item(key);

if(!banner)
{
 if(get_port_state(port))
 {
  soc = open_sock_tcp(port);
  if(soc)
  {
   banner = recv_line(socket:soc,length:1024);
   close(soc);
  }
 }
}



if(!banner)exit(0);
s = strstr(banner,"INN");
 if(s)
 {
  version = s[4];
  subversion = s[6];
  if((version == 1)&&(subversion < 6))
	{ security_hole(port); }

 }

