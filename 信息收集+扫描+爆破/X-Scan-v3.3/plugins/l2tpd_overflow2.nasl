#
# (C) Tenable Network Security, Inc.
#
#


include("compat.inc");

if (description)
{
 script_id(13659);
 script_version ("$Revision: 1.8 $");
 script_cve_id("CVE-2004-0649");
 script_bugtraq_id(10466);
 script_xref(name:"OSVDB", value:"6726");
 
 script_name(english:"l2tpd < 0.69 control.c write_packet Function Remote Overflow");

 script_set_attribute(attribute:"synopsis", value:
"The remote host is running a network tunneling application that is 
affected by a buffer overflow vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running a version of l2tpd which is older or
equal to 0.68. 

This version is vulnerable to a buffer overflow which might allow an
attacker to execute arbitrary commands on the remote host with 
super-user privileges." );
 script_set_attribute(attribute:"see_also", value:"http://seclists.org/lists/bugtraq/2004/Jun/0073.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to l2tpd 0.69 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C" );

script_end_attributes();

 script_summary(english:"Determines the version of the remote l2tpd");
 script_category(ACT_GATHER_INFO);
 script_family(english:"Gain a shell remotely");
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_dependencie("l2tp_detection.nasl");
 script_require_ports("Services/udp/l2tp");
 exit(0);
}

if (! get_kb_item("Services/udp/l2tp") ) exit(0);

function find_firmware(rep)
{
 local_var firmware, i, len;
 
 for(i=12;i<strlen(rep);i++)
 { 
  len = ord(rep[i]) * 256 + ord(rep[i+1]);
  if(ord(rep[i]) & 0x80)len -= 0x80 * 256;
  if(ord(rep[i+5]) == 6)
  {
   firmware = ord(rep[i+6]) * 256 + ord(rep[i+7]);
   return firmware;
  }
  else i += len - 1;
 }
 return NULL;
}

req =  raw_string(0xC8, 2, 0, 20, 0, 0, 0, 0,0,0,0,0,0,8, 0,0,0,0,0,0);

		 
soc = open_sock_udp(1701);
send(socket:soc, data:req);
r = recv(socket:soc, length:1024);
if(!r)exit(0);
close(soc);
if(("l2tpd" >< r) || ("Adtran" >< r))
{
 firmware = find_firmware(rep:r);
 hi = firmware / 256;
 lo = firmware % 256;
 
 if((hi == 0x06)  && (lo < 0x90))security_hole(port:1701, proto:"udp");
}
