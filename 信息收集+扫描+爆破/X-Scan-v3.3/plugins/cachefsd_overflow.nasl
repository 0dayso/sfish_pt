#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(10951);
 script_version ("$Revision: 1.21 $");
 script_cve_id("CVE-2002-0084");
 script_bugtraq_id(4631);
 script_xref(name:"OSVDB", value:"17477");
 script_xref(name:"IAVA", value:"2002-t-0008");
 
 script_name(english:"Solaris cachefsd fscache_setup Function Remote Overflow");
 script_summary(english:"Checks the presence of a RPC service");
 
 script_set_attribute(
   attribute:"synopsis",
   value:"The remote RPC service has multiple buffer overflow vulnerabilities."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The cachefsd RPC service is running on this port.\n\n",
     "Multiple vulnerabilities exist in this service.  At least one heap\n",
     "overflow vulnerability can be exploited remotely to obtain root\n",
     "privileges by sending a long directory and cache name request to the\n",
     "service.  A buffer overflow can result in root privileges from local\n",
     "users exploiting the fscache_setup function with a long mount\n",
     "argument\n\n",
     "Solaris 2.5.1, 2.6, 7 and 8 are vulnerable to this issue. Other\n",
     "operating systems might be affected as well.\n\n",
     "*** Nessus did not check for this vulnerability,\n",
     "*** so this might be a false positive."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://archives.neohapsis.com/archives/vulnwatch/2002-q2/0048.html"
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://sunsolve.sun.com/search/document.do?assetkey=1-66-201311-1"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Apply the appropriate patch referenced in the vendor's advisory."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
 );
 script_end_attributes();

 script_category(ACT_GATHER_INFO);
 script_family(english:"Gain a shell remotely"); 
 script_copyright(english:"This script is Copyright (C) 2002-2009 Tenable Network Security, Inc.");
 script_dependencie("rpc_portmap.nasl");
 script_require_keys("rpc/portmap");
 exit(0);
}

#
# The script code starts here
#

include("misc_func.inc");
include("global_settings.inc");

if ( report_paranoia == 0 ) exit(0);


#
# This is kinda lame but there's no way (yet) to remotely determine if
# this service is vulnerable to this flaw.
# 
RPC_PROG = 100235;
tcp = 0;
port = get_rpc_port(program:RPC_PROG, protocol:IPPROTO_UDP);
if(!port){
	port = get_rpc_port(program:RPC_PROG, protocol:IPPROTO_TCP);
	tcp = 1;
	}

if(port)
{
 if(tcp)security_hole(port);
 else security_hole(port, protocol:"udp");
}
