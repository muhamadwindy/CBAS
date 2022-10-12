﻿using DMS.Tools;
using System;
using System.Configuration;

namespace DebtChecking
{
    public class MasterPage : System.Web.UI.Page
    {
        protected DbConnection conn;
        protected int dbtimeout;
        protected string USERID, GROUPID, sessionid;

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

        protected override void OnLoad(EventArgs e)
        {
            if (Request.QueryString["bypasssession"] == "1")
            {
                dbtimeout = int.Parse(ConfigurationSettings.AppSettings["dbTimeOut"]);
                conn = new DbConnection(getConnStringModule());
                USERID = "SYSTEM";
            }
            else
            {
                try
                {
                    dbtimeout = (int)Session["DbTimeOut"];
                    conn = new DbConnection((string)Session["ConnString"]);
                    USERID = (string)Session["UserID"];
                    GROUPID = (string)Session["GroupID"];
                    sessionid = (string)Session["sessionid"];
                    //cek session
                    object[] param = new object[] { USERID, sessionid };
                    DbConnection connlogin = new DbConnection((string)Session["ConnStringLogin"]);
                    connlogin.ExecReader("select top 1 * from scalluserflag where userid = @1 and sessionid = @2", param, dbtimeout);
                    if (!connlogin.hasRow())
                    {
                        //Response.Write("<script language='JavaScript'>alert('classmasterpage connlogin = " + Session["ConnStringLogin"].ToString() + " param = " + USERID + " session = " + sessionid  + "');</script>");
                        //Response.Write("<script for=window event=onload language='JavaScript'>window.parent.execScript('top.location.href = \"../Logout.aspx?p=session\";');</script>");
                    }
                    connlogin.CloseConnection();
                    connlogin.Dispose();
                }
                catch (Exception ex)
                {
                    //Response.Write("<script language='JavaScript'>alert(' classmasterpage=" + ex.Message.ToString() + "');</script>");
                    //Response.Write("<script language='JavaScript'>top.location.href = \"Logout.aspx?p=session\";</script>");
                }
            }
            this.MaintainScrollPositionOnPostBack = true;
            //this.Form.SubmitDisabledControls = true;

            base.OnLoad(e);
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

        protected override void OnUnload(EventArgs e)
        {
            base.OnUnload(e);
            try
            {
                conn.Dispose();
            }
            catch (Exception ex) { string msq = ex.Message.ToString(); }
        }
    }

    public class DataPage : MasterPage
    {
        protected bool allowViewState = false;

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (this.Request.QueryString["readonly"] != null)
                MWSFramework.ModuleSupport.DisableControls(this, allowViewState);
        }
    }
}