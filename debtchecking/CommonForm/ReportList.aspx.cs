using MWSFramework;
using System;
using System.Data;

namespace DebtChecking.Report
{
    public partial class ReportList : MasterPage
    {
        public string BackURL
        {
            get { return (string)Session["BackURL"]; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string strSQL = "", title = "";

                ReportSys.gridInit(grid, Request.QueryString["PV_ID"], ref title, ref strSQL, conn);
                TitleHeader.Text = title;
                ViewState["strSQL"] = strSQL;

                //ViewState["strSQL"] += " AND 0=1";
                //grid_Load(sender, e);
                //ViewState["strSQL"] = strSQL;
            }
        }

        protected void grid_Load()
        {
            for (int flg = 0; flg < UC_ReportFilter1.paramFilter?.Length; flg++)
            {
                if (UC_ReportFilter1.paramFilter[flg] is string)
                {
                    string param = (string)UC_ReportFilter1.paramFilter[flg];
                    if (param == "(none)")
                    {
                        UC_ReportFilter1.paramFilter[flg] = null;
                    }
                }
                else if (UC_ReportFilter1.paramFilter[flg] is DateTime)
                {
                    DateTime param = (DateTime)UC_ReportFilter1.paramFilter[flg];

                    UC_ReportFilter1.paramFilter[flg] = param.ToString("dd-MM-yyyy");
                }
            }

            ReportSys.gridBind(grid, (string)ViewState["strSQL"], UC_ReportFilter1.paramFilter, UC_ReportFilter1.strFilter, conn);
        }

