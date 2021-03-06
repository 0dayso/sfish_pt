#
# Copyright 2000 by Hendrik Scholz <hendrik@scholz.net>
#

# Changes by Tenable:
# - Revised plugin title, added OSVDB ref, reformatted description (4/3/2009)
# - Updated to use compat.inc, added CVSS score (11/20/2009)



include("compat.inc");

if(description)
{
 script_id(10415);
 script_version ("$Revision: 1.19 $");
 script_xref(name:"OSVDB", value:"53074");
 
 script_name(english:"Sambar Server /session/sendmail Arbitrary Mail Relay");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote host has an application that allows unauthorized mail
relaying." );
 script_set_attribute(attribute:"description", value:
"The Sambar webserver is running. It provides a web 
interface for sending emails. You may simply pass a POST request to 
/session/sendmail and by this send mails to anyone you want. Due to 
the fact that Sambar does not check HTTP referrers you do not need 
direct access to the server!" );
 script_set_attribute(attribute:"solution", value:
"Try to disable this module." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:N/I:P/A:N" );

script_end_attributes();

 
 script_summary(english:"Sambar /session/sendmail mailer installed ?");
 
 script_category(ACT_ATTACK);
 
 script_copyright(english:"This script is Copyright (C) 2000-2009 Hendrik Scholz");

 script_family(english:"CGI abuses");

 script_dependencie("find_service1.nasl", "http_version.nasl");
 script_require_ports("Services/www", 80);
 script_require_keys("www/sambar");
 exit(0);
}

#
# The script code starts here

include("http_func.inc");
include("http_keepalive.inc");

port = get_http_port(default:80);

if( is_cgi_installed_ka(port:port, item:"/session/sendmail") ) security_warning(port);
