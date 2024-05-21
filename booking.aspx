<%@ Page Title="" Language="C#" MasterPageFile="~/Application.master" AutoEventWireup="true" CodeFile="booking.aspx.cs" Inherits="booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="CSS/booking.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="card shadow">
        <div class="card-header border-bottom border-primary border-3 justify-content-center">
            <div class="row" style="padding-bottom: 14px;">
                <h4>
                    <sapn id="card_tital">Select Location</sapn>
                </h4>
            </div>
        </div>
        <div class="card-body">
            <div id="location">
                <div class="row">
                    <asp:HiddenField ID="hidden_location" runat="server"></asp:HiddenField>
                    <div class="col-lg-2 col-md-2 col-sm-0 col-xs-0"></div>
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                <div class="card text-center shadow shadow-lg turf-location" style="background-image: url('img/turf.jpeg'); background-size: cover; border-radius: 20px 20px 20px 20px" id="vatar">
                                    <div class="card-body">
                                        <div style="height: 26vh;"></div>
                                    </div>
                                    <div class="card-footer p-2" style="border-radius: 20px 20px 0 0">
                                        <h3 class=""><span class="fa fa-futbol-o"></span>&nbsp;Vatar</h3>
                                        <sapn class="mt-3" style="font-size: small"><span class="fa fa-lg fa-map-marker"></span>&nbsp;&nbsp;<a style="" href="https://www.google.com/maps/dir//Dontalav+Village,+Virar+West+Opposite+manvel+petrol+pump,+vatar,+Virar,+Maharashtra+401301/@19.4416588,72.6934225,12z/data=!4m8!4m7!1m0!1m5!1m1!1s0x3be7abfee8edc8db:0xb7c27e6e3c720ecc!2m2!1d72.7758242!2d19.4416774?entry=ttu" target="_blank">Vatar,Virar West    &raquo;</a></sapn>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                <div class="card text-center shadow shadow-lg turf-location" style="background-image: url('img/turf.jpeg'); background-size: cover; border-radius: 20px 20px 20px 20px" id="sopara">
                                    <div class="card-body">
                                        <div style="height: 26vh;"></div>
                                    </div>
                                    <div class="card-footer p-2" style="border-radius: 20px 20px 0 0">
                                        <h3 class=""><span class="fa fa-futbol-o"></span>&nbsp;Sopara</h3>
                                        <sapn class="mt-3" style="font-size: small"><span class="fa fa-lg fa-map-marker"></span>&nbsp;&nbsp;<a href="https://www.google.com/maps/dir//Chakreshwar+talav,+opposite+coca+cola+distributor,+Nala+Sopara,+Maharashtra+401203/@19.4167956,72.7143704,12z/data=!4m8!4m7!1m0!1m5!1m1!1s0x3be7ab9f55c887d1:0xaefff9e98691547d!2m2!1d72.7967721!2d19.4168142?entry=ttu" target="_blank">Chakreshwar Talav,Nala Sopara    &raquo;</a></sapn>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                <div class="card text-center shadow shadow-lg" style="background-image: url('img/turf.jpeg'); background-size: cover; border-radius: 20px 20px 20px 20px" id="east">
                                    <div class="card-body">
                                        <div style="height: 26vh;"></div>
                                    </div>
                                    <div class="card-footer p-2" style="border-radius: 20px 20px 0 0">
                                        <h3 class=""><span class="fa fa-futbol-o"></span>&nbsp;East(Coming Soon)</h3>
                                        <%--<sapn class="mt-3" style="font-size: small"><span class="fa fa-lg fa-map-marker"></span>&nbsp;&nbsp;<a href="https://www.google.com/maps/dir//Chakreshwar+talav,+opposite+coca+cola+distributor,+Nala+Sopara,+Maharashtra+401203/@19.4167956,72.7143704,12z/data=!4m8!4m7!1m0!1m5!1m1!1s0x3be7ab9f55c887d1:0xaefff9e98691547d!2m2!1d72.7967721!2d19.4168142?entry=ttu" target="_blank">Chakreshwar Talav,Nala Sopara    &raquo;</a></sapn>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="type" style="display: none;">
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-0 col-xs-0"></div>
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <div class="row">
                            <asp:HiddenField ID="hidden_type" runat="server"></asp:HiddenField>
                            <div class="container-fluid">
                                <div class="row m-auto text-center">
                                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                        <asp:HiddenField ID="hidden_full" runat="server" Value="250"></asp:HiddenField>
                                        <div class="princing-item" id="full">
                                            <div class="pricing-divider">
                                                <h4 class="my-0 display-2 text-white font-weight-normal mb-3"><span class="h3 text-white">₹</span><asp:Label ID="lbl_full_court" runat="server" Text="250"></asp:Label>
                                                    <span class="h5 text-white" style="margin-left: -4%;">/Hour</span></h4>
                                                <svg class='pricing-divider-img' enable-background='new 0 0 300 100' height='100px' id='Layer_1' preserveAspectRatio='none' version='1.1' viewBox='0 0 300 100' width='300px' x='0px' xml:space='preserve' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns='http://www.w3.org/2000/svg' y='0px'>
                                                    <path class='deco-layer deco-layer--1' d='M30.913,43.944c0,0,42.911-34.464,87.51-14.191c77.31,35.14,113.304-1.952,146.638-4.729c48.654-4.056,69.94,16.218,69.94,16.218v54.396H30.913V43.944z'
                                                        fill='#FFFFFF' opacity='0.6'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--2' d='M-35.667,44.628c0,0,42.91-34.463,87.51-14.191c77.31,35.141,113.304-1.952,146.639-4.729c48.653-4.055,69.939,16.218,69.939,16.218v54.396H-35.667V44.628z'
                                                        fill='#FFFFFF' opacity='0.6'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--3' d='M43.415,98.342c0,0,48.283-68.927,109.133-68.927c65.886,0,97.983,67.914,97.983,67.914v3.716H42.401L43.415,98.342z'
                                                        fill='#FFFFFF' opacity='0.7'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--4' d='M-34.667,62.998c0,0,56-45.667,120.316-27.839C167.484,57.842,197,41.332,232.286,30.428c53.07-16.399,104.047,36.903,104.047,36.903l1.333,36.667l-372-2.954L-34.667,62.998z'
                                                        fill='#FFFFFF'>
                                                    </path>
                                                </svg>
                                            </div>
                                            <div class="card-body mt-0 shadow-lg">
                                                <h2 class="text-primary">Full Court</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                        <asp:HiddenField ID="hidden_open" runat="server" Value="150"></asp:HiddenField>
                                        <div class="princing-item" id="open">
                                            <div class="pricing-divider ">
                                                <h4 class="my-0 display-2 text-white font-weight-normal mb-3"><span class="h3 text-white">₹</span><asp:Label ID="lbl_open_court" runat="server" Text="150"></asp:Label><span class="h5 text-white">/Hour</span></h4>
                                                <svg class='pricing-divider-img' enable-background='new 0 0 300 100' height='100px' id='Layer_3' preserveAspectRatio='none' version='1.1' viewBox='0 0 300 100' width='300px' x='0px' xml:space='preserve' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns='http://www.w3.org/2000/svg' y='0px'>
                                                    <path class='deco-layer deco-layer--1' d='M30.913,43.944c0,0,42.911-34.464,87.51-14.191c77.31,35.14,113.304-1.952,146.638-4.729c48.654-4.056,69.94,16.218,69.94,16.218v54.396H30.913V43.944z'
                                                        fill='#FFFFFF' opacity='0.6'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--2' d='M-35.667,44.628c0,0,42.91-34.463,87.51-14.191c77.31,35.141,113.304-1.952,146.639-4.729c48.653-4.055,69.939,16.218,69.939,16.218v54.396H-35.667V44.628z'
                                                        fill='#FFFFFF' opacity='0.6'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--3' d='M43.415,98.342c0,0,48.283-68.927,109.133-68.927c65.886,0,97.983,67.914,97.983,67.914v3.716H42.401L43.415,98.342z'
                                                        fill='#FFFFFF' opacity='0.7'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--4' d='M-34.667,62.998c0,0,56-45.667,120.316-27.839C167.484,57.842,197,41.332,232.286,30.428c53.07-16.399,104.047,36.903,104.047,36.903l1.333,36.667l-372-2.954L-34.667,62.998z' fill='#FFFFFF'>
                                                    </path>
                                                </svg>
                                            </div>
                                            <div class="card-body bg-white mt-0 shadow ">
                                                <h2 class="text-primary">Open Court</h2>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2">
                                        <asp:HiddenField ID="hidden_box" runat="server" Value="100"></asp:HiddenField>
                                        <div class="princing-item" id="box">
                                            <div class="pricing-divider ">
                                                <h4 class="my-0 display-2 text-white font-weight-normal mb-3"><span class="h3 text-white" style="margin-right: -4%;">₹</span>
                                                    <asp:Label ID="lbl_box_court" runat="server" Text="100"></asp:Label>
                                                    <span class="h5 text-white" style="margin-left: -4%;">/Hour</span></h4>
                                                <svg class='pricing-divider-img' enable-background='new 0 0 300 100' height='100px' id='Layer_2' preserveAspectRatio='none' version='1.1' viewBox='0 0 300 100' width='300px' x='0px' xml:space='preserve' xmlns:xlink='http://www.w3.org/1999/xlink' xmlns='http://www.w3.org/2000/svg' y='0px'>
                                                    <path class='deco-layer deco-layer--1' d='M30.913,43.944c0,0,42.911-34.464,87.51-14.191c77.31,35.14,113.304-1.952,146.638-4.729c48.654-4.056,69.94,16.218,69.94,16.218v54.396H30.913V43.944z' fill='#FFFFFF' opacity='0.6'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--2' d='M-35.667,44.628c0,0,42.91-34.463,87.51-14.191c77.31,35.141,113.304-1.952,146.639-4.729c48.653-4.055,69.939,16.218,69.939,16.218v54.396H-35.667V44.628z'
                                                        fill='#FFFFFF' opacity='0.6'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--3' d='M43.415,98.342c0,0,48.283-68.927,109.133-68.927c65.886,0,97.983,67.914,97.983,67.914v3.716H42.401L43.415,98.342z'
                                                        fill='#FFFFFF' opacity='0.7'>
                                                    </path>
                                                    <path class='deco-layer deco-layer--4' d='M-34.667,62.998c0,0,56-45.667,120.316-27.839C167.484,57.842,197,41.332,232.286,30.428c53.07-16.399,104.047,36.903,104.047,36.903l1.333,36.667l-372-2.954L-34.667,62.998z' fill='#FFFFFF'>
                                                    </path>
                                                </svg>
                                            </div>
                                            <div class="card-body bg-white mt-0 shadow">
                                                <h2 class="text-primary">Box Court</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="calender" class="pt-2" style="display: none">
                <div class="row">
                    <div class="col-lg-2 col-md-2 col-sm-0 col-xs-0"></div>
                    <div class="col-lg-8 col-md-8 col-sm-12 col-xs-12">
                        <div class="row">
                            <asp:HiddenField ID="hidden_date" runat="server"></asp:HiddenField>
                            <div class="row" id="calendarRow">
                                <!-- Calendar months will be dynamically generated here -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="time" style="display: none">
                <asp:HiddenField ID="hidden_total_time" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="hidden_from_time" runat="server"></asp:HiddenField>
                <asp:HiddenField ID="hidden_to_time" runat="server"></asp:HiddenField>
                <div class="card shadow">
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 mt-3">
                            <asp:DropDownList ID="ddl_hour" runat="server" CssClass="form-select ddl_hour">
                                <asp:ListItem Value="" Text="Select Hour"></asp:ListItem>
                                <asp:ListItem Value="1" Text="1 Hour"></asp:ListItem>
                                <asp:ListItem Value="2" Text="2 Hours"></asp:ListItem>
                                <asp:ListItem Value="3" Text="3 Hours"></asp:ListItem>
                                <asp:ListItem Value="4" Text="4 Hours"></asp:ListItem>
                                <asp:ListItem Value="5" Text="5 Hours"></asp:ListItem>
                                <asp:ListItem Value="6" Text="6 Hours"></asp:ListItem>
                                <asp:ListItem Value="7" Text="7 Hours"></asp:ListItem>
                                <asp:ListItem Value="8" Text="8 Hours"></asp:ListItem>
                                <asp:ListItem Value="9" Text="9 Hours"></asp:ListItem>
                                <asp:ListItem Value="10" Text="10 Hours"></asp:ListItem>
                                <asp:ListItem Value="11" Text="11 Hours"></asp:ListItem>
                                <asp:ListItem Value="12" Text="12 Hours"></asp:ListItem>
                                <asp:ListItem Value="13" Text="13 Hours"></asp:ListItem>
                                <asp:ListItem Value="14" Text="14 Hours"></asp:ListItem>
                                <asp:ListItem Value="15" Text="15 Hours"></asp:ListItem>
                                <asp:ListItem Value="16" Text="16 Hours"></asp:ListItem>
                                <asp:ListItem Value="17" Text="17 Hours"></asp:ListItem>
                                <asp:ListItem Value="18" Text="18 Hours"></asp:ListItem>
                                <asp:ListItem Value="19" Text="19 Hours"></asp:ListItem>
                                <asp:ListItem Value="20" Text="20 Hours"></asp:ListItem>
                                <asp:ListItem Value="21" Text="21 Hours"></asp:ListItem>
                                <asp:ListItem Value="22" Text="22 Hours"></asp:ListItem>
                                <asp:ListItem Value="23" Text="23 Hours"></asp:ListItem>
                                <asp:ListItem Value="24" Text="24 Hours"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 mt-3">
                            <asp:DropDownList ID="ddl_min" runat="server" CssClass="form-select ddl_min" Style="display: none;">
                                <asp:ListItem Value="" Text="Select Minutes"></asp:ListItem>
                                <asp:ListItem Value="00" Text="00 Min"></asp:ListItem>
                                <asp:ListItem Value="30" Text="30 Min"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 mt-3">
                            <asp:TextBox ID="txt_timetotal" runat="server" CssClass="form-control txt_timetotal" ReadOnly="true" Style="display: none;"></asp:TextBox>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-lg-4 col-md-4 col-sm-0 col-xs-0"></div>
                        <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12">
                            <div id="start_time" class="p-1 text-center" style="display: none">
                                <h6>Select Start Time</h6>
                            </div>
                            <div id="timetable" style="overflow: auto; max-height: 300px">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="user" style="display: none">
                <div class="row">
                    <div class="card shadow">
                        <asp:HiddenField ID="hidden_price" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="hidden_percent" runat="server" Value="10"></asp:HiddenField>
                        <div class="row">
                            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 mt-2 mt-lg-0">
                                <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                    <span class="input-group-text text-primary"><i class="fa fa-map-marker"></i></span>
                                    <asp:TextBox ID="txt_location" CssClass="form-control txt_location" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 mt-2 mt-lg-0">
                                <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                    <span class="input-group-text text-primary"><i class="fa fa-calendar"></i></span>
                                    <asp:TextBox ID="txt_date" CssClass="form-control txt_date" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 mt-2 mt-lg-0">
                                <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                    <span class="input-group-text text-primary"><i class="fa fa-clock-o"></i></span>
                                    <asp:TextBox ID="txt_from_time" CssClass="form-control txt_from_time" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 col-xs-12 mt-2 mt-lg-0">
                                <div class="input-group border-bottom border-2 border-primary rounded shadow">
                                    <span class="input-group-text text-primary"><i class="fa fa-clock-o"></i></span>
                                    <asp:TextBox ID="txt_to_time" CssClass="form-control txt_to_time" runat="server" ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="">
                            <div class="row p-2">
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 mt-2 mt-lg-0">
                                    <asp:TextBox ID="lbl_turf_type" CssClass="form-control lbl_turf_type" runat="server" Text="Turf Type : " ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 mt-2 mt-lg-0">
                                    <asp:TextBox ID="lbl_price" CssClass="form-control lbl_price" runat="server" Text="Turf Price : " ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 mt-2 mt-lg-0">
                                    <asp:TextBox ID="lbl_time" CssClass="form-control lbl_time" runat="server" Text="Turf Time : " ReadOnly="true"></asp:TextBox>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3 mt-2 mt-lg-0">
                                    <asp:TextBox ID="lbl_totalPrice" CssClass="form-control lbl_totalPrice" runat="server" Text="Total Price : " ReadOnly="true"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2 mt-lg-0">
                                <div class="form-floating">
                                    <asp:TextBox ID="txt_name" class="form-control" onkeypress="return allowOnlyLetters(event,this);" runat="server" MaxLength="100"></asp:TextBox>
                                    <label for="floatingInput">Enter Name</label>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2 mt-lg-0">
                                <div class="form-floating">
                                    <asp:TextBox ID="txt_phone" class="form-control" onkeypress="return allowonlynumbers(event,this);" runat="server" MaxLength="10"></asp:TextBox>
                                    <label for="floatingInput">Enter Phone No.</label>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4 col-sm-12 col-xs-12 mt-2 mt-lg-0">
                                <div class="form-floating">
                                    <asp:TextBox ID="txt_email" class="form-control" runat="server"></asp:TextBox>
                                    <label for="floatingInput">Enter Email</label>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-5 col-md-5 col-sm-0 col-xs-0"></div>
                            <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12">
                                <asp:UpdatePanel runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="btn_confrim" CssClass="btn btn-primary form-control" runat="server" Text="Confirm" OnClick="btn_confrim_Click" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <br />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Modal  --%>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="modal fade" id="Modal_qr" tabindex="-1" aria-labelledby="Modal_qrLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div class="modal-dialog" style="height: 94vh;">
                            <div class="modal-content transparent-modal">
                                <div class="modal-body align-content-center flex-container transparent-modal">
                                    <div class="card shadow">
                                        <div class="card-header  border-bottom border-primary border-3">
                                            <div class="row" style="padding-bottom: 14px;">
                                                <div class="col-md-12 col-sm-12">
                                                    <h6 class="p-2">Please confirm Booking By Advance Payment</h6>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body">
                                            <div class="row text-center">
                                                <div class="row">
                                                    <div class="col-1"></div>
                                                    <div class="col-10">
                                                        <asp:Label runat="server" ID="lbl_adv" CssClass="form-control text-center m-2 border-bottom border-2 border-primary" Style="font-size: x-large"></asp:Label>
                                                    </div>
                                                </div>
                                                <asp:Image ID="img_qr" ImageUrl="~/img/qrcode_chat.openai.com.png" runat="server" />
                                                <div class="row">
                                                    <div class="col-1"></div>
                                                    <div class="col-10">
                                                        <asp:Button runat="server" ID="btn_close" CssClass="btn btn-primary form-control m-2" Text="Ok" OnClientClick="location.reload();" Visible="false"></asp:Button>
                                                    </div>
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <%-- Modal  --%>
    <script src="JS/booking.js"></script>
</asp:Content>

