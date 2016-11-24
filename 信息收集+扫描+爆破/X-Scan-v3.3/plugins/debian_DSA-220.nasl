# This script was automatically generated from the dsa-220
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15057);
 script_version("$Revision: 1.9 $");
 script_xref(name: "DSA", value: "220");
 script_cve_id("CVE-2002-1341");
 script_bugtraq_id(6302);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-220 security update');
 script_set_attribute(attribute: 'description', value:
'A cross site scripting vulnerability has been discovered in
squirrelmail, a feature-rich webmail package written in PHP4.
Squirrelmail doesn\'t sanitize user provided variables in all places,
leaving it vulnerable to a cross site scripting attack.
For the current stable distribution (woody) this problem has been
fixed in version 1.2.6-1.3.  The old stable distribution (potato) is
not affected since it doesn\'t contain a squirrelmail package.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2003/dsa-220');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your squirrelmail package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA220] DSA-220-1 squirrelmail");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-220-1 squirrelmail");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'squirrelmail', release: '3.0', reference: '1.2.6-1.3');
if (deb_report_get()) security_warning(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
