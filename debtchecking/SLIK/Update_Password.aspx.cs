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
using System.IO;
using DMS.Tools;
using MWSFramework;
using EvoPdf.HtmlToPdf;
using DevExpress.Web;

namespace DebtChecking.SLIK
{
    public partial class Update_Password : DataPage
    {

        #region retrieve
        private void retrieve_Slik_Login(string key)
        {

        }
        #endregion

        #region databinding

        private void gridbind_agunan(string key)
        {

        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                retrieve_Slik_Login_viewer();
                retrieve_Slik_Login();
                retrieve_sliktasklistextract();
            }
            else
            {

            }
        }

        private void retrieve_Slik_Login_viewer()
        {
            //object[] par = new object[] { null };
            GridUpdate_Password_slikloginviewer.DataSource = conn.GetDataTable("select * from slikloginviewer", null, dbtimeout);
            GridUpdate_Password_slikloginviewer.DataBind();
        }

        private void retrieve_Slik_Login()
        {
            //object[] par = new object[] { null };
            //GridUpdate_Password_sliklogin.DataSource = conn.GetDataTable("select * from sliklogin", null, dbtimeout);
            GridUpdate_Password_sliklogin.DataSource = conn.GetDataTable("exec sp_vw_sliklogin", null, dbtimeout);
            GridUpdate_Password_sliklogin.DataBind();
        }

        private void retrieve_sliktasklistextract()
        {
            gvsliktasklistextract.DataSource = conn.GetDataTable("select * from slik_tasklist_extract order by userid,serviceid", null, dbtimeout);
            gvsliktasklistextract.DataBind();
        }

        protected void GridUpdate_Password_slikloginviewer_PageIndexChanged(object sender, EventArgs e)
        {
            retrieve_Slik_Login_viewer();
        }

        protected void GridUpdate_Password_slikloginviewer_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridUpdate_Password_slikloginviewer.PageIndex = e.NewPageIndex;
        }

        protected void GridUpdate_Password_slikloginviewer_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }


        protected void gvsliktasklistextract_PageIndexChanged(object sender, EventArgs e)
        {
            retrieve_sliktasklistextract();
        }



        protected void gvsliktasklistextract_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvsliktasklistextract.PageIndex = e.NewPageIndex;
        }

        protected void gvsliktasklistextract_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }



        protected void GridUpdate_Password_sliklogin_PageIndexChanged(object sender, EventArgs e)
        {
            retrieve_Slik_Login();
        }

        protected void GridUpdate_Password_sliklogin_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridUpdate_Password_sliklogin.PageIndex = e.NewPageIndex;
        }

        protected void GridUpdate_Password_sliklogin_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gridPanel_Callback_slikloginviewer(object source, CallbackEventArgsBase e)
        {
            if (e.Parameter.ToString().StartsWith("d:"))
            {
                deleteSlikLoginViewer(e.Parameter.Substring(2));
            }

            retrieve_Slik_Login_viewer();
        }

        protected void gridPanel_Callback_sliklogin(object source, CallbackEventArgsBase e)
        {
            if (e.Parameter.ToString().StartsWith("d:"))
            {
                deleteSlikLogin(e.Parameter.Substring(2));
            }

            retrieve_Slik_Login();
        }



        protected void gridPanel_Callback_sliktasklistextract(object source, CallbackEventArgsBase e)
        {
            if (e.Parameter.ToString().StartsWith("d:"))
            {
                deleteSliktasklist_extract(e.Parameter.Substring(2));
            }

            retrieve_sliktasklistextract();
        }



        protected void deleteSlikLoginViewer(string id)
        {
            try
            {
                string[] s = id.Split(':');
                object[] par = new object[] { s[0], s[1] };
                conn.ExecNonQuery("DELETE FROM slikloginviewer WHERE userid = @1 AND uid_slik = @2 ", par, dbtimeout);

            }
            catch (Exception ex)
            {
                gridPanel.JSProperties["cp_alert"] = ex.Message.IndexOf("Last Query:") <= 0 ? ex.Message : ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
            }
        }

        protected void deleteSlikLogin(string id)
        {
            try
            {
                string[] s = id.Split(':');
                object[] par = new object[] { s[0], s[1] };
                conn.ExecNonQuery("DELETE FROM sliklogin WHERE userid = @1 AND uid_slik = @2 ", par, dbtimeout);
                conn.ExecNonQuery("DELETE FROM sliklogindetail WHERE userid = @1 AND uid_slik = @2 ", par, dbtimeout);

                string a = s[2].ToString();
                if (s[2].ToString() == "OPR")
                {
                    conn.ExecNonQuery("DELETE FROM slik_tasklist WHERE userid = @1", par, dbtimeout);
                }


            }
            catch (Exception ex)
            {
                gridPanel.JSProperties["cp_alert"] = ex.Message.IndexOf("Last Query:") <= 0 ? ex.Message : ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
            }
        }


        protected void deleteSliktasklist_extract(string id)
        {
            try
            {
                string[] s = id.Split(':');
                object[] par = new object[] { s[0], s[1], s[2] };
                conn.ExecNonQuery("DELETE FROM slik_tasklist_extract WHERE extractid= @1 AND  serviceid = @2 and userid= @3  ", par, dbtimeout);


            }
            catch (Exception ex)
            {
                gridPanel.JSProperties["cp_alert"] = ex.Message.IndexOf("Last Query:") <= 0 ? ex.Message : ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
            }
        }


    }
}