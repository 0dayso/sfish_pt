#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(10517);
 script_version ("$Revision: 1.22 $");
 script_cve_id("CVE-2000-0843");
 script_bugtraq_id(1666);
 script_xref(name:"OSVDB", value:"416");
 
 script_name(english:"pam_smb / pam_ntdom User Name Remote Overflow");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host has an application that may be affected by 
a buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote telnet server shut the connection abruptly when given
a long username followed by a password.

Although Nessus could not be 100% positive, it may mean that
the remote host is using an older pam_smb or pam_ntdom
pluggable authentication module to validate user credentials
against a NT domain.

Older version of these modules have a well known buffer 
overflow which may allow an intruder to execute arbitrary 
commands as root on this host. 

It may also mean that this telnet server is weak and crashes
when issued a too long username, in this case this host is
vulnerable to a similar flow.

This may also be a false positive." );
 script_set_attribute(attribute:"solution", value:
" . if pam_smb or pam_ntdom is being used on this host, be sure to upgrade it 
   to the newest non-devel version.

 . if the remote telnet server crashed, contact your vendor for a patch" );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 script_summary(english:"Attempts to overflow the remote pam_smb");
 script_category(ACT_DESTRUCTIVE_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2000-2009 Tenable Network Security, Inc.");
 script_family(english:"Gain a shell remotely");
 script_dependencie("find_service1.nasl");
 script_require_ports("Services/telnet", 23);
 exit(0);
}

include('telnet_func.inc');
include('global_settings.inc');
if ( report_paranoia < 2 ) exit(0);

port = get_kb_item("Services/telnet");
if(!port)port = 23;

if(get_port_state(port))
{
soc = open_sock_tcp(port);
if(soc)
 {
  r = telnet_negotiate(socket:soc);
  if(!r)exit(0);
  if("HP JetDirect" >< r )exit(0);
  login = crap(length:1024, data:"nessus") + string("\r\n");
  send(socket:soc, data:login);
  r = recv(socket:soc, length:2048);
  if(!r)exit(0);
  send(socket:soc, data:string("pass\r\n"));
  r = recv(socket:soc, length:2048);
  close(soc);
  if(!r)
  {
  security_hole(port);
  }
 }
}
