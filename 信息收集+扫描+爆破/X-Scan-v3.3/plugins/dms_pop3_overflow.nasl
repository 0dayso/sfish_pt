#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(15783);
 script_version ("$Revision: 1.7 $");
 script_cve_id("CVE-2004-1533");
 script_bugtraq_id( 11705 );
 script_xref(name:"OSVDB", value:"11927");

 script_name(english:"Digital Mappings Systems POP3 Server (pop3svr.exe) Multiple Field Remote Overflow");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote server is vulnerable to a denial of service attack." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Digital Mappings Systems POP3 server that
has a remote buffer overrun vulnerability.  An attacker, exploiting
this flaw, may be crash the service." );
 script_set_attribute(attribute:"solution", value:
"Ensure that you are running a recent and protected POP3 Server." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P" );

 script_end_attributes();

 script_summary(english:"checks the banner of the remote POP3 server");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_family(english:"Gain a shell remotely");
 script_dependencie("find_service2.nasl");
 script_require_ports("Services/pop3", 110);
 exit(0);
}

#
# The script code starts here
#
include("pop3_func.inc");

port = get_kb_item("Services/pop3");
if ( ! port ) port = 110;
if ( ! get_port_state(port) ) exit(0);

banner = get_pop3_banner(port:port);
if ( ! banner ) exit(0);
if ( egrep(pattern:"^\+OK.*DMS POP3 Server 1\.([0.4]\.|5\.([0.2]\.|3\.([0-9][^0-9]|[0-1][0-9][^0-9]|2[0-7])))", string:port) )
	security_warning(port);
