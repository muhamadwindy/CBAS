using DMS.Tools;
using System;
using System.Configuration;
using System.Web.Security;

namespace DebtChecking
{
    public partial class unittest : System.Web.UI.Page
    {
        #region static vars

        private static string Q_LOGINSCR = "select top 1 LOGIN_SCR, DB_IP, DB_NAMA, DB_LOGINID, DB_LOGINPWD from RFMODULE where MODULEID = @1 ";
        private static string Q_USERDATA = "select * from VW_SESSIONLOS where USERID = @1 ";

        #endregion static vars

        protected void Page_Load(object sender, EventArgs e)
        {
            //Button1_Click(sender, e);
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
                    Session.Add("ModuleID", ConfigurationSettings.AppSettings["ModuleID"]);
                    Session.Add("ConnString", getConnStringModule());
                    Session.Add("ConnStringLogin", getConnStringLogin());
                    Session.Add("dbTimeOut", timeout);
                    Session.Add("dbBigTimeOut", int.Parse(ConfigurationSettings.AppSettings["dbBigTimeOut"]));
                    Session.Add("LoginTime", System.DateTime.Now);
                    Session.Add("BranchID", locconn.GetFieldValue("BRANCHID"));
                    Session.Add("ApprovalGroup", locconn.GetFieldValue("APPROVAL_GROUP"));
                    Session.Add("SaveCalculator", locconn.GetFieldValue("SAVECALCULATOR"));

                    Session.Add("GroupName", locconn.GetFieldValue("GROUPNAME"));
                    Session.Add("BranchName", locconn.GetFieldValue("BRANCHNAME"));
                    ret = true;
                }
            }
            return ret;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();

            int dbtimeout = int.Parse(ConfigurationSettings.AppSettings["dbTimeOut"]);
            string myconnstr = getConnStringLogin();
            DbConnection connESecurity = new DbConnection(myconnstr);

            string nexturl = "";
            object[] parmodule = new object[1] { ConfigurationSettings.AppSettings["ModuleID"] };

            connESecurity.ExecReader(Q_LOGINSCR, parmodule, dbtimeout);
            if (connESecurity.hasRow())
            {
                string uid = TextBox1.Text,
                    dbip = connESecurity.GetFieldValue(1),
                    dbname = connESecurity.GetFieldValue(2),
                    dbuid = connESecurity.GetFieldValue(3),
                    dbpwd = connESecurity.GetFieldValue(4);

                if (AddSession(uid, "Data Source=" + dbip + ";Initial Catalog=" + dbname + ";uid=" + dbuid + ";pwd=" + dbpwd + ";Pooling=true", dbtimeout))
                {
                    FormsAuthentication.SetAuthCookie(uid, false);
                    //DbConnection connLandingPage = new DbConnection(myconnstr);
                    //connLandingPage.ExecReader("EXEC getLandingPage @1", new object[1] { Session["GroupID"].ToString() }, dbtimeout);
                    //nexturl = connLandingPage.hasRow() ? connLandingPage.GetFieldValue(0) : "Index.aspx";
                    nexturl = "Main.aspx";
                }
            }
            connESecurity.Dispose();
            if (nexturl != "")
                Response.Redirect(nexturl, true);
            else
                MyPage.popMessage(this, "User not found");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
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
            string connstring = authenticate.decryptConnStr(ConfigurationSettings.AppSettings["connString"].ToString());
            return connstring;
        }

        private string getConnStringModule()
        {
            //Encryptor enc = new Encryptor();
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
            string connstring = authenticate.decryptConnStr(ConfigurationSettings.AppSettings["connStringModule"].ToString());
            return connstring;
        }
    }
}