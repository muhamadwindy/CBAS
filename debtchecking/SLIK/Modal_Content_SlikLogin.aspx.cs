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
using System.Text;
using System.Security.Cryptography;

namespace DebtChecking.SLIK
{
    public partial class Modal_Content_SlikLogin : DataPage
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

            DataTable dt = conn.GetDataTable("select * from sliklogin where userid = @1 and uid_slik = @2", par, dbtimeout);
            staticFramework.retrieve(dt, userid);
            staticFramework.retrieve(dt, uid_slik); 
            //staticFramework.retrieve(dt, pwd_slik);

            if (dt.Rows.Count > 0)
            {
                pwd_slik.Attributes["value"] = dt.Rows[0]["pwd_slik"].ToString();
            }

            if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
            {
                string decrypted_pass = Decrypt(pwd_slik.Attributes["value"], true);
                pwd_slik.Attributes["value"] = decrypted_pass;
            }



            staticFramework.retrieve(dt, "active", user_aktif);
            staticFramework.retrieve(dt, "flag_spv", flag_spv);




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


                if (dt.Rows[0]["flag_spv"].ToString().Equals("True"))
                {
                    flag_spv.SelectedIndex = 1;
                }
                else
                {
                    flag_spv.SelectedIndex = 0;
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

            DataTable dt2 = conn.GetDataTable("select * from sliklogindetail where userid = @1 and uid_slik = @2", par, dbtimeout);
            staticFramework.retrieve(dt2, username);

            //pwd_slik.Text = Decrypt(pwd_slik.Text, true);
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

        public string Crypt(string text, bool useHashing = true)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(text);
            AppSettingsReader appSettingsReader = new AppSettingsReader();
            string setting = this.getSetting("EncryptionKey");
            byte[] numArray;
            if (useHashing)
            {
                MD5CryptoServiceProvider cryptoServiceProvider = new MD5CryptoServiceProvider();
                numArray = cryptoServiceProvider.ComputeHash(Encoding.UTF8.GetBytes(setting));
                cryptoServiceProvider.Clear();
            }
            else
                numArray = Encoding.UTF8.GetBytes(setting);
            TripleDESCryptoServiceProvider cryptoServiceProvider1 = new TripleDESCryptoServiceProvider();
            cryptoServiceProvider1.Key = numArray;
            cryptoServiceProvider1.Mode = CipherMode.ECB;
            cryptoServiceProvider1.Padding = PaddingMode.PKCS7;
            byte[] inArray = cryptoServiceProvider1.CreateEncryptor().TransformFinalBlock(bytes, 0, bytes.Length);
            cryptoServiceProvider1.Clear();
            return Convert.ToBase64String(inArray, 0, inArray.Length);
        }

        public string Decrypt(string text, bool useHashing = true)
        {
            byte[] inputBuffer = Convert.FromBase64String(text);
            AppSettingsReader appSettingsReader = new AppSettingsReader();
            string setting = this.getSetting("EncryptionKey");
            byte[] numArray;
            if (useHashing)
            {
                MD5CryptoServiceProvider cryptoServiceProvider = new MD5CryptoServiceProvider();
                numArray = cryptoServiceProvider.ComputeHash(Encoding.UTF8.GetBytes(setting));
                cryptoServiceProvider.Clear();
            }
            else
                numArray = Encoding.UTF8.GetBytes(setting);
            TripleDESCryptoServiceProvider cryptoServiceProvider1 = new TripleDESCryptoServiceProvider();
            cryptoServiceProvider1.Key = numArray;
            cryptoServiceProvider1.Mode = CipherMode.ECB;
            cryptoServiceProvider1.Padding = PaddingMode.PKCS7;
            byte[] bytes = cryptoServiceProvider1.CreateDecryptor().TransformFinalBlock(inputBuffer, 0, inputBuffer.Length);
            cryptoServiceProvider1.Clear();
            return Encoding.UTF8.GetString(bytes);
        }

        public string getSetting(string Key)
        {
            string str = (string)null;
            try
            {
                str = ConfigurationManager.AppSettings[Key];
            }
            finally
            {
            }
            return str;
        }

        protected void ActSv(object sender, EventArgs e)
        {
            try
            {
                saveData();
                MyPage.popMessage((Page)this, "Data Berhasil Disimpan");
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
            //staticFramework.saveNVC(Fields, "active", user_aktif);

            //staticFramework.saveNVC(Fields, "pwd_slik", Crypt(pwd_slik.Text, true));

            //staticFramework.save(Fields, Keys, "sliklogin", conn);

            //object[] par = new object[] { userid.Text, uid_slik.Text, Crypt(pwd_slik.Text, true), user_aktif.SelectedValue, flag_spv.SelectedValue};
            object[] par = new object[] { userid.Text, uid_slik.Text, Crypt(pwd_slik.Text, true), user_aktif.SelectedValue, flag_spv.SelectedValue, "", username.Text.Trim() };


            if (Request.QueryString["userid"] != null && Request.QueryString["userid"] != "undefined")
            {
                conn.ExecNonQuery("exec SP_UPDATE_TO_CBASSLIK_SLIKLOGIN  @1,@2,@3,@4,@5,@6,@7 ", par, dbtimeout);
            }
            else
            {
                conn.ExecNonQuery("exec SP_INSERT_TO_CBASSLIK_SLIKLOGIN  @1,@2,@3,@4,@5,@6,@7 ", par, dbtimeout);
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
                conn.ExecNonQuery("DELETE FROM sliklogin WHERE userid = @1 AND uid_slik = @2 ", par, dbtimeout);
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