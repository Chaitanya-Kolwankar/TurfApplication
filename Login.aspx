<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="VSS" />

    <title>Abrahamscourt | Login</title>
    <link rel="icon" href="img/Abrahamscourt_logo.png" />

    <!-- Custom fonts for this template-->
    <link href="vendors/fontawesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />

    <%-- Jquery --%>
    <script src="assets/JQuery/jquery.min.js"></script>

    <!-- Notify -->
    <link href="CSS/notify-master/css/notify.css" rel="stylesheet" />
    <link href="assets/css/hope-ui.min.css" rel="stylesheet" />
    <!-- Custom -->
    <link href="CSS/blockselect.css" rel="stylesheet" />
    <style>
        .bg-img {
            background-image: url('assets/images/auth/01.png');
            background-size: cover;
            background-position: center;
            text-align: center;
            vertical-align: middle;
        }

        .adjust_img {
            padding-bottom: 10px;
        }
    </style>
</head>
<body class="bg-img">
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="container">
                <div class="row justify-content-center align-items-center vh-100">
                    <div class="col-xl-5 col-lg-5">
                        <div class="card o-hidden border-0 shadow-lg my-5" style="background-color: rgba(0,0,0,.5); box-shadow: -1px 4px 28px 0px rgb(0 0 0 / 75%);">
                            <div class="card-body p-0 bg-transparent">
                                <div class="p-5">
                                    <div class="adjust_img">
                                        <img src="img/Abrahamscourt_logo.png" height="100" width="100" draggable="false" alt="backgroundimage" />
                                    </div>
                                    <h4 style="color: white">Abrahamscourt Login</h4>
                                    <hr class="sidebar-divider my-0" style="background-color: #3b5998" />
                                    <br />
                                    <div class="form-group">
                                        <div style="color:white; text-align:start; padding:2px; font-weight:200">
                                            Enter Username:
                                        </div>
                                        <asp:TextBox ID="txt_username" runat="server" placeholder="Username" MaxLength="8" class="form-control form-control-user text-dark textbox" autocomplete="off"></asp:TextBox>
                                    </div>
                                    <div class="form-group">
                                        <div style="color:white; text-align:start; padding:2px; font-weight:200">
                                            Enter Password:
                                        </div>
                                        <asp:TextBox ID="txt_password" runat="server" placeholder="Password" MaxLength="95" type="password" class="form-control form-control-user text-dark textbox" autocomplete="off"></asp:TextBox>
                                    </div>
                                    <div class="error_msg" style="font-size: 11px; padding-bottom: 9px;">
                                        <asp:Label runat="server" ID="lbl_message" Text="" Style="color:red;" CssClass="fs-6"></asp:Label>
                                    </div>
                                    <div class="form-group">
                                        <asp:Button ID="btn_lgn" runat="server" CssClass="btn btn-danger" Text="LOGIN" BorderStyle="None" Width="100%" Style="background: linear-gradient(to right,#15a578 , #3698fb);" OnClick="btn_lgn_Click"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <script>
        $(".textbox").on("input", function () {
            $("#lbl_message").text("");
        });

        //Block Right Click
        document.addEventListener("contextmenu", (event) => {
            event.preventDefault();
        });
    </script>

    <%--Notify--%>
    <script src="CSS/notify-master/js/notify.js"></script>

</body>
</html>
