#
#  This script was written by David Maciejak <david dot maciejak at kyxar dot fr>
#  This script is released under the GNU GPL v2
#

# Changes by Tenable:
# - Revised plugin title, family change, output formatting (9/3/09)

include("compat.inc");

if(description)
{
 script_id(17368);
 script_version("$Revision: 1.4 $");
 
  script_name(english:"WebShield Appliance Detection");

  script_set_attribute(
    attribute:"synopsis",
    value:"The remote host is a web security appliance."
  );
  script_set_attribute(
    attribute:"description",
    value:
"The remote host appears to be a WebShield appliance.  Connections are
allowed to the management console.  A remote attacker could exploit
this to gather information which could be used to mount further
attacks."
  );
  script_set_attribute(
    attribute:"solution",
    value:"Filter incoming traffic to this port."
  );
  script_set_attribute(
    attribute:"risk_factor",
    value:"None"
  );
  script_end_attributes();

 script_summary(english:"Checks for WebShield Appliance console management");
 script_category(ACT_GATHER_INFO);
 script_copyright(english:"This script is Copyright (C) 2005-2009 David Maciejak");
 script_family(english:"CGI abuses");
 script_dependencie("http_version.nasl");

 script_require_ports(443);
 exit(0);
}

#
# The script code starts here
#
include("http_func.inc");

function https_get(port, request)
{
    local_var result, soc;

    if(get_port_state(port))
    {

         soc = open_sock_tcp(port, transport:ENCAPS_SSLv23);
         if(soc)
         {
            send(socket:soc, data:string(request,"\r\n"));
            result = http_recv(socket:soc);
            close(soc);
            return(result);
         }
    }
}

port = 443;
if(get_port_state(port))
{
 req1=http_get(item:"/strings.js", port:port);
 if ( "Server: WebShield Appliance" >< req1 )
 {
  req = https_get(request:req1, port:port);
  #var WEBSHIELD_TITLE="WebShield Appliance v3.0";

  title = egrep(pattern:"WEBSHIELD_TITLE=", string:req);
  if ( ! title ) exit(0);
  vers = ereg_replace(pattern:".*WEBSHIELD_TITLE=.([a-zA-Z0-9. ]+).*", string:title, replace:"\1", icase:TRUE);
  if ( vers == title ) exit(0); 
  
  security_note(port);
  }
}
