#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(14830);
 script_cve_id("CVE-2004-1554");
 script_bugtraq_id(11260);
 script_xref(name:"OSVDB", value:"10375");
 script_xref(name:"Secunia", value:"12679");
 script_version ("$Revision: 1.12 $");
 script_name(english:"@lex Guestbook livre_include.php chem_absolu Parameter Remote File Inclusion");
 script_summary(english:"Checks for @lex guestbook");

 script_set_attribute(attribute:"synopsis", value:
"The remote host is running a web application that is affected by a
remote file inclusion vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host seems to be running @lex guestbook, a guestbook web
application written in PHP.

The reported version is prone to a vulnerability that may permit
remote attackers, without prior authentication, to include and execute
malicious PHP scripts. By modifying the 'chem_absolu' parameter of the
'livre_include.php' script, it is possible to cause arbitrary PHP code
to be executed on the remote system." );
 script_set_attribute(attribute:"see_also", value:"http://www.securityfocus.com/archive/1/376627/30/0/threaded" );
 script_set_attribute(attribute:"solution", value:
"There is no known solution at this time." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
 script_category(ACT_ATTACK);
 
 script_copyright(english:"This script is Copyright (C) 2004-2009 Tenable Network Security, Inc.");
 script_family(english:"CGI abuses");
 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_exclude_keys("Settings/disable_cgi_scanning");
 exit(0);
}

#
# The script code starts here
#
include("global_settings.inc");
include("misc_func.inc");
include("http.inc");

port = get_http_port(default:80);
if (!can_host_php(port:port)) exit(0);

function check(dir)
{
  local_var r, w;
  w = http_send_recv3(method:"GET", item:dir + "/livre_include.php?no_connect=lol&chem_absolu=http://xxxxxx./", port:port);
  if (isnull(w)) exit(0);
  r = strcat(w[0], w[1], '\r\n', w[2]);

  if ("http://xxxxxx./config/config" >< r )
	{ 
 			security_hole(port);
			exit(0);
    	}
 
}

foreach dir (cgi_dirs())
{
 check(dir:dir);
}
