#
# (C) Tenable Network Security, Inc.
#

# Script audit and contributions from Carmichael Security
#      Erik Anderson <eanders@carmichaelsecurity.com> (nb: domain no longer exists)
#      Added BugtraqID and CVE
# 
# References:
# Date:  Thu, 18 Oct 2001 16:16:20 +0200
# From: "andreas junestam" <andreas.junestam@defcom.com>
# Affiliation: Defcom
# To: "bugtraq" <bugtraq@securityfocus.com>
# Subject: def-2001-30
#
# Affected:
# Oracle9iAS Web Cache/2.0.0.1.0
# 


include("compat.inc");


if(description)
{
 script_id(11069);
 script_version ("$Revision: 1.24 $");
 script_cve_id("CVE-2001-0836");
 script_bugtraq_id(3443, 3449);
 script_xref(name:"OSVDB", value:"5534");

 script_name(english:"Web Server HTTP User-Agent Header Handling Remote Overflow");
 script_summary(english:"Tries to crash the web server with a long user-agent");

 script_set_attribute(
   attribute:"synopsis",
   value:string(
     "The remote host is running a web server with a remote buffer\n",
     "overflow vulnerability."
   )
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "It was possible to kill the web server by sending an invalid GET\n",
     "request with a long User-Agent field. A remote attacker may exploit\n",
     "this vulnerability to make the web server crash continually or\n",
     "possibly execute arbitrary code."
   )
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://marc.info/?l=bugtraq&m=100395487007578&w=2"
 );
 script_set_attribute(
   attribute:"see_also",
   value:"http://marc.info/?l=bugtraq&m=100342151132277&w=2"
 );
 script_set_attribute(
   attribute:"solution", 
   value:"Upgrade your software or protect it with a filtering reverse proxy."
 );
 script_set_attribute(
   attribute:"cvss_vector", 
   value:"CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P"
 );
 script_end_attributes();
 
 script_category(ACT_DENIAL);
# All the www_too_long_*.nasl scripts were first declared as 
# ACT_DESTRUCTIVE_ATTACK, but many web servers are vulnerable to them:
# The web server might be killed by those generic tests before Nessus 
# has a chance to perform known attacks for which a patch exists
# As ACT_DENIAL are performed one at a time (not in parallel), this reduces
# the risk of false positives.
 
 script_copyright(english:"This script is Copyright (C) 2002-2009 Tenable Network Security, Inc.");
 script_family(english: "Web Servers");
 script_require_ports("Services/www", 80);
 script_require_keys("Settings/ParanoidReport");
 script_dependencie("httpver.nasl", "http_version.nasl");
 exit(0);
}

########
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

if (report_paranoia < 2) exit(0);

port = get_http_port(default:80, embedded:1);

if(http_is_dead(port: port)) exit(0);

r = http_send_recv3(method: "GET", item: "/", port: port, 
 add_headers: make_array("User-Agent", crap(4000)));

if (http_is_dead(port: port, retry: 3)) { security_hole(port);}
