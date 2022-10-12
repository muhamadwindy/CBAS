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
    public partial class nav : System.Web.UI.Page
    {
        #region static vars
        private static string Q_GETMODULE = "SELECT MODULEID FROM RFMODULE WHERE MODULENAME = @1 ";
        private static string Q_LISTMODULE = "SELECT GROUPID, SG_GRPNAME, MODULEID, MODULENAME " +
            "FROM VW_GRPACCESSMODULE WHERE GROUPID = @1 ";
        private static string SP_SAVETOKEN = "EXEC ES_SAVETOKEN @1, @2, @3 ";
        #endregion

        private DbConnection connESecurity;
        private int dbtimeout;
        System.Text.StringBuilder htmlbuilder = new System.Text.StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                dbtimeout = int.Parse(ConfigurationSettings.AppSettings["dbTimeOut"]);
                connESecurity = new DbConnection(getConnStringLogin()); 
                if (!IsPostBack)
                {
                    Session.Remove("BackURL");
                    LoadMenu();
                    connESecurity.Dispose();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script language='JavaScript'>top.location.href = \"Logout.aspx?p=session\";</script>");
            }

        }

        private void LoadMenu()
        {
            try
            {
                string modid = (string)Session["ModuleID"];
                object[] param = new object[] { modid, Session["GroupID"] };
                load_menu(connESecurity.GetDataTable(
                     "SELECT A.* FROM RFMENUX A JOIN GRPMENUX B ON A.TYPEID = B.TYPEID and A.MENUID = B.MENUID " +
                     "WHERE B.TYPEID = @1 and B.GROUPID = @2 " +
                     "union select '" + modid + "' as TYPEID, '99' as MENUID, 'Logout' as MENUDESC, 'Logout.aspx' as MENUURL, 'nav-icon fas fa-power-off' as MENUIMAGEURL, null as MENUPARENT, 99 as MENUPOSITION, '' as PASSINGURL " +
                     "ORDER BY MENUPARENT, MENUPOSITION ",
                                     param, dbtimeout)
                     , null);



            }
            catch (Exception ex)
            {
                connESecurity.Dispose();
                Response.Redirect("Logout.aspx?menu", true);
            }
        }

        bool navParent = true;
        protected void load_menu(DataTable dtmenu, string MenuParent)
        {


            if (MenuParent == null)
                MenuParent = "is NULL";
            else
                MenuParent = "= '" + MenuParent + "'";

            DataView dv = new DataView(dtmenu, "MENUPARENT " + MenuParent, "", DataViewRowState.OriginalRows);
            if (navParent)
            {
                htmlbuilder.Append(@"<ul class=""nav nav-pills nav-flat nav-sidebar flex-column nav-child-indent"" 
data-widget=""treeview"" role=""menu"" data-accordion=""false"">");
                navParent = false;
            }
            else
            {
                htmlbuilder.Append("<ul class=\"nav nav-treeview\"> \n");
            }


            for (int i = 0; i < dv.Count; i++)
            {
                string menuid = dv[i]["MENUID"].ToString();
                string menudesc = dv[i]["MENUDESC"].ToString();
                string menuurl = dv[i]["MENUURL"].ToString();
                string menustyle = dv[i]["MENUIMAGEURL"].ToString();
                string passingurl = "";
                try { passingurl = dv[i]["PASSINGURL"].ToString(); }
                catch { }
                if (menuurl != "")
                {
                    if (menuurl.IndexOf("?") < 0)
                        menuurl += "?";
                    else
                        menuurl += "&";
                    menuurl += "passurl";
                    if (menuurl.IndexOf("mntitle") < 0)
                        menuurl += "&mntitle=" + menudesc;
                    menuurl += passingurl;
                }

                if (menuurl != "")
                    htmlbuilder.Append("<li class=\"nav-item\"><a href=\"" + ResolveUrl("~/") + menuurl + "\" class=\"nav-link\"><i class=\"" + menustyle + "\"></i><p>" + menudesc + "</p></a> \n");
                else
                    htmlbuilder.Append("<li class=\"nav-item has-treeview\"><a href=\"#\" class=\"nav-link\"><i class=\"" + menustyle + "\"></i><p>" + menudesc + "<i class=\"right fas fa-angle-left\"></i></p></a> \n");

                DataView dv2 = new DataView(dtmenu, "MENUPARENT = '" + menuid + "'", "", DataViewRowState.OriginalRows);
                if (dv2.Count > 0)
                    load_menu(dtmenu, menuid);
                else
                    htmlbuilder.Append("</li> \n");

            }
            htmlbuilder.Append("</ul> \n");
            menu.Text = htmlbuilder.ToString();
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