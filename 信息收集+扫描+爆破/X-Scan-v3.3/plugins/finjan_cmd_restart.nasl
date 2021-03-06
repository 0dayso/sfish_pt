#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if(description)
{ 
 script_id(12036);
 script_version ("$Revision: 1.9 $");
 script_cve_id("CVE-2004-2107");
 script_bugtraq_id(9478);
 script_xref(name:"OSVDB", value:"3718");
 script_xref(name:"Secunia", value:"10714");
 
 script_name(english:"Finjan SurfinGate Proxy FHTTP Command Admin Functions Authentication Bypass");
 script_summary(english:"determines if the remote proxy can connect against itself");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote proxy server has a security bypass vulnerability."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The remote host is running a Finjan SurfinGate, a web proxy.\n\n",
     "It is possible to bypass admin authentication by using the proxy to\n",
     "connect to itself.  A remote attacker could exploit this to view log\n",
     "information, force a policy update, or restart the service."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://archives.neohapsis.com/archives/fulldisclosure/2004-01/0929.html"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Block all connection attempts to the control port."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"Firewalls");

 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");

 script_dependencie("find_service1.nasl");
 script_require_ports("Services/http_proxy", 3128);

 exit(0);
}

#
# The script code starts here
#

port = get_kb_item("Services/http_proxy");
if(!port) port = 3128;

if ( get_port_state(port) )
{
 soc = open_sock_tcp(port);
 if ( ! soc ) exit(0);

 send(socket:soc, data:'CONNECT localhost:3141 HTTP/1.0\r\n\r\n');
 r = recv_line(socket:soc, length:4096); 
 if ( ! r ) exit(0);
 if ( "200 Connection established" >!< r ) exit(0);
 r = recv_line(socket:soc, length:4096); 
 if ( ! r ) exit(0);
 if ( 'Proxy-agent: Finjan' >< r ) security_hole(port);
 close(soc);
}
