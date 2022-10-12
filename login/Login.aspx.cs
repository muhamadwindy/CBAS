using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using DMS.Tools;
using System.DirectoryServices;
using System.Security.Cryptography;
using System.Xml;
using System.Text;
using System.DirectoryServices;
using UOBISecurity;
//AD
using System.DirectoryServices.Protocols;
using System.DirectoryServices;
using System.DirectoryServices.AccountManagement;
using System.Security.Principal;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Permissions;
using System.Runtime.InteropServices;
using Newtonsoft.Json;
using System.Data.SqlClient;
using Newtonsoft.Json.Linq;
using System.Text.RegularExpressions;

namespace MikroLogin
{
    public partial class Login : System.Web.UI.Page
    {
        private string connectionString;
        private int dbtimeout = 6000;
        private bool logon = false;
        private string hash_password;


        #region Variable AD
        WindowsImpersonationContext impersonatuser = null;
        [DllImport("advapi32.dll", SetLastError = true)]
        public static extern bool LogonUser(string lpszUsername, string lpszDomain, string lpszPassword, int dwLogonType, int dwLogonProvider, out IntPtr phToken);

        [DllImport("kernel32.dll")]
        public static extern int FormatMessage(int dwFlags, ref IntPtr lpSource, int dwMessageId, int dwLanguageId, ref String lpBuffer, int nSize, ref IntPtr Arguments);

        [DllImport("kernel32.dll", SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool CloseHandle(IntPtr hObject);
        
        public static string GetErrorMessage(int errorCode)
        {
            int FORMAT_MESSAGE_ALLOCATE_BUFFER = 0x100;
            int FORMAT_MESSAGE_IGNORE_INSERTS = 0x200;
            int FORMAT_MESSAGE_FROM_SYSTEM = 0x1000;

            int msgSize = 255;
            string lpMsgBuf = null;
            int dwFlags = FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS;

            IntPtr lpSource = IntPtr.Zero;
            IntPtr lpArguments = IntPtr.Zero;
            int returnVal = FormatMessage(dwFlags, ref lpSource, errorCode, 0, ref lpMsgBuf, msgSize, ref lpArguments);

            if (returnVal == 0)
            {
                throw new Exception("Failed to format message for error code " + errorCode.ToString() + ". ");
            }
            return lpMsgBuf;
        }        

        #endregion

        enum loginResult
        {
            logNotFound, logSuccess, logHasLogon, logLocked,
            logPwdExpired, logPwdEmpty, logPwdInvalid, logPwdDefault, logJustLocked,
            /* unimplemented */
            logUserExpired, logGrantInvalid,
            logAuthFail, logNoLOSAccess, logNoMenuAccess, logSessionLost, logReLogin, logUnknown
        }

        #region static area
        private static string Q_VWLOGIN = "exec SU_USERLOGINGIN @1, @2";
        private static string Q_CHECKREVOKE = "select SU_REVOKE from scalluserflag where USERID = @1 and SU_REVOKE = '1' ";
        private static string SP_TOKENDELETE = "exec ES_APPTOKEN_DELETE @1";
        private static string SP_USERACTIVITY = "exec SU_ALLUSERACTIVITY @1, @2, @3, @4, '1', @5, null, @6, @7 ";
        private static string SP_LOGINSTARTED = "exec SU_LOGINSTARTED @1, @2, @3 ";
        private static string SP_SAVETOKEN = "exec ES_SAVETOKEN @1, @2 ";

        public static string decryptConnStr(string encryptedConnStr)
        {
            string connStr, encpwd, decpwd = "";
            int pos1, pos2;
            pos1 = encryptedConnStr.IndexOf("pwd=");
            pos2 = encryptedConnStr.IndexOf(";", pos1 + 4);
            encpwd = encryptedConnStr.Substring(pos1 + 4, pos2 - pos1 - 4);
            for (int i = 2; i < encpwd.Length; i++)
            {
                char chr = (char)(encpwd[i] - 2);
                decpwd += new string(chr, 1);
            }
            connStr = encryptedConnStr.Replace(encpwd, decpwd);
            return connStr;
        }
        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            //dbtimeout = int.Parse(ConfigurationSettings.AppSettings["dbTimeOut"]);//1200;//
            if (!IsPostBack)
            {
                FormsAuthentication.SignOut();
                TXT_USERNAME.Text = (string)Session["UserID"];
                hash_password = (string)Session["sha1"];
                RemoveSession();
                if (Request.QueryString.Count != 0 && Request.QueryString[0] == "logon")
                {
                    if (hash_password != null)
                    {
                        logon = true;
                        BTN_SUBMIT_Click(null, null);
                        return;
                    }
                }
                if ((TXT_USERNAME.Text == null) || (TXT_USERNAME.Text == ""))
                    MyPage.SetFocus(this, TXT_USERNAME);
                else
                    MyPage.SetFocus(this, TXT_PASSWORD);
            }
            if (Request.QueryString.Count > 0)
            {
                if (Request.QueryString["msg"] != null && Request.QueryString["msg"] != "")
                    MyPage.popMessage(this, Request.QueryString["msg"]);
                else if (Request.QueryString["menu"] == "0")
                    LogonMessage(loginResult.logNoMenuAccess);
                else if (Request.QueryString[0] == "logon")
                    LogonMessage(loginResult.logReLogin);
                else if (Request.QueryString[0] == "lost")
                    LogonMessage(loginResult.logSessionLost);
                else if (Request.QueryString["tkn"] != null && Request.QueryString["tkn"] != "")
                {
                    using (DbConnection conn = new DbConnection(getConnString()))
                    {
                        try
                        {
                            object[] token = new object[1] { new Guid(Request.QueryString["tkn"]) };
                            conn.ExecuteNonQuery(SP_TOKENDELETE, token, dbtimeout);
                            LogonMessage(loginResult.logAuthFail);
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<!-- ex msg: " + ex.Message.Replace("-->", "--)") + " -->\n");
                            LogonMessage(loginResult.logAuthFail);
                        }
                    }
                }
                else LogonMessage(loginResult.logSessionLost);
            }
            //BTN_SUBMIT.Attributes.Add("onclick","return proceeding();");
        }

