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
using System.Collections.Specialized;

namespace DebtChecking.SLIK
{
    public partial class Modal_Content_SlikLogin_Viewer : DataPage
    {

        #region retrieve
        private void retrieve_data()
        {

            string param_userid = "";
            string param_uid_slik = "";

            if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
            {
                param_userid = Request.QueryString["userid"].ToString();//kalo darurat anti ini buat nongolin tombol delete

            }

            if (Request.QueryString["uid_slik"] != null && Request.QueryString["uid_slik"] != "undefined")
            {
                param_uid_slik = Request.QueryString["uid_slik"].ToString();
            }



            object[] par = new object[] { param_userid, param_uid_slik };

            DataTable dt = conn.GetDataTable("select * from slikloginviewer where userid = @1 and uid_slik = @2", par, dbtimeout);

            //staticFramework.retrieve(dt, "userid", userid);
            staticFramework.retrieve(dt, userid);
            staticFramework.retrieve(dt, uid_slik);
            //staticFramework.retrieve(dt, pwd_viewer);

            if (dt.Rows.Count > 0)
            {
                pwd_viewer.Attributes["value"] = dt.Rows[0]["pwd_viewer"].ToString();
            }

            staticFramework.retrieve(dt, "active", user_aktif);


            if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
            {
                userid.ReadOnly = true;

                if (dt.Rows[0]["active"].ToString().Equals("True"))
                {
                    user_aktif.SelectedIndex = 1;
                }
                else
                {
                    user_aktif.SelectedIndex = 0;
                }

            }
            else
            {
                userid.ReadOnly = false;
            }

            if (Request.QueryString["uid_slik"] != null && Request.QueryString["uid_slik"] != "undefined")
            {
                uid_slik.ReadOnly = true;
            }
            else
            {
                uid_slik.ReadOnly = false;
            }
        }
        #endregion

        #region databinding

        protected void page_mode()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["userid"]))//kalo ga tambah retreive
            {
                retrieve_data();

            }
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                page_mode();

                if (Request.QueryString["bypasssession"] != null)
                {

                }
            }
            else
            {

            }
        }

        protected void ActSv(object sender, EventArgs e)
        {
            try
            {
                saveData();
                //MyPage.popMessage((Page)this, "Data Berhasil Disimpan");
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                if (msg.IndexOf("Last Query:") > 0)
                    msg = msg.Substring(0, msg.IndexOf("Last Query:"));
                MyPage.popMessage((Page)this, msg);
            }
        }

        protected void ActCnl(object sender, EventArgs e)
        {
            //Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx?bypasssession=1';</script>");
            Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx';</script>");
        }

        protected void saveData()
        {


            //NameValueCollection Keys = new NameValueCollection();
            //staticFramework.saveNVC(Keys, userid);
            //staticFramework.saveNVC(Keys, uid_slik);

            //NameValueCollection Fields = new NameValueCollection();


            //staticFramework.saveNVC(Fields, pwd_viewer);
            //staticFramework.saveNVC(Fields, "active", user_aktif);
            //staticFramework.save(Fields, Keys, "slikloginviewer", conn);

            object[] par = new object[] { userid.Text, uid_slik.Text, pwd_viewer.Text, user_aktif.SelectedValue };

            if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
            {
                conn.ExecNonQuery("exec SP_UPDATE_TO_CBASSLIK_SLIKLOGINVIEWER  @1,@2,@3,@4 ", par, dbtimeout);
            }
            else
            {
                conn.ExecNonQuery("exec SP_INSERT_TO_CBASSLIK_SLIKLOGINVIEWER  @1,@2,@3,@4 ", par, dbtimeout);
            }

            MyPage.popMessage((Page)this, "User Berhasil Di Simpan");
            //Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx?bypasssession=1';</script>");
            Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx';</script>");
        }

        protected void ActDelete(object sender, EventArgs e)
        {
            try
            {
                string param_userid = "";
                string param_uid_slik = "";

                if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
                {
                    param_userid = Request.QueryString["userid"].ToString();

                }

                if (Request.QueryString["uid_slik"] != null && Request.QueryString["uid_slik"] != "undefined")
                {
                    param_uid_slik = Request.QueryString["uid_slik"].ToString();
                }
                object[] par = new object[] { param_userid, param_uid_slik };
                conn.ExecNonQuery("DELETE FROM slikloginviewer WHERE userid = @1 AND uid_slik = @2 ", par, dbtimeout);
                MyPage.popMessage((Page)this, "User Berhasil Dihapus");
                //Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx?bypasssession=1';</script>");
                Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx';</script>");
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
                if (msg.IndexOf("Last Query:") > 0)
                    msg = msg.Substring(0, msg.IndexOf("Last Query:"));
                MyPage.popMessage((Page)this, msg);
            }
        }



    }
}