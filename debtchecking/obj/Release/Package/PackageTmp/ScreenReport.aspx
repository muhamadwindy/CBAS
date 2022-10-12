<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScreenReport.aspx.cs" Inherits="DebtChecking.ScreenReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <Template:Admin runat="server" ID="Template" />

    <script type="text/javascript">

        $(document).ready(function () {
            $(".nav-link").click(function () {
                $('#frameReport').attr('src', 'about:blank');
                var id = $(this).data("report");
                changeUrl(id);
            })

            $('.nav-item a')[0].click();

        });

        function changeUrl(idrep) {
            $('#frameReport').attr('src', $('#<%=urlReport.ClientID %>').val() + idrep);
        }

        function resize(frame) {

            var b = frame.contentWindow.document.body || frame.contentDocument.body,
                cHeight = $(b).height() + 25;

            if ($(frame).attr("src") === undefined) {

            } else {
                if (frame.oHeight !== cHeight) {
                    $(frame).height(0);
                    frame.style.height = 0;

                    $(frame).height(cHeight);
                    frame.style.height = cHeight + "px";

                    frame.oHeight = cHeight;
                }
            }

            // Call again to check whether the content height has changed.
            setTimeout(function () { resize(frame); }, 100);
        }

        window.onload = function () {

            var frame,
                frames = document.getElementsByTagName('iframe'),
                i = frames.length - 1;

            while (i >= 0) {
                frame = frames[i];
                frame.onload = resize(frame);

                i -= 1;
            }

        };
    </script>
</head>
<body>
    <div class="container-fluid text-sm">
        <form id="form1" runat="server">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card card-primary card-outline card-tabs">
                        <div class="card-header p-0 pt-1 border-bottom-0">
                            <asp:HiddenField runat="server" ID="urlReport" Value="Report/Report.aspx?id=" />
                            <ul class="nav nav-tabs" id="reporttab" role="tablist" runat="server">
                            </ul>
                        </div>

                        <div class="card-body">
                            <div class="tab-content" id="tabContent">
                                <div class="tab-pane fade active show" id="tab-pengajuan-request" role="tabpanel"
                                    aria-labelledby="tab-pengajuan-request">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="holds-the-iframe">
                                                <iframe id="frameReport" name="framex" class="embed-responsive-item" framespacing="0" frameborder="0" border="0" width="100%" style="min-height: 300px !important"></iframe>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</body>
</html>