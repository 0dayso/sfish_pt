#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(39494);
  script_version("$Revision: 1.3 $");

  script_cve_id(
    "CVE-2009-1307",
    "CVE-2009-1311",
    "CVE-2009-1392",
    "CVE-2009-1832",
    "CVE-2009-1833",
    "CVE-2009-1835",
    "CVE-2009-1836",
    "CVE-2009-1838",
    "CVE-2009-1841",
    "CVE-2009-2210"
  );
  script_bugtraq_id(
    34656,
    35370,
    35371,
    35372,
    35373, 
    35383,
    35461
  );
  script_xref(name:"OSVDB", value:"55532");
  script_xref(name:"Secunia", value:"35439");

  script_name(english:"SeaMonkey < 1.1.17 Multiple Vulnerabilities");
  script_summary(english:"Checks version of SeaMonkey");

  script_set_attribute(attribute:"synopsis", value:
"A web browser on the remote host is affected by multiple
vulnerabilities." );

  script_set_attribute(attribute:"description", value:
"The installed version of SeaMonkey is earlier than 1.1.17.  Such
versions are potentially affected by the following security issues :

  - When an Adobe Flash file is loaded via the
    'view-source:' scheme, the Flash plugin misinterprets
    the origin of the content as localhost. An attacker can
    leverage this to launch cross-site request forger
    attacks. It is also possible to exploit this to place
    cookie-like objects on victim's computers.
    (MFSA 2009-17)

  - An information disclosure vulnerability exists when
    saving the inner frame of a web page as a file when the
    outer page has POST data associated with it.
    (MFSA 2009-21)

  - Multiple memory corruption vulnerabilities could
    potentially be exploited to execute arbitrary code.
    (MFSA 2009-24)

  - It may be possible for local resources loaded via
    'file:' protocol to access any domain's cookies saved
    on a user's system. (MFSA 2009-26)

  - It may be possible to tamper with SSL data via non-200
    responses to proxy CONNECT requests. (MFSA 2009-27)

  - If the owner document of an element becomes null after
    garbage collection, then it may be possible to execute
    the event listeners within the wrong JavaScript context.
    An attacker can potentially exploit this vulnerability
    to execute arbitrary JavaScript with chrome privileges.
    (MFSA 2009-29)

  - It may be possible for scripts from page content to
    run with elevated privileges. (MFSA 2009-32)

  - It may be possible to crash SeaMonkey while viewing
    'multipart/alternative' mail message with a
    'text/enhanced' part. (MFSA 2009-33)" );

  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-17.html" );
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-21.html" );
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-24.html" );
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-26.html" );
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-27.html" );
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-29.html" );
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-32.html" );
  script_set_attribute(attribute:"see_also", value:"http://www.mozilla.org/security/announce/2009/mfsa2009-33.html" );
  script_set_attribute(attribute:"solution", value:
"Upgrade to SeaMonkey 1.1.17 or later." );

  script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );

  script_end_attributes();
 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");
 
  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 
  script_dependencies("mozilla_org_installed.nasl");
  script_require_keys("SeaMonkey/Version");

  exit(0);
}

include("misc_func.inc");

ver = read_version_in_kb("SeaMonkey/Version");
if (isnull(ver)) exit(0);

if (
  ver[0] < 1 ||
  (
    ver[0] == 1 && 
    (
      ver[1] == 0 ||
      (ver[1] == 1 && ver[2] < 17)
    )
  )
) security_hole(get_kb_item("SMB/transport"));
