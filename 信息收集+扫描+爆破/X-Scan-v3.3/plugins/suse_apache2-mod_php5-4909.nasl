
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(30092);
 script_version ("$Revision: 1.2 $");
 script_name(english: "SuSE Security Update:  php5 security upgrade to 5.2.5 (apache2-mod_php5-4909)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch apache2-mod_php5-4909");
 script_set_attribute(attribute: "description", value: "This update fixes multiple bugs in php by upgrading it to
version 5.2.5.

- Flaws in processing multi byte sequences in
  htmlentities/htmlspecialchars (CVE-2007-5898)

- overly long arguments to the dl() function could crash
  php (CVE-2007-4825)

- overy long arguments to the glob() function could crash
  php (CVE-2007-4782)

- overly long arguments to some iconv functions could crash
  php (CVE-2007-4840)

- overy long arguments to the setlocale() function could
  crash php (CVE-2007-4784)

- the wordwrap-Function could cause a floating point
  exception (CVE-2007-3998)

- overy long arguments to the fnmatch() function could
  crash php (CVE-2007-4782)

- incorrect size calculation in the chunk_split function
  could lead to a buffer overflow (CVE-2007-4661,
  CVE-2007-2872)

- Flaws in the GD extension could lead to integer overflows
  (CVE-2007-3996)

- The money_format function contained format string flaws
  (CVE-2007-4658)

- Data for some time zones has been updated

- php5 has been updated to version 5.2.5 to fix those
  problems
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C");
script_set_attribute(attribute: "solution", value: "Install the security patch apache2-mod_php5-4909");
script_end_attributes();

script_cve_id("CVE-2007-5898", "CVE-2007-4825", "CVE-2007-4782", "CVE-2007-4840", "CVE-2007-4784", "CVE-2007-3998", "CVE-2007-4782", "CVE-2007-4661", "CVE-2007-2872", "CVE-2007-3996", "CVE-2007-4658");
script_summary(english: "Check for the apache2-mod_php5-4909 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");
if ( rpm_check( reference:"apache2-mod_php5-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-bcmath-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-bz2-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-calendar-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-ctype-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-curl-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-dba-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-dbase-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-devel-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-dom-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-exif-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-fastcgi-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-ftp-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-gd-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-gettext-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-gmp-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-hash-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-iconv-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-imap-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-json-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-ldap-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-mbstring-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-mcrypt-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-mhash-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-mysql-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-ncurses-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-odbc-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-openssl-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-pcntl-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-pdo-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-pear-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-pgsql-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-posix-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-pspell-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-shmop-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-snmp-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-soap-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-sockets-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-sqlite-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-suhosin-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-sysvmsg-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-sysvsem-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-sysvshm-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-tidy-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-tokenizer-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-wddx-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-xmlreader-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-xmlrpc-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-xmlwriter-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-xsl-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-zip-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"php5-zlib-5.2.5-18.1", release:"SUSE10.2") )
{
	security_hole(port:0, extra:rpm_report_get());
	exit(0);
}
exit(0,"Host is not affected");
