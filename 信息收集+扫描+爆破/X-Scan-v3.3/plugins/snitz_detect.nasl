#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if (description)
{
  script_id(40469);
  script_version("$Revision: 1.2 $");

  script_name(english:"Snitz Forums 2000 Detection");
  script_summary(english:"Looks for evidence of Snitz");

  script_set_attribute(
    attribute:"synopsis",
    value:"An ASP-based forum is running on the remote web server."
  );
  script_set_attribute(
    attribute:"description",
    value:string(
      "Snitz Forums 2000, a free discussion forum application written in\n",
      "ASP, was detected on the remote host."
    )
  );
  script_set_attribute(
    attribute:"see_also",
    value:"http://forum.snitz.com/"
  );
  script_set_attribute(
    attribute:"solution",
    value:"n/a"
  );
  script_set_attribute(
    attribute:"risk_factor",
    value:"None"
  );
  script_set_attribute(
    attribute:"plugin_publication_date", 
    value:"2009/08/03"
  );
  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80);
if (!can_host_asp(port:port))
  exit(0, "The web server is not capable of hosting ASP applications.");

dirs = cgi_dirs();
if (thorough_tests) dirs = list_uniq(make_list(dirs, '/forum'));

# Versions usually look like '3.4.07', but some look like 'v3rc2'
pattern = '<acronym title="Powered By: Snitz Forums 2000 Version ([a-z0-9.]+)">';

installs = make_array();

# Looks for evidence of Snitz in all CGI dirs
foreach dir (dirs)
{
  url = string(dir, '/default.asp');
  res = http_get_cache(item:url, port:port);
  if (isnull(res)) exit(1, "Unable to get default.asp.");

  match = eregmatch(string:res, pattern:pattern, icase:TRUE);
  if (match)
  {
    ver = match[1];

    if (dir == "") dir = "/";
    set_kb_item(
      name:string("www/", port, "/snitz"),
      value:string(ver, " under ", dir)
    );
    if (installs[ver]) installs[ver] += ';' + dir;
    else installs[ver] = dir;

  }

  # Scan for multiple installations only if "Thorough Tests" is checked.
  if (max_index(keys(installs)) && !thorough_tests) break;
}

# Report findings.
if (max_index(keys(installs)))
{
  if (report_verbosity > 0)
  {
    info = "";
    n = 0;
    foreach ver (sort(keys(installs)))
    {
      info += '  Version : ' + ver + '\n';
      foreach dir (sort(split(installs[ver], sep:";", keep:FALSE)))
      {
        if (dir == '/') url = dir;
        else url = dir + '/';
        info += '  URL     : ' + build_url(port:port, qs:url) + '\n';
        n++;
      }
      info += '\n';
    }

    report = '\nThe following instance';
    if (n == 1) report += ' of Snitz Forums 2000 was';
    else report += 's of Snitz Forums 2000 were';
    report += ' detected on the remote host :\n\n' + info;

    security_note(port:port, extra:report);
  }
  else security_note(port);
}
else exit(0, 'Snitz Forums 2000 was not detected on port ' + port + '.');
