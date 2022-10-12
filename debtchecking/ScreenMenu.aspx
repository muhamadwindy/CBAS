<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ScreenMenu.aspx.cs" Inherits="DebtChecking.ScreenMenu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <Template:Admin runat="server" ID="Template" />

    <script type="text/javascript">

        $(document).ready(function () {

            $(".nav a").on("click", function () {
                $(".nav").find(".active").removeClass("active");
                $(this).parent().addClass("active");
            });

            $('#tabmenuAppear').hide();
            $('#framex').attr('src', $('#<%=firstLink.ClientID %>').val());
        });

        function changeUrl(_url) {

            $('#framex').attr('src', _url);
        }

        /**
         * Called to resize a given iframe.
         *
         * @param frame The iframe to resize.
         * nggowo screenmenu 
         * muhamad windy sulistiyo
         */
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
    <form runat="server" id="form1">
        <asp:HiddenField runat="server" ID="firstLink" />
        <div class="scroll-wrapper" style="background-color: white">
            <div class="container-fluid" style="display: none">
                <!-- Row start -->
                <div class="row" style="display: none">
                    <div class="col-md-12 col-sm-12 col-xs-12">
                        <div class="row rightinfo">
                            <a id="HrefBack" runat="server" style="color: #009da0; float: right;"><span class="glyphicon glyphicon-chevron-left"></span>Back </a>
                            <a href="main.aspx"><span class="glyphicon glyphicon-home"></span>Mainmenu </a>
                            <%--<a href="Logout.aspx" target="_parent"> | <span class="glyphicon glyphicon-log-out"></span> Logout </a>--%>
                        </div>
                    </div>
                </div>
                <!-- Row end -->
            </div>
            <div class="container box-shadow" style="display: none">
                <div class="row" runat="server" id="menu2">
                    <div class="col-md-12">
                        <h4>
                            <button type="button" id="tabmenuCollapse" class="btn btn-xs" style="background-color: #009da0; margin-left: 5px; padding-top: 3px; padding-bottom: 3px; padding-left: 7px; padding-right: 5px;">
                                <i class="glyphicon glyphicon-chevron-up" style="color: white"></i>
                                <span style="color: white">Tab Menu</span>
                            </button>
                            <button type="button" id="tabmenuAppear" class="btn btn-xs" style="background-color: #009da0; margin-left: 5px; padding-top: 5px; padding-bottom: 2px; padding-left: 7px; padding-right: 5px;">
                                <i class="glyphicon glyphicon-chevron-down" style="color: white"></i>
                                <span style="color: white">Tab Menu</span>
                            </button>

                            <span class="label" style="background-color: #009da0;" id="lblcust" runat="server">
                                <asp:Label runat="server" ID="MENUDESC"></asp:Label>
                                &nbsp-&nbsp<asp:Label runat="server" ID="Name"></asp:Label>
                                &nbsp (<asp:Label runat="server" ID="noKTP"></asp:Label>)
                            </span>
                        </h4>
                    </div>
                </div>

                <nav class="navbar navbar-default" runat="server" id="menu1" style="border-top: double; border-top-width: 1px; border-top-color: #009da0;">
                    <div class="container-fluid">
                        <div class="navbar-header">
                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar2" style="background-color: #009da0">
                                <span class="icon-bar" style="background-color: white"></span>
                                <span class="icon-bar" style="background-color: white"></span>
                                <span class="icon-bar" style="background-color: white"></span>
                            </button>
                        </div>
                        <div class="collapse navbar-collapse" id="myNavbar2">
                            <div class="scroller scroller-left"><i class="glyphicon glyphicon-chevron-left"></i></div>
                            <div class="scroller scroller-right"><i class="glyphicon glyphicon-chevron-right"></i></div>

                            <div class="dropdown">
                                <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">
                                    Daftar Form
                                  <span class="caret"></span>
                                </button>
                                <ul class="dropdown-menu" runat="server" id="navigation">
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>
            </div>
            <div>
                <div class="holds-the-iframe">
                    <iframe id="framex" name="framex" class="embed-responsive-item" framespacing="0" frameborder="0" border="0" width="100%" style="min-height: 300px !important"></iframe>
                </div>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#tabmenuCollapse').on('click', function () {
                $('#menu1').hide();

                $('#tabmenuAppear').show();
                $('#tabmenuCollapse').hide();

            });

            $('#tabmenuAppear').on('click', function () {
                $('#menu1').show();

                $('#tabmenuAppear').hide();
                $('#tabmenuCollapse').show();

            });

            var hidWidth;
            var scrollBarWidths = 100;

            var widthOfList = function () {
                var itemsWidth = 0;
                $('.list li').each(function () {
                    var itemWidth = $(this).outerWidth();
                    itemsWidth += itemWidth;
                });
                return itemsWidth;
            };

            var widthOfHidden = function () {
                return (($('.wrapper').outerWidth()) - widthOfList() - getLeftPosi()) - scrollBarWidths;
            };

            var getLeftPosi = function () {
                return $('.list').position().left;
            };

            var reAdjust = function () {
                if (($('.wrapper').outerWidth()) < widthOfList()) {
                    $('.scroller-right').show();
                }
            }

            reAdjust();

            $(window).on('resize', function (e) {
                reAdjust();
            });

            $('.scroller-right').click(function () {

                if (((widthOfList() + parseFloat($('.list').css("margin-left"))) - $('.wrapper').outerWidth()) <= 100) {
                    $('.scroller-left').fadeIn('slow');
                    $('.scroller-right').fadeOut('slow');
                }

                if ($('.wrapper').outerWidth() < (widthOfList() + parseFloat($('.list').css("margin-left")))) {
                    $('.scroller-left').fadeIn('slow');
                }

                $('.list').animate({ "margin-left": '-=100' }, 'slow', function () {

                });
            });

            $('.scroller-left').click(function () {

                if (parseFloat($('.list').css("margin-left")) >= -100) {
                    $('.scroller-right').fadeIn('slow');
                    $('.scroller-left').fadeOut('slow');
                }

                if (parseFloat($('.list').css("margin-left")) <= -100) {
                    $('.scroller-right').fadeIn('slow');
                }

                $('.list').animate({ "margin-left": '+=100' }, 'slow', function () {

                });

            });
        });
    </script>
</body>
</html>
