#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(22004);
  script_version("$Revision: 1.10 $");

  script_cve_id("CVE-2006-3548", "CVE-2006-3549");
  script_bugtraq_id(18845);
  script_xref(name:"OSVDB", value:"27032");
  script_xref(name:"OSVDB", value:"27033");
  script_xref(name:"OSVDB", value:"27034");

  script_name(english:"Horde < 3.0.11 / 3.1.2 Multiple Script XSS");
  script_summary(english:"Tries to exploit an XSS flaw in Horde's services/go.php");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP script that is affected by
multiple cross-site scripting vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The version of Horde installed on the remote host fails to validate
input to the 'url' parameter of the 'services/go.php' script before
using it in dynamically generated content.  An unauthenticated
attacker may be able to leverage this issue to inject arbitrary HTML
and script code into a user's browser. 

In addition, similar cross-site scripting issues reportedly exist with
the 'module' parameter of the 'services/help/index.php' script and the
'name' parameter of the 'services/problem.php' script." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/fulldisclosure/2006-07/0090.html" );
 script_set_attribute(attribute:"see_also", value:"http://lists.horde.org/archives/announce/2006/000287.html" );
 script_set_attribute(attribute:"see_also", value:"http://lists.horde.org/archives/announce/2006/000288.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Horde 3.0.11 / 3.1.2 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N" );
script_end_attributes();

 
  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses : XSS");
 
  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("horde_detect.nasl", "cross_site_scripting.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");
include("url_func.inc");


port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);
if (get_kb_item("www/"+port+"/generic_xss")) exit(0);


# A simple (and invalid) alert.
xss = string("javascript:alert(", SCRIPT_NAME, ")");


# Test an install.
install = get_kb_item(string("www/", port, "/horde"));
if (isnull(install)) exit(0);
matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
if (!isnull(matches))
{
  dir = matches[2];

  # Try to exploit the issue to read a file.
  #
  # nb: Horde 3.x uses "/services"; Horde 2.x, "/util".
  foreach subdir (make_list("/services", "/util"))
  {
    r = http_send_recv3(method:"GET", 
      item:string(
        dir, subdir, "/go.php?",
        "url=", urlencode(str:string("http://www.example.com/;url=", xss))
      ), 
      port:port
    );
    if (isnull(r)) exit(0);
    res = strcat(r[0], r[1], '\r\n', r[2]);

    # There's a problem if our XSS appears in the redirect.
    if (string("Refresh: 0; URL=http://www.example.com/;url=", xss) >< res)
    {
      security_warning(port);
      set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
      exit(0);
    }
  }
}
