# This script was automatically generated from the dsa-1643
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(34352);
 script_version("$Revision: 1.3 $");
 script_xref(name: "DSA", value: "1643");
 script_cve_id("CVE-2008-4440");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-1643 security update');
 script_set_attribute(attribute: 'description', value:
'Dmitry E. Oboukhov discovered that the "to-upgrade" plugin of Feta,
a simpler interface to APT, dpkg, and other Debian package tools
creates temporary files insecurely, which may lead to local denial
of service through symlink attacks.
For the stable distribution (etch), this problem has been fixed in
version 1.4.15+etch1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2008/dsa-1643');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your feta package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:L/Au:N/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA1643] DSA-1643-1 feta");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-1643-1 feta");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'feta', release: '4.0', reference: '1.4.15+etch1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
