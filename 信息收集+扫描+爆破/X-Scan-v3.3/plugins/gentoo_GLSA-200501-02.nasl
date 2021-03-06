# This script was automatically generated from 
#  http://www.gentoo.org/security/en/glsa/glsa-200501-02.xml
# It is released under the Nessus Script Licence.
# The messages are release under the Creative Commons - Attribution /
# Share Alike license. See http://creativecommons.org/licenses/by-sa/2.0/
#
# Avisory is copyright 2001-2006 Gentoo Foundation, Inc.
# GLSA2nasl Convertor is copyright 2004-2009 Tenable Network Security, Inc.

if (! defined_func('bn_random')) exit(0);

include('compat.inc');

if (description)
{
 script_id(16393);
 script_version("$Revision: 1.7 $");
 script_xref(name: "GLSA", value: "200501-02");
 script_cve_id("CVE-2004-1170", "CVE-2004-1377");

 script_set_attribute(attribute:'synopsis', value: 'The remote host is missing the GLSA-200501-02 security update.');
 script_set_attribute(attribute:'description', value: 'The remote host is affected by the vulnerability described in GLSA-200501-02
(a2ps: Multiple vulnerabilities)


    Javier Fernandez-Sanguino Pena discovered that the a2ps package
    contains two scripts that create insecure temporary files (fixps and
    psmandup). Furthermore, we fixed in a previous revision a vulnerability
    in a2ps filename handling (CAN-2004-1170).
  
Impact

    A local attacker could create symbolic links in the temporary files
    directory, pointing to a valid file somewhere on the filesystem. When
    fixps or psmandup is executed, this would result in the file being
    overwritten with the rights of the user running the utility. By
    enticing a user or script to run a2ps on a malicious filename, an
    attacker could execute arbitrary commands on the system with the rights
    of that user or script.
  
Workaround

    There is no known workaround at this time.
  
');
script_set_attribute(attribute:'solution', value: '
    All a2ps users should upgrade to the latest version:
    # emerge --sync
    # emerge --ask --oneshot --verbose ">=app-text/a2ps-4.13c-r2"
  ');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:N/AC:L/Au:N/C:C/I:C/A:C');
script_set_attribute(attribute: 'see_also', value: 'http://secunia.com/advisories/13641/');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CAN-2004-1170');
script_set_attribute(attribute: 'see_also', value: 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2004-1377');
script_set_attribute(attribute: 'see_also', value: 'http://lists.netsys.com/pipermail/full-disclosure/2004-August/025678.html');

script_set_attribute(attribute: 'see_also', value: 'http://www.gentoo.org/security/en/glsa/glsa-200501-02.xml');

script_end_attributes();

 script_copyright(english: "(C) 2009 Tenable Network Security, Inc.");
 script_name(english: '[GLSA-200501-02] a2ps: Multiple vulnerabilities');
 script_category(ACT_GATHER_INFO);
 script_family(english: "Gentoo Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys('Host/Gentoo/qpkg-list');
 script_summary(english: 'a2ps: Multiple vulnerabilities');
 exit(0);
}

include('qpkg.inc');

if ( ! get_kb_item('Host/Gentoo/qpkg-list') ) exit(1, 'No list of packages');
if (qpkg_check(package: "app-text/a2ps", unaffected: make_list("ge 4.13c-r2"), vulnerable: make_list("lt 4.13c-r2")
)) { security_hole(0); exit(0); }
exit(0, "Host is not affected");
