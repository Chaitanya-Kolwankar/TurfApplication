<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="updt">
        <ContentTemplate>
            <div class="card shadow" data-aos="fade-up" data-aos-delay="300">
                <div class="card-header border-bottom border-primary border-3">
                    <div class="row" style="padding-bottom: 14px;">
                        <div class="col-md-6 col- col-sm-6 col-xs-6">
                            <h4>Admin</h4>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-lg-10 col-md-10 col-sm-10 col-xs-12">
                            <div class="row">
                                <div class="col-md-3 col-sm-12 col-xs-12 mt-2">
                                    <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                        <span class="input-group-text text-primary">Full</span>
                                        <asp:TextBox ID="txt_full" CssClass="form-control txt_location" runat="server" Enabled="false" MaxLength="4" onkeypress="return allowonlynumbers(event,this);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-12 col-xs-12 mt-2">
                                    <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                        <span class="input-group-text text-primary">Open</span>
                                        <asp:TextBox ID="txt_open" CssClass="form-control txt_location" runat="server" Enabled="false" MaxLength="4" onkeypress="return allowonlynumbers(event,this);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-12 col-xs-12 mt-2">
                                    <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                        <span class="input-group-text text-primary">Box</span>
                                        <asp:TextBox ID="txt_box" CssClass="form-control txt_location" runat="server" Enabled="false" MaxLength="4" onkeypress="return allowonlynumbers(event,this);"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3 col-sm-12 col-xs-12 mt-2">
                                    <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                        <span class="input-group-text text-primary">Advance</span>
                                        <asp:TextBox ID="txt_adv" CssClass="form-control txt_location" runat="server" Enabled="false" MaxLength="4" onkeypress="return allowonlynumbers(event,this);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            <br />
                        </div>
                        <div class="col-lg-2 col-md-2 col-sm-2 col-xs-12 mt-2">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div class="input-group shadow">
                                        <asp:Button ID="btn_img" runat="server" CssClass="btn form-control btn-info shadow" OnClientClick="return image_click();" Text="Add QR" Enabled="false" data-aos-delay="200" />
                                        <asp:LinkButton runat="server" ID="btn_imgdelete" OnClick="btn_imgdelete_Click" ToolTip="Delete Image" class="input-group-text btn table-success shadow" Style="background-color: #f16b6b; display: none;"><i class="fa fa-lg fa-trash close-button"></i></asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-md-12 col-sm-12 col-xs-12 pt-2">
                                    <asp:Image runat="server" ID="Image1" class="img-fluid" Style="display: none; height: 120px; margin-top: 2px;" Width="100%" />
                                    <asp:HiddenField ID="hidden_img" runat="server" ClientIDMode="Static" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-4 col-sm- col-xs-12"></div>
                        <div class="col-md-2 col-sm-2 col-xs-12 mt-1">
                            <asp:Button ID="btn_edit" runat="server" CssClass="btn btn-block btn-primary form-control" Text="Edit" OnClick="btn_edit_Click" data-aos-delay="200" />
                        </div>
                        <div class="col-md-2 col-sm-2 col-xs-12 mt-1">
                            <asp:Button ID="btn_save" runat="server" CssClass="btn btn-block btn-primary form-control" Enabled="false" MaxLength="4" Text="Save" OnClick="btn_save_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:FileUpload runat="server" ID="img_logo" onchange="ShowImagePreview(this);" Style="display: none;" />
    <script>
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            removecardaos();
        });

        function removecardaos() {
            $('.card').removeAttr("data-aos");
            $('.card').removeAttr("data-aos-delay");
        };

        function ShowImagePreview(input) {

            if (input.files && input.files[0]) {

                var extension = input.value.split('.').pop().toLowerCase();
                if (["jpeg", "jpg", "png"].indexOf(extension) === -1) {
                    $.notify("Only JPEG, JPG, And PNG Files Are Allowed", { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
                    input.value = "";
                    $("#hidden_img").val(null);
                    return;
                }
                if (input.files[0].size > 500000) { // 500kb
                    $.notify("File Size Must Be Less Than 500KB", { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });
                    input.value = "";
                    $("#hidden_img").val(null);
                    return;
                }
                var reader = new FileReader();
                reader.onload = function (e) {
                    var fileData = reader.result.split(',')[1];
                    $("#hidden_img").val(fileData);
                    $('#<%=Image1.ClientID%>').prop('src', e.target.result);
                };
                reader.readAsDataURL(input.files[0]);
                $('#<%= Image1.ClientID %>').css("display", "");
                $('#<%= btn_imgdelete.ClientID %>').css("display", "");
            }
        }

        function image_click() {
            $('#<%= img_logo.ClientID %>').click();
        }
    </script>
</asp:Content>

