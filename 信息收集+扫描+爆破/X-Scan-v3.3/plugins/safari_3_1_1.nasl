#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(31993);
  script_version("$Revision: 1.3 $");

  script_cve_id(
    "CVE-2007-2398",
    "CVE-2008-1024",
    "CVE-2008-1025",
    "CVE-2008-1026"
  );
  script_bugtraq_id(24484, 28813, 28814, 28815);
  script_xref(name:"OSVDB", value:"38862");
  script_xref(name:"OSVDB", value:"43980");
  script_xref(name:"Secunia", value:"29846");

  script_name(english:"Safari < 3.1.1 Multiple Vulnerabilities");
  script_summary(english:"Checks version number of Safari");

 script_set_attribute(attribute:"synopsis", value:
"The remote host contains a web browser that is affected by several
issues." );
 script_set_attribute(attribute:"description", value:
"The version of Safari installed on the remote host reportedly is
affected by several issues :

  - A malicious website can spoof window titles and URL bars
    (CVE-2007-2398).

  - A memory corruption issue in the file downloading
    capability could lead to a crash or arbitrary code
    execution (CVE-2008-1024).

  - A cross-site scripting vulnerability exists in WebKit's
    handling of URLs that contain a colon character in
    the host name (CVE-2008-1025).

  - A heap buffer overflow exists in WebKit's handling of
    JavaScript regular expressions (CVE-2008-1026)." );
 script_set_attribute(attribute:"see_also", value:"http://support.apple.com/kb/HT1467" );
 script_set_attribute(attribute:"see_also", value:"http://lists.apple.com/archives/security-announce/2008/Apr/msg00001.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Safari 3.1.1 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );
script_end_attributes();


  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("safari_installed.nasl");
  script_require_keys("SMB/Safari/FileVersion");

  exit(0);
}


include("global_settings.inc");


ver = get_kb_item("SMB/Safari/FileVersion");
if (isnull(ver)) exit(0);

iver = split(ver, sep:'.', keep:FALSE);
for (i=0; i<max_index(iver); i++)
  iver[i] = int(iver[i]);

if (
  iver[0] < 3 ||
  (
    iver[0] == 3 &&
    (
      iver[1] < 525 ||
      (iver[1] == 525 && iver[2] < 17)
    )
  )
)
{
  if (report_verbosity)
  {
    prod_ver = get_kb_item("SMB/Safari/ProductVersion");
    if (!isnull(prod_ver)) ver = prod_ver;

    report = string(
      "\n",
      "Safari version ", ver, " is currently installed on the remote host.\n"
    );
    security_hole(port:get_kb_item("SMB/transport"), extra:report);
  }
  else security_hole(get_kb_item("SMB/transport"));
}
