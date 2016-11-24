# This script was automatically generated from the dsa-855
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(19963);
 script_version("$Revision: 1.7 $");
 script_xref(name: "DSA", value: "855");
 script_cve_id("CVE-2005-3150");

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-855 security update');
 script_set_attribute(attribute: 'description', value:
'Ulf H�rnhammar from the Debian Security Audit Project discovered a
format string vulnerability in weex, a non-interactive FTP client for
updating web pages, that could be exploited to execute arbitrary code
on the clients machine.
For the old stable distribution (woody) this problem has been fixed in
version 2.6.1-4woody2.
For the stable distribution (sarge) this problem has been fixed in
version 2.6.1-6sarge1.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2005/dsa-855');
 script_set_attribute(attribute: 'solution', value: 
'The Debian project recommends that you upgrade your weex package.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA855] DSA-855-1 weex");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-855-1 weex");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'weex', release: '3.0', reference: '2.6.1-4woody2');
deb_check(prefix: 'weex', release: '3.1', reference: '2.6.1-6sarge1');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
