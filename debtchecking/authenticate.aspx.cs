using DMS.Tools;
using System;
using System.Configuration;
using System.Web.Security;
using UOBISecurity;

namespace DebtChecking
{
    public partial class authenticate : System.Web.UI.Page
    {
        #region static vars

        private static string Q_LOGINSCR = "select top 1 LOGIN_SCR from RFMODULE where MODULEID = @1 ";

        private static string Q_ES_TOKEN = "select USERID, GROUPID, MODULEID, DB_IP, DB_NAMA, DB_LOGINID, " +
            "DB_LOGINPWD  from VW_ES_APPTOKEN where TOKENID = @1 ";

        private static string Q_USERDATA = "select * from VW_SESSIONLOS where USERID = @1 ";
        private static string SP_TOKENDELETE = "EXEC ES_APPTOKEN_DELETE @1";

        //public static string decryptConnStr(string encryptedConnStr)
        //{
        //    string connStr, encpwd, decpwd = "";
        //    int pos1, pos2;
        //    pos1 = encryptedConnStr.IndexOf("pwd=");
        //    pos2 = encryptedConnStr.IndexOf(";", pos1 + 4);
        //    encpwd = encryptedConnStr.Substring(pos1 + 4, pos2 - pos1 - 4);
        //    for (int i = 2; i < encpwd.Length; i++)
        //    {
        //        char chr = (char)(encpwd[i] - 2);
        //        decpwd += new string(chr, 1);
        //    }
        //    connStr = encryptedConnStr.Replace(encpwd, decpwd);
        //    return connStr;
        //}

        #endregion static vars

        protected void Page_Load(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();

            int dbtimeout = int.Parse(ConfigurationSettings.AppSettings["dbTimeOut"]);
            DbConnection connESecurity = new DbConnection(getConnStringLogin());

            string nexturl = "";
            object[] partoken = new object[1] { new Guid(Request.QueryString["tkn"]) },
                parmodule = new object[1] { ConfigurationSettings.AppSettings["ModuleID"] };

            connESecurity.ExecReader(Q_LOGINSCR, parmodule, dbtimeout);
            if (connESecurity.hasRow())
                nexturl = connESecurity.GetFieldValue(0);

            connESecurity.ExecReader(Q_ES_TOKEN, partoken, dbtimeout);
            if (connESecurity.hasRow())
            {
                string uid = connESecurity.GetFieldValue(0),
                    grp = connESecurity.GetFieldValue(1),
                    mod = connESecurity.GetFieldValue(2),
                    dbip = connESecurity.GetFieldValue(3),
                    dbname = connESecurity.GetFieldValue(4),
                    dbuid = connESecurity.GetFieldValue(5),
                    dbpwd = connESecurity.GetFieldValue(6);

                connESecurity.ExecuteNonQuery(SP_TOKENDELETE, partoken, dbtimeout);

                if (AddSession(uid, getConnStringModule(), dbtimeout))
                {
                    FormsAuthentication.SetAuthCookie(uid, false);
                    //DbConnection connLandingPage = new DbConnection(getConnStringLogin());
                    //connLandingPage.ExecReader("EXEC getLandingPage @1", new object[1] { Session["GroupID"].ToString() }, dbtimeout);
                    //nexturl = connLandingPage.hasRow() ? connLandingPage.GetFieldValue(0) : "Main.aspx";
                    nexturl = "Index.aspx";
                }
            }

            connESecurity.Dispose();
            Response.Redirect(nexturl, true);
        }

