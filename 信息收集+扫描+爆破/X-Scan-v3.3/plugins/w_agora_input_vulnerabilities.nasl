#
# (C) Tenable Network Security, Inc.
#

include( 'compat.inc' );

if (description) {
  script_id(15402);
  script_version("$Revision: 1.12 $");
  script_cve_id("CVE-2004-1562", "CVE-2004-1563", "CVE-2004-1564", "CVE-2004-1565");
  script_bugtraq_id(11283);
  script_xref(name:"OSVDB", value:"10457");
  script_xref(name:"OSVDB", value:"10458");
  script_xref(name:"OSVDB", value:"10459");
  script_xref(name:"OSVDB", value:"10460");
  script_xref(name:"OSVDB", value:"10461");
  script_xref(name:"OSVDB", value:"10462");

  script_name(english:"w-Agora 4.1.6a Multiple Input Validation Vulnerabilities");
	script_summary(english:"Checks for vulnerabilities in w-Agora");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote forum management software is vulnerable to multiple injection flaws.'
  );

  script_set_attribute(
    attribute:'description',
    value:"The remote host is running w-agora, a web-based forum management software
written in PHP.

There are multiple input validation flaws in the remote version of this
software :

- There is an SQL injection vulnerability in the file 'redir_url.php' which
may allow an attacker to execute arbitrary SQL statements in the remote
database ;

- There is a cross site scripting issue which may allow an attacker to
steal the cookies of the legitimate users of the remote site by sending them
a specially malformed link ;

- There is an HTTP response splitting vulnerability which may also allow
an attacker to perform cross-site scripting attacks against the remote host."
  );

  script_set_attribute(
    attribute:'solution',
    value: "Upgrade to the newest version of this software"
  );

  script_set_attribute(
    attribute:'see_also',
    value:'http://lists.grok.org.uk/pipermail/full-disclosure/2004-September/027040.html'
  );

  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P'
  );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
  script_family(english:"CGI abuses");
  script_dependencie("http_version.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");

  exit(0);
}

include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


function check(req)
{
  global_var	port;
  local_var	r, variables;
  variables = "loginuser=<script>foo</script>&loginpassword=foo&btnlogin=Login";
  r = http_send_recv3(method: "POST", port: port, item: req, version: 11, data: variables,
add_headers: make_array("Content-Type", "application/x-www-form-urlencoded"));

  if (isnull(r)) exit(0);

  if ( r[0] =~ "^HTTP/1\.[01] +200 " &&
       "<script>foo</script>" >< r[2] && "w-agora" >< r[2] )
  	{
	security_hole(port);
	set_kb_item(name: 'www/'+port+'/XSS', value: TRUE);
	set_kb_item(name: 'www/'+port+'/SQLInjection', value: TRUE);
	exit(0);
	}


 return(0);
}

port = get_http_port(default:80);
if(!can_host_php(port:port))exit(0);

foreach dir (cgi_dirs())
 {
  #if ( is_cgi_installed3(item:dir + "/login.php", port:port) )
   check(req:dir + "/login.php");
 }
