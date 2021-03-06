#
# (C) Tenable Network Security
#
# This plugin text was extracted from SuSE Security Advisory SUSE-SA:2006:046
#


if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(24426);
 script_version ("$Revision: 1.4 $");
 
 name["english"] = "SUSE-SA:2006:046: clamav";
 
 script_name(english:name["english"]);
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host is missing a vendor-supplied security patch" );
 script_set_attribute(attribute:"description", value:
"The remote host is missing the patch for the advisory SUSE-SA:2006:046 (clamav).


Damian Put discovered a bug in the UPX decoder used for scanning UPX
compressed Windows executables. The bug allows for a heap buffer
overflow and may potentially be exploitable to execute arbitrary
code. ClamAV has been version updated to version 0.88.4 in order to
fix this problem." );
 script_set_attribute(attribute:"solution", value:
"http://www.novell.com/linux/security/advisories/2006_46_clamav.html" );
 script_set_attribute(attribute:"risk_factor", value:"Medium" );



 script_end_attributes();

 
 summary["english"] = "Check for the version of the clamav package";
 script_summary(english:summary["english"]);
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2007 Tenable Network Security");
 family["english"] = "SuSE Local Security Checks";
 script_family(english:family["english"]);
 
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");
if ( rpm_check( reference:"clamav-0.88.4-0.1", release:"SUSE10.0") )
{
 security_warning(0);
 exit(0);
}
if ( rpm_check( reference:"clamav-0.88.4-0.1", release:"SUSE9.2") )
{
 security_warning(0);
 exit(0);
}
if ( rpm_check( reference:"clamav-0.88.4-0.1", release:"SUSE9.3") )
{
 security_warning(0);
 exit(0);
}