        private void LogonMessage(loginResult ret)
        {
            Label1.Text = getLogonMsg(ret, TXT_USERNAME.Text);
            if (ret == loginResult.logPwdInvalid || ret == loginResult.logPwdEmpty || ret == loginResult.logJustLocked)
                MyPage.SetFocus(this, TXT_PASSWORD);
            else MyPage.SetFocus(this, TXT_USERNAME);
        }

        #region static methods
        private static loginResult ValidateLogin(string userName, string password, DbConnection conn, int timeout, bool logon, string host, out string sessionid)
        {
            //sessionid = null;

            Guid rand_sessionid = Guid.NewGuid();
            sessionid = rand_sessionid.ToString();

            object[] user = new object[2] { userName, host };
            loginResult flag = loginResult.logNotFound;
            string falsepwd = "0", sulogon = "0", surevoke = "0", lastfalsecount = "0";

            conn.ExecReader(Q_VWLOGIN, user, timeout);
            if (!conn.hasRow())
                flag = loginResult.logNotFound;
            else
            {
                surevoke = conn.GetFieldValue("SU_REVOKE");
                sulogon = conn.GetFieldValue("SU_LOGON");
                lastfalsecount = conn.GetFieldValue("SU_FALSEPWDCOUNT");
                Encryption.SimpleEncryption enc = new Encryption.SimpleEncryption();

                if (logon)	// If already logon 
                    flag = loginResult.logSuccess;
                //else if (FormsAuthentication.HashPasswordForStoringInConfigFile(password, "sha1") == conn.GetFieldValue("SU_PWD"))
                else if (enc.Encrypt(password, true) == conn.GetFieldValue("SU_PWD"))
                {	// If password is correct
                    //if (conn.GetFieldValue("SU_PWD") == FormsAuthentication.HashPasswordForStoringInConfigFile(conn.GetFieldValue("CHECKDEFPWD").Trim(), "sha1"))
                    if (conn.GetFieldValue("SU_PWD") == enc.Encrypt(conn.GetFieldValue("CHECKDEFPWD").Trim(), true))
                        flag = loginResult.logPwdDefault;
                    else if (conn.GetFieldValue("DEFPWD") == "1")
                        flag = loginResult.logPwdDefault;
                    else if (conn.GetFieldValue("SU_LOGON") == "1")		// Check if user currently logs in... 
                        flag = loginResult.logHasLogon;
                    else if (conn.GetFieldValue("SU_PWDEXPIRED") == "1")
                        flag = loginResult.logPwdExpired;
                    else
                        flag = loginResult.logSuccess;
                }
                else
                {
                    // If incorrect password
                    falsepwd = "1";
                    flag = loginResult.logPwdInvalid;
                    if (password == string.Empty)
                    {
                        falsepwd = "0";
                        flag = loginResult.logPwdEmpty;
                    }
                }

                if (flag != loginResult.logPwdEmpty)
                {
                    //Guid rand_sessionid = Guid.NewGuid();
                    object[] actiparam = new object[7] {userName, conn.GetNativeFieldValue("GROUPID"), falsepwd, 
														   surevoke, host, sulogon, rand_sessionid.ToString() };
                    conn.ExecuteNonQuery(SP_USERACTIVITY, actiparam, timeout);
                    //sessionid = rand_sessionid.ToString();
                }
            }

            //check revoke
            conn.ExecReader(Q_CHECKREVOKE, user, timeout);
            if (conn.hasRow())
            {
                flag = loginResult.logLocked;
                if (surevoke == "0" && conn.GetFieldValue("SU_REVOKE") != "0")
                    flag = loginResult.logJustLocked;
            }

            return flag;
        }

