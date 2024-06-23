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

        .modal {
            --bs-modal-width: 1000px !important;
        }

        .transparent-modal {
            background-color: transparent !important;
            border: 0px;
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
                            <asp:TextBox ID="txt_date" runat="server" TextMode="Date" MaxLength="10" class="form-control"  OnTextChanged="txt_date_TextChanged" AutoPostBack="true"></asp:TextBox>
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 mt-2">
                            <asp:Button runat="server" ID="btn_add" CssClass="btn btn-block btn-info form-control" Text="Add Booking" OnClientClick="$('#Modal_add').modal('show');" />
                        </div>
                    </div>
                    <br />
                    <div class="row table-responsive">
                        <asp:GridView ID="grd_data" runat="server" CssClass="table" AutoGenerateColumns="false" Width="100%" data-toggle="data-table">
                            <Columns>
                                <asp:TemplateField HeaderText="Status" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_status" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("confirm_flag") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Booking ID">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_id" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Booking_id") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Name">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_name" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Name") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Phone">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Phone" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Phone") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Email" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Location">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Location" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Turf_location") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Type">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Type" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Turf_type") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Date" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Date") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Form Time">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Form_time" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Form_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="To Time">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_To_time" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("To_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Time">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Total_time" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Total_time") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Advance">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Adv_amount" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Adv_amount") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="grdlbl_Total_amount" runat="server" CssClass='<%# Convert.ToBoolean(Eval("confirm_flag")) == true ? "text-success clicklable" : "clicklable" %>' Text='<%# Eval("Total_amount") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <HeaderStyle CssClass="HiddenCol" />
                                    <ItemTemplate>
                                        <asp:Button runat="server" ID="btn_edit" CssClass="grid-button" OnClick="btn_edit_Click" />
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

    <%-- Modal  --%>

    <div class="modal fade" id="Modal_add" tabindex="-1" aria-labelledby="Modal_qrLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="modal-dialog" style="height: 94vh;">
                    <div class="modal-content transparent-modal">
                        <div class="modal-body align-content-center flex-container transparent-modal">
                            <div class="card shadow w-100">
                                <div class="card-header  border-bottom border-primary border-3">
                                    <div class="row" style="padding-bottom: 14px;">
                                        <div class="col-md-12 col-sm-12">
                                            <h4>Add Booking</h4>
                                        </div>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_Bk_id" runat="server" Placeholder="Booking ID" class="form-control" ReadOnly="true" ></asp:TextBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:DropDownList ID="ddl_location" runat="server" CssClass="form-select shadow">
                                                <asp:ListItem Text="Select Location" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Vatar" Value="Vatar"></asp:ListItem>
                                                <asp:ListItem Text="Sopara" Value="Sopara"></asp:ListItem>
                                                <asp:ListItem Text="East" Value="East"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:DropDownList ID="ddl_type" runat="server" CssClass="form-select shadow">
                                                <asp:ListItem Text="Select Type" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Full" Value="Full"></asp:ListItem>
                                                <asp:ListItem Text="Open" Value="Open"></asp:ListItem>
                                                <asp:ListItem Text="Box" Value="Box"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_bk_date" runat="server" TextMode="Date" MaxLength="10" class="form-control date_flatpicker" ></asp:TextBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_from_time" runat="server" MaxLength="5" Placeholder="From Time" class="form-control"></asp:TextBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_to_time" runat="server" MaxLength="5" Placeholder="To Time" class="form-control"></asp:TextBox>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_adv_amt" runat="server" MaxLength="10" Placeholder="Advance" class="form-control" ></asp:TextBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_amt" runat="server" MaxLength="10" Placeholder="Total Amount" class="form-control" ></asp:TextBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:DropDownList ID="ddl_status" runat="server" CssClass="form-select shadow">
                                                <asp:ListItem Text="Select Status" Value=""></asp:ListItem>
                                                <asp:ListItem Text="Confirm" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="Cancel" Value="0"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_name" runat="server" MaxLength="10" Placeholder="Name" class="form-control" ></asp:TextBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_phone" runat="server" MaxLength="10" Placeholder="Phone" class="form-control" ></asp:TextBox>
                                        </div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:TextBox ID="txt_mail" runat="server" MaxLength="10" Placeholder="E-Mail" class="form-control" ></asp:TextBox>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-lg-4 col-md-3 col-sm-12 col-xs-12 mt-2"></div>
                                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                            <asp:Button runat="server" ID="btn_save" CssClass="btn btn-block btn-info form-control" Text="Save Booking" OnClick="btn_save_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <%-- Modal  --%>


    <script>
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            call_datatable();
            removecardaos();
            clickable();
            loadtimepicker();
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

        function loadtimepicker() {
            $('#<%= txt_from_time.ClientID %>').timepicker({ timeFormat: 'H:i', step: 30 });
            $('#<%= txt_to_time.ClientID %>').timepicker({ timeFormat: 'H:i', step: 30 });
        }
    </script>

</asp:Content>

