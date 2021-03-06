
#
# (C) Tenable Network Security
#

if ( ! defined_func("bn_random") ) exit(0);

include("compat.inc");

if(description)
{
 script_id(16640);
 script_version ("$Revision: 1.7 $");
 script_name(english: "HP-UX Security patch : PHSS_29626");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing HP-UX PHSS_29626 security update");
 script_set_attribute(attribute: "description", value:
"X OV ITO7.1X Msg/Act Linux Agent A.07.20.1");
 script_set_attribute(attribute: "solution", value: "ftp://ftp.itrc.hp.com//superseded_patches/hp-ux_patches/s700_800/11.X/PHSS_29626");
 script_set_attribute(attribute: "risk_factor", value: "High");
 script_end_attributes();

 script_summary(english: "Checks for patch PHSS_29626");
 script_category(ACT_GATHER_INFO);
 script_copyright(english: "This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "HP-UX Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/HP-UX/swlist");
 exit(0);
}

include("hpux.inc");
if ( ! hpux_check_ctx ( ctx:"11.00 11.11 " ) )
{
 exit(0);
}

if ( hpux_patch_installed (patches:"PHSS_29626 PHSS_29643 PHSS_30204 PHSS_30548 PHSS_31006 PHSS_32099 PHSS_32893 PHSS_33692 PHSS_34381 PHSS_35072 PHSS_35836 ") )
{
 exit(0);
}

if ( hpux_check_patch( app:"OVOPC-CLT.OVOPC-LIN-CLT", version:"A.07.10") )
{
 security_hole(0);
 exit(0);
}
if ( hpux_check_patch( app:"OVOPC-CLT.OVOPC-LIN-CLT", version:"A.07.10") )
{
 security_hole(0);
 exit(0);
}
exit(0, "Host is not affected");