        private static string getLogonMsg(loginResult ret, string user)
        {
            string msg = string.Empty;

            switch (ret)
            {
                //logNotFound, logSuccess, logHasLogon, logLocked
                //logPwdExpired, logPwdEmpty, logPwdInvalid, logJustLocked
                //logUserExpired, logGrantInvalid, logAuthFail
                //logNoLOSAccess, logNoMenuAccess, logSessionLost

                case loginResult.logNotFound:
                    if (user != string.Empty)
                        msg = "Invalid UserID/Password!"; break;
                case loginResult.logHasLogon:
                    msg = "User is currently logged in!"; break;
                case loginResult.logLocked:
                    msg = "User ID is Locked, Please contact your System Administrator!"; break;
                case loginResult.logPwdEmpty:
                    msg = "Please type in your password..."; break;
                case loginResult.logPwdInvalid:
                    msg = "Invalid UserID/Password"; break;
                case loginResult.logJustLocked:
                    msg = "User ID is Locked, Please contact your System Administrator!"; break;
                case loginResult.logGrantInvalid:
                    msg = "Server Error : Permission Denied for '" + user.ToUpper() + "'"; break;
                case loginResult.logAuthFail:
                    msg = "Login failed. Unable to Authenticate!"; break;
                case loginResult.logNoLOSAccess:
                    msg = "User does not have access to CBAS!"; break;
                case loginResult.logNoMenuAccess:
                    msg = "Menu Access Not Yet Defined For This User."; break;
                case loginResult.logSessionLost:
                    msg = "Session Lost... Please ReLogin"; break;
                case loginResult.logReLogin:
                    msg = "Please Re-Login"; break;
                case loginResult.logUnknown:
                    msg = "Server Error : Unknown Error"; break;
            }

            return msg;
        }
        #endregion

        private void RemoveSession()
        {
            Session.Remove("UserID");
            Session.Remove("sha1");
        }

