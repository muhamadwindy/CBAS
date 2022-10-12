<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadBulk.aspx.cs" Inherits="DebtChecking.Facilities.UploadBulk" %>

<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v20.2, Version=20.2, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <Template:Admin ID="templ" runat="server" />
    <title></title>
    <script>
        function onFileUploadComplete(s, e) {
            callback(mainPanel, 'excproc:' + e.callbackData);
            $('#messages').text('Processing, Please Wait!');
        }
    </script>
</head>
<body class="text-sm">
    <div class="container-fluid">
        <form id="form1" runat="server">
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <div class="row">
                        <div class="col-sm-6">
                            <h4 class="card-title">Request SLIK Via Upload Excel File</h4>
                        </div>
                        <div class="col-sm-6 text-right">
                            <asp:LinkButton ID="linkDownloadTemplate" runat="server" OnClick="linkDownloadTemplate_Click">Download Template</asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-6">

                            <dx:ASPxCallbackPanel ID="mainPanel" runat="server" Width="100%" BackColor="Transparent"
                                ClientInstanceName="mainPanel" OnCallback="mainPanel_Callback">
                                <ClientSideEvents EndCallback="function(s,e) {

                                        if (s.cp_new != '' && s.cp_new != undefined) {
                                            window.open(s.cp_new,'_parent');
                                            s.cp_new = '';
                                        }

                                        if (s.cp_url != '' && s.cp_url != undefined) {
                                            window.open(s.cp_url,'_blank,toolbar=no, location=yes,status=no,menubar=no,scrollbars=yes,resizable=no');
                                            s.cp_url = '';
                                        }

                                        if (s.cp_alert != '' && s.cp_alert != undefined) {
                                            alert(s.cp_alert);
                                            s.cp_alert = '';
                                        }
                                    $('#btn_upload').removeAttr('disabled');
                                    $('#messages').text('');
                                }" />

                                <PanelCollection>
                                    <dx:PanelContent ID="PanelContent1" runat="server">
                                        <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="100%"
                                            NullText="Select excel bulk files..." UploadMode="Advanced" OnFileUploadComplete="UploadControl_FileUploadComplete"
                                            ShowUploadButton="false" ShowProgressPanel="true" Theme="MaterialCompact">
                                            <AdvancedModeSettings EnableMultiSelect="false" EnableFileList="False" EnableDragAndDrop="True" />
                                            <ValidationSettings MaxFileSize="10485760" AllowedFileExtensions=".xls,.xlsx,">
                                            </ValidationSettings>
                                            <ClientSideEvents FileUploadComplete="onFileUploadComplete" />
                                        </dx:ASPxUploadControl>
                                    </dx:PanelContent>
                                </PanelCollection>
                            </dx:ASPxCallbackPanel>
                            <label id="message" class="label"></label>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <asp:Button class="btn btn-sm btn-primary" Text="Upload" ID="btn_upload" runat="server" OnClientClick="$('#btn_upload').attr('disabled','disabled'); UploadControl.UploadFile(); return false;" />
                </div>
            </div>
        </form>
    </div>
</body>
</html>