        private bool AddSession(string uid, string connstr, int timeout)
        {
            bool ret = false;
            using (DbConnection locconn = new DbConnection(getConnStringLogin()))			//load user data from loslogin for sysca maintenance user
            {
                object[] user = new object[1] { uid };
                locconn.ExecReader(Q_USERDATA, user, timeout);
                if (locconn.hasRow())
                {
                    Session.Add("UserID", locconn.GetFieldValue("USERID"));
                    Session.Add("FullName", locconn.GetFieldValue("SU_FULLNAME"));
                    Session.Add("GroupID", locconn.GetFieldValue("GROUPID"));
                    Session.Add("GroupName", locconn.GetFieldValue("GROUPNAME"));
                    Session.Add("ApprovalGroup", locconn.GetFieldValue("APPROVAL_GROUP"));
                    Session.Add("SaveCalculator", locconn.GetFieldValue("SAVECALCULATOR"));
                    if (locconn.GetFieldValue("SG_GRPNAME").Trim() != "")
                        Session.Add("GroupName", "(" + locconn.GetFieldValue("SG_GRPNAME") + ")");
                    Session.Add("BranchID", locconn.GetFieldValue("BRANCHID"));
                    Session.Add("BranchName", locconn.GetFieldValue("BRANCHNAME"));
                    Session.Add("ModuleID", ConfigurationSettings.AppSettings["ModuleID"]);
                    Session.Add("ConnString", connstr);
                    Session.Add("ConnStringLogin", getConnStringLogin());
                    Session.Add("ConnStringModule", getConnStringModule());
                    Session.Add("dbTimeOut", timeout);
                    Session.Add("dbBigTimeOut", int.Parse(ConfigurationSettings.AppSettings["dbBigTimeOut"]));
                    Session.Add("LoginTime", System.DateTime.Now);
                    Session.Add("sessionid", Request.QueryString["sessionid"]);

                    ret = true;
                }
            }
            return ret;
        }

        private string getConnStringLogin()
        {
            //Encryptor enc = new Encryptor();
            //ApplicationRegistryHandler reg = new ApplicationRegistryHandler();
            //string appName = ConfigurationSettings.AppSettings["appName"].ToString();
            //appName = appName.Replace(" ", "");
            //string uobikey = ConfigurationSettings.AppSettings["UOBIKey"].ToString();
            //string DBConfig = ConfigurationSettings.AppSettings["DBConfig"].ToString();
            //string keyReg = reg.ReadFromRegistry("Software\\" + appName, "Key");

            //string connDetail = enc.Decrypt(DBConfig, keyReg, uobikey);
            //string[] connDetails = connDetail.Split(';');
            //string dbhost = connDetails[1].Substring(connDetails[1].IndexOf("=") + 1);
            //string dbname = connDetails[2].Substring(connDetails[2].IndexOf("=") + 1);
            //string dbuser = connDetails[3].Substring(connDetails[3].IndexOf("=") + 1);
            //string dbpwd = connDetails[4].Substring(connDetails[4].IndexOf("=") + 1);
            //string connstring = "Data Source=" + dbhost + ";Initial Catalog=" + dbname + ";uid=" + dbuser + ";pwd=" + dbpwd + ";Pooling=true";

            string connstring = decryptConnStr(ConfigurationSettings.AppSettings["connString"]);
            return connstring;
        }

        public static string decryptConnStr(string encryptedConnStr)
        {
            string newValue = "";
            int num1 = encryptedConnStr.IndexOf("pwd=");
            int num2 = encryptedConnStr.IndexOf(";", num1 + 4);
            string oldValue = encryptedConnStr.Substring(num1 + 4, num2 - num1 - 4);
            for (int index = 2; index < oldValue.Length; ++index)
            {
                char c = (char)((uint)oldValue[index] - 2U);
                newValue += new string(c, 1);
            }
            return encryptedConnStr.Replace(oldValue, newValue);
        }

        private string getConnStringModule()
        {
            Encryptor enc = new Encryptor();
            //ApplicationRegistryHandler reg = new ApplicationRegistryHandler();
            //string appName = ConfigurationSettings.AppSettings["appName"].ToString();
            //appName = appName.Replace(" ", "");
            //string uobikey = ConfigurationSettings.AppSettings["UOBIKeyModule"].ToString();
            //string DBConfig = ConfigurationSettings.AppSettings["DBConfigModule"].ToString();
            //string keyReg = reg.ReadFromRegistry("Software\\" + appName, "Key");

            //string connDetail = enc.Decrypt(DBConfig, keyReg, uobikey);
            //string[] connDetails = connDetail.Split(';');
            //string dbhost = connDetails[1].Substring(connDetails[1].IndexOf("=") + 1);
            //string dbname = connDetails[2].Substring(connDetails[2].IndexOf("=") + 1);
            //string dbuser = connDetails[3].Substring(connDetails[3].IndexOf("=") + 1);
            //string dbpwd = connDetails[4].Substring(connDetails[4].IndexOf("=") + 1);
            //string connstring = "Data Source=" + dbhost + ";Initial Catalog=" + dbname + ";uid=" + dbuser + ";pwd=" + dbpwd + ";Pooling=true";
            string connstring = decryptConnStr(ConfigurationSettings.AppSettings["connStringModule"]);
            return connstring;
        }
    }
}