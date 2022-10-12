using DMS.Tools;
using MWSFramework;
using System;
using System.Collections.Specialized;
using System.Data;

namespace MikroMnt.parameter
{
    public partial class matrix : System.Web.UI.Page
    {
        private DbConnection conn = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                initial_reffrential_parameter();
            }
        }

        private void initial_reffrential_parameter()
        {
            staticFramework.reff(PRODUCTID, "select * FROM rfproduct", null, conn);
        }

        protected override void OnLoad(EventArgs e)
        {
            string modid = "61";
            if (Request.QueryString["moduleid"] != null && Request.QueryString["moduleid"].Trim() != "")
                modid = Request.QueryString["moduleid"];
            conn = new DbConnection(MNTTools.GetConnString(modid));
            base.OnLoad(e);
        }

        protected override void OnUnload(EventArgs e)
        {
            base.OnUnload(e);
            try
            {
                conn.Dispose();
            }
            catch { }
        }

        private void save_data()
        {
            string msgs = "";
            if (PRODUCTID.SelectedValue == "")
            {
                msgs += "Produk Harus Diisi!\r\n";
            }
            if (BAKI_DEBET.Text == "")
            {
                msgs += "Outstanding Harus Diisi!\r\n";
            }
            if (HT_LAST_MONTH.Text == "")
            {
                msgs += "Hari Tunggakan Bulan Terakhir Harus Diisi!\r\n";
            }
            if (HT_LAST_12MONTH.Text == "")
            {
                msgs += "Hari Tunggakan 12 Bulan Terakhir Harus Diisi!\r\n";
            }
            if (PLAFON.Text == "")
            {
                msgs += "Plafon Harus Diisi!\r\n";
            }
            if (PLAFON_AWAL.Text == "")
            {
                msgs += "Plafon Awal Harus Diisi!\r\n";
            }

            if (msgs != "")
            {
                mainPanel.JSProperties["cp_alert"] = msgs;
                return;
            }
            NameValueCollection Keys = new NameValueCollection();
            staticFramework.saveNVC(Keys, PRODUCTID);
            NameValueCollection Fields = new NameValueCollection();
            staticFramework.saveNVC(Fields, HT_LAST_MONTH);
            staticFramework.saveNVC(Fields, HT_LAST_12MONTH);
            staticFramework.saveNVC(Fields, BAKI_DEBET);
            staticFramework.saveNVC(Fields, PLAFON);
            staticFramework.saveNVC(Fields, PLAFON_AWAL);
            staticFramework.save(Fields, Keys, "CBASSLIK.dbo.rfmatrixparam", conn);

            mainPanel.JSProperties["cp_alert"] = "Berhasil!";
        }

        protected void mainPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            if (e.Parameter.StartsWith("cproductid"))
            {
                getdata();
            }
            else
            {
                save_data();
            }
        }

        protected void getdata()
        {
            DataTable dt = conn.GetDataTable("select * from CBASSLIK.dbo.rfmatrixparam where Productid = @1 ",
                new object[] { PRODUCTID.SelectedValue }, 0); 
            staticFramework.retrieve(dt, HT_LAST_MONTH);
            staticFramework.retrieve(dt, HT_LAST_12MONTH);
            staticFramework.retrieve(dt, BAKI_DEBET);
            staticFramework.retrieve(dt, PLAFON);
            staticFramework.retrieve(dt, PLAFON_AWAL);

        }
    }
}