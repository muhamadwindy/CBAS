using DevExpress.Web;
using System;
using System.IO;
using System.Web;

namespace DebtChecking.Facilities
{
    public partial class UploadTemplateMaster : DataPage
    {
        #region initial_reffrential_parameter

        protected void initial_reffrential_parameter()
        {
        }

        #endregion initial_reffrential_parameter
         
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void PanelFile_Callback(object source, CallbackEventArgsBase e)
        {
            //string fullpath = Session["UploadRestoreData"].ToString();

            // excelToDb(fullpath);

            //try { File.Delete(fullpath); }
            //catch { }
        }

        protected void ImportFile_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            HttpPostedFile userPostedFile = ImportFile.PostedFile;
            if (userPostedFile != null && userPostedFile.ContentLength > 0)
            {
                if (Path.GetExtension(userPostedFile.FileName) == ".xlt")
                {
                    string url = Request.Url.Scheme + "://" + Request.Url.Host + ResolveUrl("~/") + "/templates/master/loancalculator.xlt";
                    string oldFile = Server.MapPath("~/templates/master/loancalculator.xlt");
                    string newFile = Server.MapPath("~/templates/master/") + Path.GetFileNameWithoutExtension(oldFile) + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".xlt";
                    File.Move(oldFile, newFile);
                    userPostedFile.SaveAs(oldFile);
                    Response.Write("<script language=javascript>alert('Upload file Loan Calculator Template Success');</script>");
                    //TXT_PROGRESS.Text = "Upload file Loan Calculator Template Success";
                    btnSave.Attributes.Add("disabled", "disabled");
                }
                else
                {
                    Response.Write("<script language=javascript>alert('File Content Type is Invalid');</script>");
                }
            }
        }
    }
}