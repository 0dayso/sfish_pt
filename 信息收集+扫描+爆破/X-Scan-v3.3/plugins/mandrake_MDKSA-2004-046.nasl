
#
# (C) Tenable Network Security
#
# This plugin text was extracted from Mandrake Linux Security Advisory ADVISORY
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(14145);
 script_version ("$Revision: 1.8 $");
 script_name(english: "MDKSA-2004:046-1: apache-mod_perl");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory MDKSA-2004:046-1 (apache-mod_perl).");
 script_set_attribute(attribute: "description", value: "Four security vulnerabilities were fixed with the 1.3.31 release of
Apache. All of these issues have been backported and applied to the
provided packages. Thanks to Ralf Engelschall of OpenPKG for providing
the patches.
Apache 1.3 prior to 1.3.30 did not filter terminal escape sequences
from its error logs. This could make it easier for attackers to insert
those sequences into the terminal emulators of administrators viewing
the error logs that contain vulnerabilities related to escape sequence
handling (CVE-2003-0020).
mod_digest in Apache 1.3 prior to 1.3.31 did not properly verify the
nonce of a client response by using an AuthNonce secret. Apache now
verifies the nonce returned in the client response to check whether it
was issued by itself by means of a 'AuthDigestRealmSeed' secret exposed
as an MD5 checksum (CVE-2003-0987).
mod_acces in Apache 1.3 prior to 1.3.30, when running on big-endian
64-bit platforms, did not properly parse Allow/Deny rules using IP
addresses without a netmask. This could allow a remote attacker to
bypass intended access restrictions (CVE-2003-0993).
Apache 1.3 prior to 1.3.30, when using multiple listening sockets on
certain platforms, allows a remote attacker to cause a DoS by blocking
new connections via a short-lived connection on a rarely-accessed
listening socket (CVE-2004-0174). While this particular vulnerability
does not affect Linux, we felt it prudent to include the fix.
Update:
Due to the changes in mod_digest.so, mod_perl needed to be rebuilt
against the patched Apache packages in order for httpd-perl to
properly load the module. The appropriate mod_perl packages have
been rebuilt and are now available.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "see_also", value: "http://wwwnew.mandriva.com/security/advisories?name=MDKSA-2004:046-1");
script_set_attribute(attribute: "solution", value: "Apply the newest security patches from Mandriva.");
script_end_attributes();

script_cve_id("CVE-2003-0020", "CVE-2003-0987", "CVE-2003-0993", "CVE-2004-0174");
script_summary(english: "Check for the version of the apache-mod_perl package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "Mandriva Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Mandrake/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/Mandrake/rpm-list") ) exit(1, "Could not get the list of packages");

if ( rpm_check( reference:"HTML-Embperl-1.3.29_1.3.6-3.1.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"apache-mod_perl-1.3.29_1.29-3.1.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_perl-common-1.3.29_1.29-3.1.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_perl-devel-1.3.29_1.29-3.1.100mdk", release:"MDK10.0", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"HTML-Embperl-1.3.27_1.3.4-7.1.91mdk", release:"MDK9.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"apache-mod_perl-1.3.27_1.27-7.1.91mdk", release:"MDK9.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_perl-common-1.3.27_1.27-7.1.91mdk", release:"MDK9.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_perl-devel-1.3.27_1.27-7.1.91mdk", release:"MDK9.1", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"HTML-Embperl-1.3.28_1.3.4-1.1.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"apache-mod_perl-1.3.28_1.28-1.1.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_perl-common-1.3.28_1.28-1.1.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if ( rpm_check( reference:"mod_perl-devel-1.3.28_1.28-1.1.92mdk", release:"MDK9.2", yank:"mdk") )
{
 security_hole(port:0, extra:rpm_report_get());
 exit(0);
}
if (rpm_exists(rpm:"apache-mod_perl-", release:"MDK10.0")
 || rpm_exists(rpm:"apache-mod_perl-", release:"MDK9.1")
 || rpm_exists(rpm:"apache-mod_perl-", release:"MDK9.2") )
{
 set_kb_item(name:"CVE-2003-0020", value:TRUE);
 set_kb_item(name:"CVE-2003-0987", value:TRUE);
 set_kb_item(name:"CVE-2003-0993", value:TRUE);
 set_kb_item(name:"CVE-2004-0174", value:TRUE);
}
exit(0, "Host is not affected");