        private string AuthenticateUser(DbConnection conn, string userid, string sessionid)
        {
            string url = "";
            Guid token = System.Guid.NewGuid();
            object[] objtkn = new object[2] { token, userid };

            conn.ExecReader(SP_SAVETOKEN, objtkn, dbtimeout);
            if (conn.hasRow())
            {
                string tempurl = conn.GetFieldValue(0);
                if (tempurl.IndexOf("?") >= 0)
                    url = tempurl + "&tkn=" + token.ToString() + "&sessionid=" + sessionid;
                else
                    url = tempurl + "?tkn=" + token.ToString() + "&sessionid=" + sessionid;
            }
            else
            {
                LogonMessage(loginResult.logNoLOSAccess);
            }

            return url;
        }

        private string locallogin()
        {
            string nexturl = "";

            #region login local

            try
            {
                connectionString = getConnString();
                DbConnection conn = new DbConnection(connectionString);



                string sessionid;
                Guid rand_sessionid = Guid.NewGuid();
                sessionid = rand_sessionid.ToString();


                loginResult flag = ValidateLogin(TXT_USERNAME.Text, TXT_PASSWORD.Text, conn, dbtimeout, logon, Request.UserHostAddress, out sessionid);



                switch (flag)
                {
                    //IF COMMENTED :: MORE THAN ONE ACCESS RESTRICTED
                    //case loginResult.logHasLogon:
                    case loginResult.logSuccess:


                        object[] lgparam = new object[] { TXT_USERNAME.Text, Request.UserHostAddress, sessionid };

                        conn.ExecuteNonQuery(SP_LOGINSTARTED, lgparam, dbtimeout);

                        FormsAuthentication.SetAuthCookie(TXT_USERNAME.Text, false);

                        nexturl = AuthenticateUser(conn, TXT_USERNAME.Text, sessionid);

                        break;

                    case loginResult.logPwdDefault:
                        FormsAuthentication.SetAuthCookie(TXT_USERNAME.Text, false);
                        Session.Add("UserID", TXT_USERNAME.Text);
                        nexturl = "ChangePassword.aspx?initial";
                        break;

                    case loginResult.logPwdExpired:
                        //FormsAuthentication.SetAuthCookie(TXT_USERNAME.Text, false);
                        //Session.Add("sha1", hash_password);
                        //Session.Add("UserID", TXT_USERNAME.Text);
                        //nexturl = "ChangePassword.aspx?expired";

                        //change password dari AD sehingga exp user local unused
                        object[] lgparam2 = new object[] { TXT_USERNAME.Text, Request.UserHostAddress, sessionid };
                        conn.ExecuteNonQuery(SP_LOGINSTARTED, lgparam2, dbtimeout);
                        FormsAuthentication.SetAuthCookie(TXT_USERNAME.Text, false);
                        nexturl = AuthenticateUser(conn, TXT_USERNAME.Text, sessionid);
                        break;

                    default: LogonMessage(flag); break;
                }
            }
            catch (Exception exc)
            {
                string errmsg = exc.Message;
                if (errmsg.IndexOf("Last Query: exec SU_USERLOGINGIN") > 0)
                {
                    errmsg = errmsg.Substring(0, errmsg.IndexOf("Last Query:"));
                    Label1.Text = errmsg;
                }
                else
                {
                    Response.Write("<!-- ex msg: " + exc.Message.Replace("-->", "--)") + " -->\n");
                    LogonMessage(loginResult.logUnknown);
                }
            }

            #endregion

            return nexturl;
        }

