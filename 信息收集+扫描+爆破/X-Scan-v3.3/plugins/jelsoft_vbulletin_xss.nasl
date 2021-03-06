#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if(description)
{
 script_id(12058);
 script_version ("$Revision: 1.14 $");
 script_cve_id("CVE-2004-2076");
 script_bugtraq_id(9649, 9656);
 script_xref(name:"OSVDB", value:"38023");
 
 script_name(english:"vBulletin search.php query Parameter XSS");

 script_set_attribute(attribute:"synopsis", value:
"The remote host contains a PHP application that is vulnerable to a
cross-site scripting attack." );
 script_set_attribute(attribute:"description", value:
"There is a cross-site scripting issue in vBulletin that may allow an
attacker to steal a user's cookies." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/353869" );
 script_set_attribute(attribute:"solution", value:
"Unknown at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
 script_summary(english:"Checks for JelSoft VBulletin");
 script_category(ACT_ATTACK);
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc."); 
 script_family(english:"CGI abuses : XSS");
 script_dependencies("vbulletin_detect.nasl", "cross_site_scripting.nasl");
 script_exclude_keys("Settings/disable_cgi_scanning");
 script_require_ports("Services/www", 80);

 exit(0);
}

# The script code starts here
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);

if(!get_port_state(port))exit(0);
if(!can_host_php(port:port))exit(0);

# Test an install.
install = get_kb_item(string("www/", port, "/vBulletin"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches)) {
 d = matches[2];
 test_cgi_xss(port: port, cgi: "/search.php", dirs: make_list(d),
 qs: "do=process&showposts=0&query=<script>foo</script>",
 pass_re: "<script>foo</script>");
}
