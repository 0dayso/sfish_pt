#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if(description)
{
 script_id(11431);
 script_version("$Revision: 1.9 $");

 script_name(english:"XoloX Detection");
 script_summary(english:"Determines if XoloX is installed");

 script_set_attribute(
   attribute:"synopsis",
   value:"The remote host is running P2P software."
 );
 script_set_attribute(
   attribute:"description", 
   value:string(
     "The remote host is using XoloX, a P2P program which may not be\n",
     "suitable for a business environment."
   )
 );
 script_set_attribute(
   attribute:"solution", 
   value:string(
     "Make sure that use of this software agrees with your organization's\n",
     "security policy."
   )
 );
 script_set_attribute(
   attribute:"risk_factor",
   value:"None"
 );
 script_end_attributes();
 
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 script_family(english:"Peer-To-Peer File Sharing");
 
 script_dependencies("smb_hotfixes.nasl");
 script_require_keys("SMB/Registry/Enumerated");
 script_require_ports(139, 445);
 exit(0);
}


if ( ! get_kb_item("SMB/Registry/Enumerated") ) exit(1);

key = "SMB/Registry/HKLM/SOFTWARE/Microsoft/Windows/CurrentVersion/Uninstall/XoloX/DisplayName";

if (get_kb_item (key))
  security_note(get_kb_item("SMB/transport"));