        protected void BTN_SUBMIT_Click(object sender, EventArgs e)
        {
            string nexturl = "";
            string loginResult_ldap = "";
            string LDAPServer = ""; 
            string useLDAPValidation = "0";
            string autoSwitchNonLDAPValidation = "0";

            try
            {
                LDAPServer = ConfigurationSettings.AppSettings["LDAPServer"].ToString();
            }
            catch (Exception ex)
            {
                LDAPServer = "";
            }

            try
            {
                useLDAPValidation = ConfigurationSettings.AppSettings["useLDAPValidation"].ToString();
            }
            catch(Exception ex)
            {
                useLDAPValidation = "0";
            }

            try
            {
                autoSwitchNonLDAPValidation = ConfigurationSettings.AppSettings["autoSwitchNonLDAPValidation"].ToString();
            }
            catch (Exception ex)
            {
                autoSwitchNonLDAPValidation = "0";
            }

            if(useLDAPValidation == "1")
            {
                string isLocalTried = "0";

                #region LDAP
                //VERIFIKASI LDAP               
                try
                {
                    

                    connectionString = getConnString();
                    DbConnection conn = new DbConnection(connectionString);

                    PrincipalContext ctx = new PrincipalContext(ContextType.Domain, LDAPServer, TXT_USERNAME.Text, TXT_PASSWORD.Text);
                    UserPrincipal users = UserPrincipal.FindByIdentity(ctx, TXT_USERNAME.Text);

                    if (users != null && users.AccountExpirationDate != null && users.Enabled == true)
                    {
                        Label1.Text = "YOUR ACCOUNT EXPIRED";
                    }
                    else if (users != null && users.IsAccountLockedOut() == true && users.Enabled == true)
                    {
                        Label1.Text = "YOUR ACCOUNT LOCKED";
                    }
                    else if (users != null && users.Enabled == false)
                    {
                        Label1.Text = "YOUR ACCOUNT DISABLE";
                    }
                    else
                    {
                        IntPtr tokenHandle = new IntPtr();
                        //WindowsImpersonationContext impersonatuser = null;
                        try
                        {
                            string UserName = null;
                            string MachineName = null;
                            string Pwd = null;

                            //The MachineName property gets the name of your computer.
                            MachineName = System.Environment.UserDomainName;
                            UserName = TXT_USERNAME.Text;
                            Pwd = TXT_PASSWORD.Text;

                            const int LOGON32_PROVIDER_DEFAULT = 0;
                            const int LOGON32_LOGON_INTERACTIVE = 2;
                            const int LOGON32_LOGON_NETWORK = 3;
                            const int LOGON32_LOGON_BATCH = 4;
                            const int LOGON32_LOGON_SERVICE = 5;
                            const int LOGON32_LOGON_UNLOCK = 7;
                            const int LOGON32_LOGON_NETWORK_CLEARTEXT = 8;
                            const int LOGON32_LOGON_NEW_CREDENTIALS = 9;
                            const int LOGON32_LOGON_PROVIDER_WINNT50 = 3;
                            tokenHandle = IntPtr.Zero;

                            Session["test"] = System.Net.NetworkInformation.IPGlobalProperties.GetIPGlobalProperties().DomainName;
                            Session["te"] = Request.LogonUserIdentity.Name;
                            //Call the LogonUser function to obtain a handle to an access token.
                            bool returnValue = LogonUser(UserName, LDAPServer, Pwd, LOGON32_LOGON_NEW_CREDENTIALS, LOGON32_LOGON_PROVIDER_WINNT50, out tokenHandle);

                            if (returnValue == false)
                            {
                                //This function returns the error code that the last unmanaged function returned.
                                int ret = Marshal.GetLastWin32Error();
                                string errmsg = GetErrorMessage(ret);
                                // MessageBox.Show(errmsg);
                                //  lblMessage.Text = errmsg;
                                Label1.Text = "incorect username or password";

                            }
                            else if (returnValue == true)
                            {
                                WindowsIdentity id = new WindowsIdentity(tokenHandle);
                                WindowsPrincipal wp = new WindowsPrincipal(id);
                                impersonatuser = id.Impersonate();
                                string IP = Request.UserHostName;

                                loginResult_ldap = returnValue.ToString();
                                //Label1.Text = loginResult_ldap;


                                string userid, displayname, nik, email;
                                userid = users.SamAccountName.ToString();
                                try { displayname = users.DisplayName.ToString(); } catch { displayname = userid; }
                                try { nik = users.EmployeeId.ToString(); } catch { nik = ""; }
                                try { email = users.EmailAddress.ToString(); } catch { email = ""; }
                                object[] par = new object[] { userid, displayname, email, nik };
                                conn.ExecNonQuery("exec SYNC_AD_USER @1,@2,@3,@4", par, dbtimeout);
                                conn.ExecReader("select * from [scalluser] where [userid] = '" + userid + "' and su_active = 1", null, dbtimeout);
                                if (conn.hasRow())
                                {
                                    Guid rand_sessionid = Guid.NewGuid();
                                    string sess = rand_sessionid.ToString();

                                    object[] lgparam = new object[] { userid, Request.UserHostAddress, sess };
                                    conn.ExecuteNonQuery(SP_LOGINSTARTED, lgparam, dbtimeout);
                                    FormsAuthentication.SetAuthCookie(userid, false);
                                    nexturl = AuthenticateUser(conn, userid, sess);

                                }
                                else
                                {
                                    LogonMessage(loginResult.logPwdInvalid);
                                }
                            }
                            CloseHandle(tokenHandle);
                        }
                        catch (Exception ex)
                        {
                            if (autoSwitchNonLDAPValidation == "1")
                            {
                                isLocalTried = "1";

                                //local login
                                nexturl = locallogin();
                            }
                            else
                            {
                                Label1.Text = ex.Message;
                            }

                        }
                    }

                }
                catch (Exception exs)
                {
                    if (autoSwitchNonLDAPValidation == "1" && isLocalTried == "0")
                    {
                        //local login
                        nexturl = locallogin();
                    }
                    else
                    {
                        Label1.Text = exs.Message;
                    }
                }
                #endregion
            }
            else
            {
                //local login
                nexturl = locallogin();
            }

            if (nexturl != "")
                Response.Redirect(nexturl);
        }

