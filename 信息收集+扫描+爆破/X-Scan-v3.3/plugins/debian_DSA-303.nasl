# This script was automatically generated from the dsa-303
# Debian Security Advisory
# It is released under the Nessus Script Licence.
# Advisory is copyright 1997-2009 Software in the Public Interest, Inc.
# See http://www.debian.org/license
# DSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description) {
 script_id(15140);
 script_version("$Revision: 1.11 $");
 script_xref(name: "DSA", value: "303");
 script_cve_id("CVE-2003-0073", "CVE-2003-0150");
 script_bugtraq_id(7052);

 script_set_attribute(attribute:'synopsis', value: 
'The remote host is missing the DSA-303 security update');
 script_set_attribute(attribute: 'description', value:
'CVE-2003-0073: The mysql package contains a bug whereby dynamically
allocated memory is freed more than once, which could be deliberately
triggered by an attacker to cause a crash, resulting in a denial of
service condition.  In order to exploit this vulnerability, a valid
username and password combination for access to the MySQL server is
required.
CVE-2003-0150: The mysql package contains a bug whereby a malicious
user, granted certain permissions within mysql, could create a
configuration file which would cause the mysql server to run as root,
or any other user, rather than the mysql user.
For the stable distribution (woody) both problems have been fixed in
version 3.23.49-8.4.
The old stable distribution (potato) is only affected by
CVE-2003-0150, and this has been fixed in version 3.22.32-6.4.
');
 script_set_attribute(attribute: 'see_also', value: 
'http://www.debian.org/security/2003/dsa-303');
 script_set_attribute(attribute: 'solution', value: 
'Read http://www.debian.org/security/2003/dsa-303
and install the recommended updated packages.');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:S/C:C/I:C/A:C');
script_end_attributes();

 script_copyright(english: "This script is (C) 2009 Tenable Network Security, Inc.");
 script_name(english: "[DSA303] DSA-303-1 mysql");
 script_category(ACT_GATHER_INFO);
 script_family(english: "Debian Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/Debian/dpkg-l");
 script_summary(english: "DSA-303-1 mysql");
 exit(0);
}

include("debian_package.inc");

if ( ! get_kb_item("Host/Debian/dpkg-l") ) exit(1, "Could not obtain the list of packages");

deb_check(prefix: 'mysql-client', release: '2.2', reference: '3.22.32-6.4');
deb_check(prefix: 'mysql-doc', release: '2.2', reference: '3.22.32-6.4');
deb_check(prefix: 'mysql-server', release: '2.2', reference: '3.22.32-6.4');
deb_check(prefix: 'libmysqlclient10', release: '3.0', reference: '3.23.49-8.4');
deb_check(prefix: 'libmysqlclient10-dev', release: '3.0', reference: '3.23.49-8.4');
deb_check(prefix: 'mysql-client', release: '3.0', reference: '3.23.49-8.4');
deb_check(prefix: 'mysql-common', release: '3.0', reference: '3.23.49-8.4');
deb_check(prefix: 'mysql-doc', release: '3.0', reference: '3.23.49-8.4');
deb_check(prefix: 'mysql-server', release: '3.0', reference: '3.23.49-8.4');
deb_check(prefix: 'mysql', release: '3.0', reference: '3.23.49-8.4');
if (deb_report_get()) security_hole(port: 0, extra:deb_report_get());
else exit(0, "Host is not affected");
