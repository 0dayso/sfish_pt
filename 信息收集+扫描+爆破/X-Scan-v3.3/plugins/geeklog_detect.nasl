#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");


if (description) 
{
  script_id(36143);
  script_version("$Revision: 1.2 $");

  script_name(english:"Geeklog Detection");
  script_summary(english:"Checks for Geeklog");
 
  script_set_attribute(
    attribute:"synopsis",
    value:"The remote web server contains a content management system written in PHP."
  );
  script_set_attribute(
    attribute:"description", 
    value:string(
      "The remote host is running Geeklog, an open source blog engine /\n",
      "content management system written in PHP."
    )
  );
  script_set_attribute(
    attribute:"see_also", 
    value:"http://www.geeklog.net/"
  );
  script_set_attribute(attribute:"risk_factor", value: "None");
  script_set_attribute(attribute:"solution", value: "n/a");
  script_end_attributes();
 
  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_category(ACT_GATHER_INFO);
  script_family(english:"CGI abuses");
 
  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80, embedded: 0);
if (!can_host_php(port:port)) exit(0);


# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/geeklog", cgi_dirs()));
else dirs = make_list(cgi_dirs());

installs = make_array();
foreach dir (dirs)
{
  # Grab index.php.
  res = http_get_cache(item:string(dir, "/index.php"), port:port);
  if (res == NULL) exit(0);

  # If it's Geeklog...
  if (
    '/backend/geeklog.rss" title="RSS Feed:' >< res ||
    '/webservices/atom/?introspection" title="Webservices">' >< res ||
    'Powered by <a href="http://www.geeklog.net/">Geeklog</a>&nbsp;<br>Created' >< res
  )
  {
    version = NULL;

    # Try to grab the version from the changelog.
    url = string(dir, "/docs/changes.html");
    res = http_send_recv3(method:"GET", item:url, port:port);
    if (isnull(res)) exit(0);

    if (
      "Geeklog Documentation - Changes</title>" >< res[2] &&
      '<h2><a name="changes' >< res[2]
    )
    {
      foreach line (split(res[2], keep:FALSE))
      {
        if ('<h2><a name="changes' >< line && ">Geeklog " >< line)
        {
          version = strstr(line, "Geeklog ") - "Geeklog ";
          version = version - strstr(version, '</a>');
          break;
        }
      }
    }

    # If still unknown, just mark it as "unknown".
    if (isnull(version)) version = "unknown";

    if (dir == "") dir = "/";
    set_kb_item(
      name:string("www/", port, "/geeklog"),
      value:string(version, " under ", dir)
    );
    if (installs[version]) installs[version] += ';' + dir;
    else installs[version] = dir;

    # Scan for multiple installations only if "Thorough Tests" is checked.
    if (!thorough_tests) break;
  }
}


# Report findings.
if (max_index(keys(installs)))
{
  if (report_verbosity > 0)
  {
    info = "";
    n = 0;
    foreach version (sort(keys(installs)))
    {
      info += '  Version : ' + version + '\n';
      foreach dir (sort(split(installs[version], sep:";", keep:FALSE)))
      {
        if (dir == '/') url = dir;
        else url = dir + '/';
        info += '  URL     : ' + build_url(port:port, qs:url) + '\n';
        n++;
      }
      info += '\n';
    }

    report = '\nThe following instance';
    if (n == 1) report += ' of Geeklog was';
    else report += 's of Geeklog were';
    report += ' detected on the remote host :\n\n' + info;

    security_note(port:port, extra:report);
  }
  else security_note(port);
}