        private string getConnString()
        {

            //Encryptor enc = new Encryptor();
            //ApplicationRegistryHandler reg = new ApplicationRegistryHandler();
            //string appName = ConfigurationSettings.AppSettings["appName"].ToString();
            //appName = appName.Replace(" ", "");
            //string uobikey = ConfigurationSettings.AppSettings["UOBIKey"].ToString();
            //string DBConfig = ConfigurationSettings.AppSettings["DBConfig"].ToString();
            //string keyReg = reg.ReadFromRegistry("Software\\CBAS", "Key");

            //string connDetail = enc.Decrypt(DBConfig, keyReg, uobikey);
            //string[] connDetails = connDetail.Split(';');
            //string dbhost = connDetails[1].Substring(connDetails[1].IndexOf("=") + 1);
            //string dbname = connDetails[2].Substring(connDetails[2].IndexOf("=") + 1);
            //string dbuser = connDetails[3].Substring(connDetails[3].IndexOf("=") + 1);
            //string dbpwd = connDetails[4].Substring(connDetails[4].IndexOf("=") + 1);
            //string connstring = "Data Source=" + dbhost + ";Initial Catalog=" + dbname + ";uid=" + dbuser + ";pwd=" + dbpwd + ";Pooling=true";
            string connstring = decryptConnStr(ConfigurationSettings.AppSettings["connString"].ToString());
            return connstring;

        }


        //public static string decryptConnStr(string encryptedConnStr)
        //{
        //    string newValue = "";
        //    int num1 = encryptedConnStr.IndexOf("pwd=");
        //    int num2 = encryptedConnStr.IndexOf(";", num1 + 4);
        //    string oldValue = encryptedConnStr.Substring(num1 + 4, num2 - num1 - 4);
        //    for (int index = 2; index < oldValue.Length; ++index)
        //    {
        //        char c = (char)((uint)oldValue[index] - 2U);
        //        newValue += new string(c, 1);
        //    }
        //    return encryptedConnStr.Replace(oldValue, newValue);
        //}
    }
}
