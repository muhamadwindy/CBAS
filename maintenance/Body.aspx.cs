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
using System.Drawing;
using DMS.Tools;
using UOBISecurity;

namespace MikroMnt
{
    public partial class Body : System.Web.UI.Page
    {
        #region static vars
        private static string Q_GETMODULE = "SELECT MODULEID FROM RFMODULE WHERE MODULENAME = @1 ";
        private static string Q_LISTMODULE = "SELECT GROUPID, SG_GRPNAME, MODULEID, MODULENAME " +
            "FROM VW_GRPACCESSMODULE WHERE GROUPID = @1 ";
        private static string SP_SAVETOKEN = "EXEC ES_SAVETOKEN @1, @2, @3 ";
        #endregion

        private DbConnection connESecurity;
        private int dbtimeout;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                dbtimeout = int.Parse(ConfigurationSettings.AppSettings["dbTimeOut"]);
                connESecurity = new DbConnection(getConnStringLogin());
                LoadModule();
                if (!IsPostBack)
                {
                    Session.Remove("BackURL");
                    LoadMenu();
                    connESecurity.Dispose();
                }
            } catch(Exception ex)
            {
                Response.Write("<script language='JavaScript'>top.location.href = \"Logout.aspx?p=session\";</script>");
            }
        }

        private void LoadModule()
        {
            object[] pargrp = new object[1] { Session["GroupID"] };
            connESecurity.ExecReader(Q_LISTMODULE, pargrp, dbtimeout);

            int loopcounter = 0;
            while (connESecurity.hasRow())
            {
                loopcounter++;
                if (loopcounter == 1)
                    if (!IsPostBack)
                        try
                        {
                            Label1.Text = connESecurity.GetFieldValue(2);
                        }
                        catch (Exception ex1)
                        {
                            Response.Write("<!-- " + ex1.Message.Replace("-->", "--)") + " -->\n");
                            MNTTools.LogError(this, (string)Session["UserID"], ex1);
                        }

                LinkButton lb = new LinkButton();
                lb.Text = connESecurity.GetFieldValue(3);		//modulename 
                lb.Font.Bold = true;
                lb.Font.Name = "verdana";
                lb.Font.Size = FontUnit.Point(8);
                lb.ForeColor = Color.RoyalBlue;

                if (connESecurity.GetFieldValue(2) == ConfigurationSettings.AppSettings["ModuleID"])
                {
                    lb.ForeColor = Color.BlueViolet;
                    lb.Attributes.Add("onclick", "return false;");
                }
                else lb.Click += new EventHandler(lb_Click);

                PlaceHolder1.Controls.Add(lb);
                PlaceHolder1.Controls.Add(new LiteralControl("&nbsp;&nbsp;"));
            }

            if (loopcounter <= 1)
                PlaceHolder1.Visible = false;
        }

        private void LoadMenu()
        {
            try
            {
                string modid = (string)Session["ModuleID"];
                object[] param = new object[] { modid, Session["GroupID"] };
                load_menu(menu,
                    connESecurity.GetDataTable(
                    "SELECT A.* FROM RFMENUX A JOIN GRPMENUX B ON A.TYPEID = B.TYPEID and A.MENUID = B.MENUID " +
                    "WHERE B.TYPEID = @1 and B.GROUPID = @2 " + 
                    "union select '" + modid + "' as TYPEID, '99' as MENUID, 'Logout' as MENUDESC, '~/Logout.aspx' as MENUURL, null as MENUIMAGEURL, null as MENUPARENT, 9 as MENUPOSITION, '' as PASSINGURL " +
                    "ORDER BY MENUPARENT, MENUPOSITION ",
                    param, dbtimeout)
                    , null);
            }
            catch
            {
                connESecurity.Dispose();
                Response.Redirect("Logout.aspx?menu", true);
            }
        }

        protected void load_menu(object menu, DataTable dtmenu, string MenuParent)
        {
            if (MenuParent == null)
                MenuParent = "is NULL";
            else
                MenuParent = "= '" + MenuParent + "'";

            DataView dv = new DataView(dtmenu, "MENUPARENT " + MenuParent, "", DataViewRowState.OriginalRows);

            for (int i = 0; i < dv.Count; i++)
            {
                string menuid = dv[i]["MENUID"].ToString();
                string menudesc = dv[i]["MENUDESC"].ToString();
                string menuurl = dv[i]["MENUURL"].ToString();
                string menutarget = "_self";
                DevExpress.Web.MenuItem menuchild;
                if (menu is DevExpress.Web.ASPxMenu)
                    menuchild = (menu as DevExpress.Web.ASPxMenu).Items.Add(menudesc, menuid, null, menuurl, menutarget);
                else
                    menuchild = (menu as DevExpress.Web.MenuItem).Items.Add(menudesc, menuid, null, menuurl, menutarget);
                load_menu(menuchild, dtmenu, menuid);
            }
        }

        private void lb_Click(object sender, System.EventArgs e)
        {
            LinkButton lbl = (LinkButton)sender;

            object[] modname = new object[1] { lbl.Text };
            string moduleid = null, url = "";

            connESecurity.ExecReader(Q_GETMODULE, modname, dbtimeout);
            if (connESecurity.hasRow())
                moduleid = connESecurity.GetFieldValue(0);

            Guid token = System.Guid.NewGuid();
            object[] objtkn = new object[3] { token, Session["UserID"], moduleid };

            connESecurity.ExecReader(SP_SAVETOKEN, objtkn, dbtimeout);
            if (connESecurity.hasRow())
            {
                string tempurl = connESecurity.GetFieldValue(0);
                if (tempurl.IndexOf("?") >= 0)
                    url = tempurl + "&tkn=" + token.ToString() + "&sessionid=" + Session["sessionid"];
                else
                    url = tempurl + "?tkn=" + token.ToString() + "&sessionid=" + Session["sessionid"];
            }
            connESecurity.Dispose();

            if (url != "")
            {
                RemoveSession();
                Response.Redirect(url, true);
            }
            else
                MyPage.popMessage(this, "Invalid Server State!");
        }

        private void RemoveSession()
        {
            Session.Clear();
            Session.Abandon();
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
            string connstring = ConfigurationSettings.AppSettings["connString"].ToString();
            return connstring;

        }
    }
}
