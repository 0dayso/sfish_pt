#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(40802);
  script_version("$Revision: 1.2 $");

  script_cve_id("CVE-2008-2549", "CVE-2008-2992", "CVE-2008-4812", "CVE-2008-4813",
                "CVE-2008-4814", "CVE-2008-4816", "CVE-2008-4817", "CVE-2008-5364");
  script_bugtraq_id(29420, 30035, 32100, 32103, 32105);
  script_xref(name:"OSVDB", value:"46211");
  script_xref(name:"OSVDB", value:"49520");
  script_xref(name:"OSVDB", value:"49541");
  script_xref(name:"OSVDB", value:"50243");
  script_xref(name:"OSVDB", value:"50245");
  script_xref(name:"OSVDB", value:"50246");
  script_xref(name:"OSVDB", value:"50247");
  script_xref(name:"OSVDB", value:"50639");
  script_xref(name:"Secunia", value:"29773");

  script_name(english:"Adobe Acrobat < 8.1.3 Multiple Vulnerabilities");
  script_summary(english:"Checks version of Adobe Acrobat");

  script_set_attribute(
    attribute:"synopsis",
    value:string(
      "The version of Adobe Acrobat on the remote Windows host is affected by\n",
      "multiple vulnerabilities."
    )
  );

 script_set_attribute(
    attribute:"description",
    value:"The version of Adobe Acrobat installed on the remote host is earlier
than 9.0 / 8.1.3.  Such versions are reportedly affected by multiple
vulnerabilities :

  - There is a published denial of service issue.
    (CVE-2008-2549)

  - A stack-based buffer overflow when parsing format
    strings containing a floating point specifier in the
    'util.printf()' JavaScript function may allow an
    attacker to execute arbitrary code. (CVE-2008-2992)

  - Multiple input validation errors could lead to code
    execution. (CVE-2008-4812)

  - Multiple input validation issues could lead to remote
    code execution. (CVE-2008-4813)

  - A heap corruption vulnerability in an AcroJS function
    available to scripting code inside of a PDF document
    could lead to remote code execution. (CVE-2008-4817)

  - An input validation issue in the Download Manager used
    by Adobe Acrobat could lead to remote code execution
    during the download process. (CVE-2008-5364)

  - An issue in the Download Manager used by Adobe Acrobat
    could lead to a user's Internet Security options being
    changed during the download process. (CVE-2008-4816)

  - An input validation issue in a JavaScript method could
    lead to remote code execution. (CVE-2008-4814)"
  );

  script_set_attribute(
    attribute:"see_also",
    value:"http://www.adobe.com/support/security/bulletins/apsb08-19.html"
  );

  script_set_attribute(
    attribute:"solution",
    value: "Upgrade to Adobe Acrobat 9.0 / 8.1.3 or later."
  );

  script_set_attribute(
     attribute:"cvss_vector",
     value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C"
  );

  script_set_attribute( attribute:'vuln_publication_date', value:'2008/05/29' );
  script_set_attribute( attribute:'patch_publication_date', value:'2008/11/04' );
  script_set_attribute( attribute:'plugin_publication_date', value:'2009/08/28' );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");

  script_dependencies("adobe_acrobat_installed.nasl");
  script_require_keys("SMB/Acrobat/Version");

  exit(0);
}

include("global_settings.inc");

version = get_kb_item("SMB/Acrobat/Version");
if (isnull(version)) exit(1, "The 'SMB/Acrobat/Version' KB item is missing.");

if (
  version =~ "^[0-6]\." ||
  version =~ "^7\.(0\.|1\.0\.)" ||
  version =~ "^8\.(0\.|1\.[0-2][^0-9.]?)"
)
{
  version_ui = get_kb_item("SMB/Acrobat/Version_UI");
  if (report_verbosity > 0 && version_ui)
  {
    path = get_kb_item("SMB/Acrobat/Path");
    if (isnull(path)) path = "n/a";

    report = string(
      "\n",
      "  Path              : ", path, "\n",
      "  Installed version : ", version_ui, "\n",
      "  Fix               : 9.0 / 8.1.3\n"
    );
    security_hole(port:get_kb_item("SMB/transport"), extra:report);
  }
  else security_hole(get_kb_item("SMB/transport"));
}
else exit(0, "Acrobat "+version+" is not affected.");
