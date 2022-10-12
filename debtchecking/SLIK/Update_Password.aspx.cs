using DevExpress.Web;
using MWSFramework;
using System;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Security.Cryptography;
using System.Text;

namespace DebtChecking.SLIK
{
    public partial class Update_Password : DataPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            bindSLIKViewer();
            bindSLIKLogin();
        }

        private void bindSLIKViewer()
        {
            DataTable data = conn.GetDataTable("select * from slikloginviewer", null, dbtimeout);

            for (int i = 0; i < data.Rows.Count; i++)
            {
                data.Rows[i]["pwd_viewer"] = (data.Rows[i]["pwd_viewer"].ToString());
            }
            GridSLIKViewer.DataSource = data;
            GridSLIKViewer.DataBind();


        }

        private void bindSLIKLogin()
        {
            DataTable data = conn.GetDataTable("select * from sliklogin", null, dbtimeout);

            for (int i = 0; i < data.Rows.Count; i++)
            {
                data.Rows[i]["pwd_slik"] = Decrypt(data.Rows[i]["pwd_slik"].ToString(), true);
            }
            GridSLIKLogin.DataSource = data;
            GridSLIKLogin.DataBind();
        }

        protected void deleteSLIKViewer(string id)
        {
            try
            {
                string[] s = id.Split('|');
                object[] par = new object[] { s[0], s[1] };
                conn.ExecNonQuery("DELETE FROM slikloginviewer WHERE userid = @1 AND uid_slik = @2 ", par, dbtimeout);
            }
            catch (Exception ex)
            {
                mainPanel.JSProperties["cp_alert"] = ex.Message.IndexOf("Last Query:") <= 0 ? ex.Message : ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
            }
        }

        protected void deleteSLIKLogin(string id)
        {
            try
            {
                string[] s = id.Split('|');
                object[] par = new object[] { s[0], s[1] };
                conn.ExecNonQuery("DELETE FROM sliklogin WHERE userid = @1 AND uid_slik = @2 ", par, dbtimeout);
            }
            catch (Exception ex)
            {
                mainPanel.JSProperties["cp_alert"] = ex.Message.IndexOf("Last Query:") <= 0 ? ex.Message : ex.Message.Substring(0, ex.Message.IndexOf("Last Query:"));
            }
        }

        protected void mainPanel_Callback(object sender, CallbackEventArgsBase e)
        {
            if (e.Parameter.ToString().StartsWith("sliklogin_delete:"))
            {
                deleteSLIKLogin(e.Parameter.Substring(e.Parameter.IndexOf(':') + 1));
                bindSLIKLogin();
                mainPanel.JSProperties["cp_close_modal"] = "modalSLIKLogin";
                mainPanel.JSProperties["cp_tab"] = "link-tab-sliklogin";
            }
            else if (e.Parameter.ToString().StartsWith("sliklogin_save"))
            {
                NameValueCollection Keys = new NameValueCollection();
                NameValueCollection Fields = new NameValueCollection();

                staticFramework.saveNVC(Keys, "userid", sliklogin_userid);
                staticFramework.saveNVC(Keys, "uid_slik", sliklogin_uid_slik);
                staticFramework.saveNVC(Fields, "active", sliklogin_active);
                staticFramework.saveNVC(Fields, "flag_spv", sliklogin_flag_spv);
                staticFramework.saveNVC(Fields, "pwd_slik", Crypt(sliklogin_pwd_slik.Text, true));
                staticFramework.save(Fields, Keys, "cbasslik.dbo.sliklogin", conn);
                bindSLIKLogin();
                mainPanel.JSProperties["cp_close_modal"] = "modalSLIKLogin";
                mainPanel.JSProperties["cp_tab"] = "link-tab-sliklogin";
            }
            else if (e.Parameter.ToString().StartsWith("slikviewer_delete:"))
            {
                deleteSLIKViewer(e.Parameter.Substring(e.Parameter.IndexOf(':') + 1));
                bindSLIKViewer();
                mainPanel.JSProperties["cp_close_modal"] = "modalSLIKViewer";
                mainPanel.JSProperties["cp_tab"] = "link-tab-slikviewer";
            }
            else if (e.Parameter.ToString().StartsWith("slikviewer_save"))
            {
                NameValueCollection Keys = new NameValueCollection();
                NameValueCollection Fields = new NameValueCollection();

                staticFramework.saveNVC(Keys, "userid", slikviewer_userid);
                staticFramework.saveNVC(Fields, "uid_slik", slikviewer_uid_slik);
                string pwd = (slikviewer_pwd_viewer.Text);
                staticFramework.saveNVC(Fields, "pwd_viewer", pwd);
                staticFramework.saveNVC(Fields, "active", slikviewer_active);
                staticFramework.save(Fields, Keys, "cbasslik.dbo.slikloginviewer", conn);
                bindSLIKViewer();
                mainPanel.JSProperties["cp_close_modal"] = "modalSLIKViewer";
                mainPanel.JSProperties["cp_tab"] = "link-tab-slikviewer";
            }

            mainPanel.JSProperties["cp_alert"] = "Berhasil!";
        }

        private string Crypt(string text, bool useHashing = true)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(text);
            AppSettingsReader appSettingsReader = new AppSettingsReader();
            string setting = ConfigurationManager.AppSettings["EncryptionKey"];
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
            string setting = ConfigurationManager.AppSettings["EncryptionKey"];
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

    }
}