        private void customSetting()
        {
            DataTable dt = null;
            if (Request.QueryString["PV_ID"]?.ToString() == "SLIK_INDIVIDU")
            {
                string sql = @"
SELECT

ID_Permintaan AS [ID Permintaan],
Kode_Ref_Pengguna AS [Kode Ref Pengguna],
Kode_LJK_Permintaan AS [Kode LJK Permintaan],
Tanggal_Permintaan AS [Tanggal Permintaan],
Posisi_Data_Terakhir AS [Posisi Data Terakhir],
No_Identitas_Debitur AS [No Identitas Debitur],
Nama_Debitur AS [Nama Debitur],
Jenis_Kelamin_Debitur AS [Jenis Kelamin Debitur],
Tempat_Lahir_Debitur AS [Tempat Lahir Debitur],
Tanggal_Lahir_Debitur AS [Tanggal Lahir Debitur],
NPWP_Debitur AS [NPWP Debitur],
Pelapor AS [Pelapor],
Tgl_Update AS [Tgl Update],
No_Identitas AS [No Identitas],
Nama AS [Nama],
Jenis_Kelamin AS [Jenis Kelamin],
Tempat_Lahir AS [Tempat Lahir],
Tanggal_Lahir AS [Tanggal Lahir],
Alamat AS [Alamat],
Kelurahan AS [Kelurahan],
Kecamatan AS [Kecamatan],
Kabupaten_Kota AS [Kabupaten Kota],
Kode_Pos AS [Kode Pos],
Pekerjaan AS [Pekerjaan],
Bidang_Usaha AS [Bidang Usaha],
Plafon_Efektif_Total AS [Plafon Efektif Total],
Baki_Debet_Total AS [Baki Debet Total],
Jml_Kreditur_Bank_Umum AS [Jml Kreditur Bank Umum],
Jml_Kreditur_BPRS AS [Jml Kreditur BPRS],
Jml_Kreditur_LP AS [Jml Kreditur LP],
Jml_Kreditur_Lainnya AS [Jml Kreditur Lainnya],
Jml_Kreditur_Total AS [Jml Kreditur Total],
Kualitas_Terburuk AS [Kualitas Terburuk],
Bulan_Data_Terburuk AS [Bulan Data Terburuk],
LJK_Pelapor AS [LJK Pelapor],
Cabang_LJK_Pelapor AS [Cabang LJK Pelapor],
Baki_Debet AS [Baki Debet],
Tanggal_Update_Kredit AS [Tanggal Update Kredit],
Sifat_Pembiayaan AS [Sifat Pembiayaan],
Jenis_Pembiayaan AS [Jenis Pembiayaan],
Akad_Pembiayaan AS [Akad Pembiayaan],
Tanggal_Mulai AS [Tanggal Mulai],
Tanggal_Jatuh_Tempo AS [Tanggal Jatuh Tempo],
Kategori_Debitur AS [Kategori Debitur],
Jenis_Penggunaan AS [Jenis Penggunaan],
Kota_Lokasi_Proyek AS [Kota Lokasi Proyek],
Kualitas AS [Kualitas],
Jumlah_Hari_Tunggakan AS [Jumlah Hari Tunggakan],
Plafon AS [Plafon],
Sebab_Macet AS [Sebab Macet],
Tanggal_Macet AS [Tanggal Macet],
Tunggakan_Pokok AS [Tunggakan Pokok],
Tunggakan_Bunga AS [Tunggakan Bunga],
Frekuensi_Tunggakan AS [Frekuensi Tunggakan],
Tunggakan_Denda AS [Tunggakan Denda],
Frekuensi_Restrukturisasi AS [Frekuensi Restrukturisasi],
Tanggal_Restrukturisasi AS [Tanggal Restrukturisasi],
Kondisi_Fasilitas AS [Kondisi Fasilitas],
Besaran_Suku_Bunga AS [Besaran Suku Bunga],
Jenis_Suku_Bunga AS [Jenis Suku Bunga],
Tanggal_Update_Agunan AS [Tanggal Update Agunan],
Jenis_Agunan AS [Jenis Agunan],
Nilai_Agunan AS [Nilai Agunan],
Persentase_Paripasu AS [Persentase Paripasu],
Nomor_Agunan AS [Nomor Agunan],
Jenis_Pengikatan AS [Jenis Pengikatan],
Nama_Pemilik_Agunan AS [Nama Pemilik Agunan],
Alamat_Agunan AS [Alamat Agunan],
Lokasi_Agunan AS [Lokasi Agunan],
Asuransi AS [Asuransi],
Tanggal_Update_Penjamin AS [Tanggal Update Penjamin],
No_Identitas_Penjamin AS [No Identitas Penjamin],
Nama_Penjamin AS [Nama Penjamin],
Jenis_Penjamin AS [Jenis Penjamin],
Alamat_Penjamin AS [Alamat Penjamin],
Keterangan_ AS [Keterangan ],
Tanggal_iDeb_upload AS [Tanggal iDeb upload],
Tanggal_Result_Matriks AS [Tanggal Result Matriks],
Tanggal_Input AS [Tanggal Input],
Tanggal_Approve_BM AS [Tanggal Approve BM],
Tanggal_Approve_Credit_Ratin AS [Tanggal Approve Credit Rating]

FROM  REPORT_INDIVIDU WHERE 1=1
AND ID_Permintaan Like '%" + UC_ReportFilter1.paramFilter?[0] + @"%'
AND Kode_Ref_Pengguna like '%" + UC_ReportFilter1.paramFilter?[1] + @"%'
AND No_Identitas_Debitur like '%" + UC_ReportFilter1.paramFilter?[2] + @"%'
AND Nama_Debitur like '%" + UC_ReportFilter1.paramFilter?[3] + @"%'";

                if (UC_ReportFilter1.paramFilter?[4] != null)
                {
                    //sql += " AND Tanggal_Input >= '" + UC_ReportFilter1.paramFilter[4] + "' ";
                    sql += " AND Tanggal_Approve_Credit_Ratin >= '" + UC_ReportFilter1.paramFilter[4] + "' ";
                }
                if (UC_ReportFilter1.paramFilter?[5] != null)
                {
                    //sql += " AND Tanggal_Input <= '" + UC_ReportFilter1.paramFilter[5] + "'";
                    sql += " AND Tanggal_Approve_Credit_Ratin <= '" + UC_ReportFilter1.paramFilter[5] + "'";
                }

                dt = conn.GetDataTable(sql, UC_ReportFilter1.paramFilter, dbtimeout);

                ReportSys.gridBind(grid, sql, UC_ReportFilter1.paramFilter, UC_ReportFilter1.strFilter, conn);

                grid.DataSource = dt;
                grid.DataBind();
            }
            else
            {
                ReportSys.gridBind(grid, (string)ViewState["strSQL"], UC_ReportFilter1.paramFilter, UC_ReportFilter1.strFilter, conn);
            }
        }

        protected void mainPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
        {
            grid_Load();
        }
    }
}