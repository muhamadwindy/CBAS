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
    public partial class Modal_Content_SlikTasklist_Extract : DataPage
    {

        #region retrieve
        private void retrieve_data()
        {

            string param_extractid = "";
            string param_userid = "";
            string param_uid_slik = "";

            if (Request.QueryString["extractid"] != null && Request.QueryString["extractid"] != "undefined")
            {
                param_extractid = Request.QueryString["extractid"].ToString();//kalo darurat anti ini buat nongolin tombol delete

            }

            if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
            {
                param_userid = Request.QueryString["userid"].ToString();
            }

            if (Request.QueryString["serviceid"] != null && Request.QueryString["serviceid"] != "undefined")
            {
                param_uid_slik = Request.QueryString["serviceid"].ToString();
            }



            object[] par = new object[] { param_userid, param_uid_slik };

            DataTable dt = conn.GetDataTable("select * from slik_tasklist_extract where userid = @1 and serviceid = @2", par, dbtimeout);

            //staticFramework.retrieve(dt, "userid", userid);
            staticFramework.retrieve(dt, userid);
            staticFramework.retrieve(dt, serviceid);
            //staticFramework.retrieve(dt, pwd_viewer);

            //if(dt.Rows.Count > 0)
            //{
            //    pwd_viewer.Attributes["value"] = dt.Rows[0]["pwd_viewer"].ToString();
            //}            

            //staticFramework.retrieve(dt, "active", user_aktif);


            //if (Request.QueryString["extractid"] != null && Request.QueryString["extractid"] != "undefined")
            //{
            //    userid.ReadOnly = true;

            //    //if (dt.Rows[0]["active"].ToString().Equals("True"))
            //    //{
            //    //    user_aktif.SelectedIndex = 1;
            //    //}
            //    //else
            //    //{
            //    //    user_aktif.SelectedIndex = 0;
            //    //}

            //}
            //else
            //{
            //    userid.ReadOnly = false;
            //}

            if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
            {
                userid.ReadOnly = true;
            }
            else
            {
                userid.ReadOnly = false;
            }

            if (Request.QueryString["serviceid"] != null && Request.QueryString["serviceid"] != "undefined")
            {
                serviceid.ReadOnly = true;
            }
            else
            {
                serviceid.ReadOnly = false;
            }
        }
        #endregion

        #region databinding

        protected void page_mode()
        {
            if (!string.IsNullOrEmpty(Request.QueryString["extractid"]))//kalo ga tambah retreive
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

            object[] par = new object[] { };

            if (Request.QueryString["extractid"] != null && Request.QueryString["extractid"] != "undefined")
            {
                par = new object[] { userid.Text, serviceid.Text, Request.QueryString["extractid"] };
                conn.ExecNonQuery("exec SP_UPDATE_TO_CBASSLIK_SLIKTASKLISTEXTRACT  @1,@2,@3", par, dbtimeout);
            }
            else
            {
                par = new object[] { userid.Text, serviceid.Text, Guid.NewGuid() };
                conn.ExecNonQuery("exec SP_INSERT_TO_CBASSLIK_SLIKTASKLISTEXTRACT  @1,@2,@3", par, dbtimeout);
            }

            MyPage.popMessage((Page)this, "User Extract Berhasil Di Simpan");
            //Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx?bypasssession=1';</script>");
            Response.Write("<script>parent.window.location='../SLIK/Update_Password.aspx';</script>");
        }

        protected void ActDelete(object sender, EventArgs e)
        {
            try
            {
                string param_userid = "";
                string param_uid_slik = "";

                if (Request.QueryString["extractid"] != null && Request.QueryString["extractid"] != "undefined")
                {
                    param_userid = Request.QueryString["extractid"].ToString();

                }

                if (Request.QueryString["serviceid"] != null && Request.QueryString["serviceid"] != "undefined")
                {
                    param_uid_slik = Request.QueryString["serviceid"].ToString();
                }
                object[] par = new object[] { param_userid, param_uid_slik };
                conn.ExecNonQuery("DELETE FROM slik_tasklist_extract WHERE extractid = @1 AND userid = @2 ", par, dbtimeout);

                MyPage.popMessage((Page)this, "User Tasklist Extract Berhasil Dihapus");
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