<%@ Page Title="" Language="C#" MasterPageFile="~/Application.master" AutoEventWireup="true" CodeFile="booking_confirm.aspx.cs" Inherits="booking_confirm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel runat="server" ID="updt">
        <ContentTemplate>
            <div class="card shadow" data-aos="fade-up" data-aos-delay="300">
                <div class="card-body">
                    <div class="card bg-soft-success" id="div_bg" runat="server">
                        <div class="card-body" style="text-align:center">
                                <h5><asp:Label runat="server" ID="lblmsg" Text="Booking Confirmed for id : | Confirmation Mail Sent"></asp:Label></h5>
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

