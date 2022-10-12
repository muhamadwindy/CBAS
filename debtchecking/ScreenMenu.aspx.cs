using System;
using System.Data;
using System.Web;

namespace DebtChecking
{
    public partial class ScreenMenu : MasterPage
    {
        private string urlplus = "";

        public string BackURL
        {
            get
            {
                return (string)Session["BackURL"];
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
                return;
            if (Session["BackURL"] == null)
                Session["BackURL"] = Request.RawUrl;
            else
                HrefBack.HRef = (string)Session["BackURL"];
            HrefBack.Visible = Request.RawUrl != (string)Session["BackURL"];
            string screenmenuid = Request.QueryString["sm"];
            try
            {
                urlplus = Request.RawUrl.Substring(Request.RawUrl.IndexOf("passurl"));
            }
            catch
            {
            }
            string regno = Request.QueryString["appNumber"];
            //DataTable dataTable = conn.GetDataTable("select * from SCREENMENUCHILD where TYPEID in (select MENUID from SCREENMENU where TYPEID  = '" + screenmenuid + "') order by MENUPOSITION ASC", (object[])null, dbtimeout);

            //object[] par = new object[] { screenmenuid, USERID, regno };
            object[] par = new object[] { screenmenuid };
            //DataTable dataTable = conn.GetDataTable("EXEC SP_GET_MENU_DETAIL @1,@2,@3 ", par, dbtimeout);
            string Q_MENUCHILD = "SELECT TYPEID, MENUID, MENUDESC, MENUURL, MENUIMAGEURL, " +
          "MENUPARENT, MENUPOSITION, PASSINGURL, MDTRQRYSTR, NOQRYSTR " +
          "FROM SCREENMENUCHILD WHERE TYPEID=@1 " +
          //"and menuid in (select menuid from scgroupsmauthority where groupid = @2) " +
          "ORDER BY MENUPARENT, MENUPOSITION ";
            DataTable dataTable = conn.GetDataTable(Q_MENUCHILD, par, dbtimeout);

            string listtab = "";
            int num = 0;
            foreach (DataRow row in (InternalDataCollectionBase)dataTable.Rows)
            {
                string taburl;
                if (urlplus.ToLower().Contains("appnumber"))
                    taburl = FixupUrl(row["menuurl"].ToString() + "?" + urlplus + row["passingurl"].ToString());
                else
                    taburl = FixupUrl(row["menuurl"].ToString() + "?" + urlplus + row["passingurl"].ToString() + "&appnumber=" + regno);

                if (num == 0)
                {
                    listtab = listtab + "<li class='active' id='tab" + num.ToString() + "'> <a href='#' role='tab' data-toggle='tab' onclick=changeUrl('" + taburl + "'); return false;>" + row["menudesc"].ToString() + "</a></li> ";
                    firstLink.Value = taburl;
                }
                else
                    listtab = listtab + "<li id='tab" + num.ToString() + "'> <a href='#' role='tab' data-toggle='tab' onclick=changeUrl('" + taburl + "'); return false;>" + row["menudesc"].ToString() + "</a></li> ";
                ++num;
            }
            navigation.InnerHtml = listtab;
        }

        private static string FixupUrl(string Url)
        {
            if (Url.StartsWith("~"))
                return (HttpContext.Current.Request.ApplicationPath + Url.Substring(1)).Replace("//", "/");
            return Url;
        }
    }
}