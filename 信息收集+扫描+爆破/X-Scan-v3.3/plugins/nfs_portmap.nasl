#
# (C) Tenable Network Security, Inc.
#

include( 'compat.inc' );

if(description)
{
  script_id(11358);
  script_version ("$Revision: 1.9 $");
  script_cve_id("CVE-1999-0168");
  script_xref(name:"OSVDB", value:"11540");

  script_name(english:"NFS portmapper localhost Mount Request Restricted Host Access");
  script_summary(english:"Checks for the portmapper proxying NFS");

  script_set_attribute(
    attribute:'synopsis',
    value:'The remote service is vulnerable to an access control breach.'
  );

  script_set_attribute(
    attribute:'description',
    value:"The remote RPC portmapper forwards NFS requests made to it.

An attacker may use this flaw to make NFS mount requests which will appear
to come from localhost and therefore override the ACLs set up for NFS."
  );

  script_set_attribute(
    attribute:'solution',
    value: "Contact your vendor for the appropriate patches."
  );

  script_set_attribute(
    attribute:'cvss_vector',
    value:'CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P'
  );

  script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
  script_family(english:"RPC");
  script_dependencie("rpc_portmap.nasl", "showmount.nasl");
  script_require_keys("rpc/portmap");
  exit(0);
}


include("misc_func.inc");
include("nfs_func.inc");
include("byte_func.inc");


list = get_kb_list("nfs/exportlist");
if(isnull(list))exit(0);
shares = make_list(list);


port = get_rpc_port(program:100005, protocol:IPPROTO_UDP);
if ( ! port ) exit(0);
soc = open_priv_sock_udp(dport:port);

if(!soc)exit(0);

foreach share (shares)
{
 fid = nfs_mount(soc:soc, share:share);
 if(fid)
 {
  nfs_umount(soc:soc, share:share);
 }
 else {
  close(soc);
  port = get_kb_item("rpc/portmap");
  if(!port)port = 111;

  soc = open_priv_sock_udp(dport:port);
  req = rpclong(val:rand()) +		# XID
  	rpclong(val:0) +		# Msg type: Call
	rpclong(val:2) +		# RPC version : 2
	rpclong(val:100000) +		# Program : Portmap
	rpclong(val:2) +		# Program version : 2
	rpclong(val:5) +		# Procedure : CALLIT
	rpclong(val:0) +		# Credentials
	rpclong(val:0) +		#
	rpclong(val:0) +		# Verifier
	rpclong(val:0) +		#----------------
	rpclong(val:100005) +		# Program: mount
	rpclong(val:1) +		# Version: 1
	rpclong(val:1) +		# Procedure : 1 (MNT)
	rpclong(val:strlen(share) + padsz(len:strlen(share)) + 4 ) + # Arg length
	rpclong(val:strlen(share)) +	# Argument
	share +
	rpcpad(pad:padsz(len:strlen(share)));

  send(socket:soc, data:req);
  r = recv(socket:soc, length:4096);
  if(!r)exit(0);
  if(strlen(r) > 16 && getdword(blob:r, pos:4) == 1 && # Reply
		       getdword(blob:r, pos:8) == 0 ) # Reply state should be 0 (accepted)

  {
   security_hole(port);
   exit(0);
  }
 }
}
