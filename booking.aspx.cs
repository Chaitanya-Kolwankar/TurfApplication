using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.Data;
using System.Web.Services;
using Newtonsoft.Json.Linq;

public partial class booking : System.Web.UI.Page
{
    Class1 cls = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
    }

    public void dataonpageload()
    {
        hidden_location.Value = null;
        hidden_type.Value = null;
        hidden_full.Value = null;
        hidden_open.Value = null;
        hidden_box.Value = null;
        hidden_date.Value = null;
        hidden_from_time.Value = null;
        hidden_to_time.Value = null;
        hidden_total_time.Value = null;
        hidden_price.Value = null;
        hidden_percent.Value = null;
    }

    protected void btn_confrim_Click(object sender, EventArgs e)
    {
        string name = txt_name.Text.Trim().Replace("'", "''");
        string Phone = txt_phone.Text.Trim().Replace("'", "''");
        string Email = txt_email.Text.Trim().Replace("'", "''");
        bool isValid = Regex.IsMatch(Email, @"^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,4})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$");
        if (name == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Kindly Enter Name', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (Phone == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Kindly Enter Phone Number', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (Phone.Length < 10)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Invalid Phone Number', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (Email == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Kindly Enter Email', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (!isValid)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Invalid Email', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else
        {
            DataTable dt = cls.fillDataTable("select [dbo].[GenerateIncrementedValue]()");
            string Booking_id = dt.Rows[0][0].ToString().Trim();
            double adv_amt = (Convert.ToDouble(hidden_percent.Value.Trim()) / 100) * Convert.ToDouble(hidden_price.Value.Trim());
            string qyr = "insert into Turf_details (Booking_id,Name,Phone,Email,Turf_location,Turf_type,Turf_date,Form_time,To_time,Total_time,Total_amount,Adv_amount,curr_dt) values ('" + Booking_id + "','" + name + "'," + Phone + ",'" + Email + "','" + hidden_location.Value.Trim() + "','" + hidden_type.Value.Trim() + "','" + hidden_date.Value.Trim() + "','" + hidden_from_time.Value.Trim() + "','" + hidden_to_time.Value.Trim() + "','" + hidden_total_time.Value.Trim() + "'," + hidden_price.Value.Trim() + "," + adv_amt + ",GETDATE())";
            if (cls.DMLqueries(qyr))
            {
                DataTable dt_img = cls.fillDataTable("select * from admin_tbl where Turf_location='" + hidden_location.Value.Trim() + "'");
                if (dt_img.Rows[0]["Qr_code"].ToString() != "")
                {
                    byte[] imageBytes = (byte[])dt_img.Rows[0]["Qr_code"];
                    string base64Image = Convert.ToBase64String(imageBytes);
                    string imageUrl = "data:image/jpeg;base64," + base64Image;
                    img_qr.Style["display"] = "";
                    img_qr.ImageUrl = imageUrl;
                }
                else
                {
                    img_qr.ImageUrl = null;
                    img_qr.Style["display"] = "none";
                }
                lbl_model.InnerText = "Booking ID : " + Booking_id;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ReloadPage", "$('#Modal_qr').modal('show');", true);
                lbl_adv.Text = Convert.ToInt32(adv_amt).ToString() + "Rs";

                string fromMail = "abrahamscourt123@gmail.com";
                string fromPassword = "bmhpydveqcemxfsb";

                MailMessage message = new MailMessage();
                message.From = new MailAddress(fromMail);
                message.Subject = "Turf Booking At Abrahams Court";
                message.To.Add(new MailAddress("abrahamscourt123@gmail.com"));
                message.Body = "<html> <head> <style> table { font-family: arial, sans-serif; border-collapse: collapse; width: 100%; } td, th { border: 1px solid #dddddd; text-align: left; padding: 8px; } tr:nth-child(even) { background-color: #dddddd; } </style> </head> <link rel='stylesheet' href='https://www.w3schools.com/w3css/4/w3.css'> <body> <div class='container'> <h2>Booking Id : " + Booking_id + "</h2> <table><tr> <td>Name</td> <td>" + name + " </td> </tr><tr> <td>Phone</td> <td>" + Phone + " </td> </tr> <tr> <td>Location</td> <td>" + hidden_location.Value.Trim() + " </td> </tr> <tr> <td>Date</td> <td>" + hidden_date.Value.Trim() + " </td> </tr> <tr> <td>Type</td> <td>" + hidden_type.Value.Trim() + " </td> </tr> <tr> <td>From Time</td> <td>" + hidden_from_time.Value.Trim() + " </td> </tr> <tr> <td>To Time</td> <td>" + hidden_to_time.Value.Trim() + " </td> </tr> <tr> <td>Total Price</td> <td>" + hidden_price.Value.Trim() + " </td> </tr> <tr> <td>Advance Price</td> <td>" + Convert.ToInt32(adv_amt) + " </td> </tr> </table> <br> <div style='text-align:center'><h3> <a  href='https://abrahamscourt.runasp.net/booking_confirm.aspx?Booking_id=" + Booking_id + "'>Confirm</a> </h3></div> </div> </body> </html>";
                message.IsBodyHtml = true;
                var smtpClient = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new NetworkCredential(fromMail, fromPassword),
                    EnableSsl = true,
                };
                smtpClient.Send(message);
                btn_close.Visible = true;
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            }
        }
    }

    [WebMethod]
    public static string get_type_price(string turf_location, string date)
    {
        Class1 cls = new Class1();
        return cls.get_type_price(turf_location, date);
    }

    [WebMethod]
    public static string gte_blocked_days(string month, string turf_location)
    {
        Class1 cls = new Class1();
        return cls.gte_blocked_days(month, turf_location);
    }

    [WebMethod]
    public static string gte_blocked_time(string date, string turf_location)
    {
        Class1 cls = new Class1();
        return cls.gte_blocked_time(date, turf_location);
    }
}