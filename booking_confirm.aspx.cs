using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class booking_confirm : System.Web.UI.Page
{
    Class1 cls = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            dataonpageload();
        }
    }

    public void dataonpageload()
    {
        string Booking_id = Request.QueryString["Booking_id"];

        if (Booking_id == "" || Booking_id == null)
        {
            set_msg("danger", "Somthing Went Wrong !!!");
        }
        else
        {
            Booking_id = Booking_id.Trim();
            if (cls.DMLqueries("update Turf_details set confirm_flag=1 where Booking_id='" + Booking_id + "' and del_flag=0"))
            {
                DataTable dt = cls.fillDataTable("select * from Turf_details where Booking_id='" + Booking_id + "' and del_flag=0");
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Email"].ToString().Trim() != "")
                    {
                        string fromMail = "booking.abrahamscourt@gmail.com";
                        string fromPassword = "oebifvlldjerndfm";

                        MailMessage message = new MailMessage();
                        message.From = new MailAddress(fromMail);
                        message.Subject = "Confirmation Of Turf Booking At Abrahams Court";
                        message.To.Add(new MailAddress(dt.Rows[0]["Email"].ToString().Trim()));
                        message.Body = "<html> <head> <style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; } </style> </head> <link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'> <body> <div class='container'> <h2>Booking Confirmed For Booking Id : " + Booking_id + "</h2> <table><tr> <td>Name</td> <td>" + dt.Rows[0]["Name"].ToString().Trim() + " </td> </tr><tr> <td>Phone</td> <td>" + dt.Rows[0]["Phone"].ToString().Trim() + " </td> </tr> <tr> <td>Location</td> <td>" + dt.Rows[0]["Turf_location"].ToString().Trim() + " </td> </tr> <tr> <td>Date</td> <td>" + dt.Rows[0]["Turf_date"].ToString().Trim() + " </td> </tr> <tr> <td>Type</td> <td>" + dt.Rows[0]["Turf_type"].ToString().Trim() + " </td> </tr> <tr> <td>From Time</td> <td>" + dt.Rows[0]["Form_time"].ToString().Trim() + " </td> </tr> <tr> <td>To Time</td> <td>" + dt.Rows[0]["To_time"].ToString().Trim() + " </td> </tr> <tr> <td>Total Price</td> <td>" + dt.Rows[0]["Total_amount"].ToString().Trim() + " </td> </tr> <tr> <td>Advance Price</td> <td>" + dt.Rows[0]["Adv_amount"].ToString().Trim() + " </td> </tr> </table> </div> </body> </html>";
                        message.IsBodyHtml = true;
                        var smtpClient = new SmtpClient("smtp.gmail.com")
                        {
                            Port = 587,
                            Credentials = new NetworkCredential(fromMail, fromPassword),
                            EnableSsl = true,
                        };
                        smtpClient.Send(message);
                        set_msg("success", "Booking Confirmed for id : " + Booking_id + "| Confirmation Mail Sent ");
                    }
                    else
                    {
                        set_msg("success", "Booking Confirmed for id : " + Booking_id + "| Failed To Send Confirmation Mail ");
                    }
                }
                else
                {
                    set_msg("danger", "Somthing Went Wrong !!!");
                }
            }
            else
            {
                set_msg("danger", "Somthing Went Wrong !!!");
            }
        }
    }

    public void set_msg(string color, string msg)
    {
        div_bg.Attributes["class"] = "card bg-soft-" + color;
        lblmsg.Text = msg;
    }
}