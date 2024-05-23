<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="Admin_booking.aspx.cs" Inherits="Admin_booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .HiddenCol {
            display: none;
        }

        .clicklable {
            cursor: pointer;
            display: inline-block;
            transition: transform 0.2s;
        }

            .clicklable:hover {
                transform: scale(1.1);
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="updt">
        <ContentTemplate>
            <div class="card shadow" data-aos="fade-up" data-aos-delay="300">
                <div class="card-header border-bottom border-primary border-3">
                    <div class="row" style="padding-bottom: 14px;">
                        <div class="col-md-6 col- col-sm-6 col-xs-6">
                            <h4>Admin Booking</h4>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 mt-2">
                            <asp:TextBox ID="txt_date" runat="server" TextMode="Date" MaxLength="10" class="form-control" autocomplete="off"></asp:TextBox>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 mt-2">
                            <asp:Button runat="server" ID="btn_data" CssClass="btn btn-block btn-primary form-control" Text="Get Booking" OnClick="btn_data_Click" />
                        </div>
                    </div>
                    <br />
                    <div class="row table-responsive">
                        <asp:GridView ID="grd_data" runat="server" CssClass="table" AutoGenerateColumns="false" Width="100%" data-toggle="data-table">
                            <Columns>
                                <asp:TemplateField HeaderText="Booking ID">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_id" runat="server"  CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Booking_id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_name" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Phone">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Phone" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Phone") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Email" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Location" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Turf_location") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Type" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Turf_type") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Date" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Date") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Form Time">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Form_time" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Form_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="To Time">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_To_time" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("To_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Time">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Total_time" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Total_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Advance">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Adv_amount" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Adv_amount") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Total_amount" runat="server" CssClass='<%# Eval("confirm_flag").ToString() == "1" ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Total_amount") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <HeaderStyle CssClass="HiddenCol" />
                                    <ItemTemplate>
                                        <asp:Button runat="server" ID="btn_edit" CssClass="grid-button" />
                                    </ItemTemplate>
                                    <ItemStyle CssClass="HiddenCol" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script>
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            call_datatable();
            removecardaos();
            clickable();
        });

        function removecardaos() {
            $('.card').removeAttr("data-aos");
            $('.card').removeAttr("data-aos-delay");
        };

        function call_datatable() {
            $('#<%= grd_data.ClientID %>').DataTable({
                destroy: true,
                "drawCallback": function (settings) {
                    clickable()
                }
            });
        }

        function clickable() {
            $(".clicklable").click(function () {
                var linkButton = $(this).closest("tr").find(".grid-button");
                linkButton.click();
            });
        }
        clickable();
    </script>
</asp:Content>

