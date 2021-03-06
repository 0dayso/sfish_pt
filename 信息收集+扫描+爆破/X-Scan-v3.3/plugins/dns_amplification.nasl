#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if(description)
{
 script_id(35450);
 script_version("$Revision: 1.5 $");

 script_name(english:"DNS Server Spoofed Request Amplification DDoS");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote DNS server could be used in a distributed denial of service
attack." );
 script_set_attribute(attribute:"description", value:
"The remote DNS server answers to any request.  It is possible to query
the name servers (NS) of the root zone ('.') and get an answer which
is bigger than the original request.  By spoofing the source IP
address, a remote attacker can leverage this 'amplification' to launch
a denial of service attack against a third-party host using the remote
DNS server." );
 script_set_attribute(attribute:"see_also", value:"http://isc.sans.org/diary.html?storyid=5713" );
 script_set_attribute(attribute:"solution", value:
"Restrict access to your DNS server from public network or reconfigure
it to reject such queries." );
 script_set_attribute(attribute:"risk_factor", value:"None" );
script_end_attributes();

 script_summary(english:"Sends a '.' request");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english:"DNS");
 script_dependencies("dns_server.nasl");
 script_require_keys("DNS/udp/53");
 exit(0);
}

include("global_settings.inc");
include("network_func.inc");
include("dns_func.inc");
include("byte_func.inc");

if (! COMMAND_LINE && ! get_kb_item("DNS/udp/53")) exit(0);
if (report_paranoia < 2 && is_private_addr()) exit(0);

dns["transaction_id"] = rand() & 0xffff;
dns["flags"]	      = 0x0010;
dns["q"]	      = 1;
packet = mkdns(dns:dns, query:mk_query(txt:mk_query_txt(""),type:0x0002, class:0x0001));
soc = open_sock_udp(53);
len1 = strlen(packet);
send(socket:soc, data:packet);
r = recv(socket:soc, length:4096);
close(soc);

len2 = strlen(r);
# The request is 17 bytes long, the answer is 492 bytes long
if (len2 > 2 * len1)
{
 txt = strcat('\nThe DNS query was ', len1, ' bytes long, the answer is ', len2, ' bytes long.\n');
 security_note(port: 53, proto: "udp", extra: txt);
 if (COMMAND_LINE) display(txt);
}
