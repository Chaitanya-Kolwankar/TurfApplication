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

public partial class booking : System.Web.UI.Page
{
    Class1 cls = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {

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
            txt_name.Focus();
            return;
        }
        else if (Phone == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Kindly Enter Phone Number', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            txt_phone.Focus();
            return;
        }
        else if (Phone.Length < 10)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Invalid Phone Number', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            txt_phone.Focus();
            return;
        }
        else if (Email == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Kindly Enter Email', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            txt_email.Focus();
            return;
        }
        else if (!isValid)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Invalid Email', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            txt_email.Focus();
            return;
        }
        else
        {
            DataTable dt = cls.fillDataTable("select [dbo].[GenerateIncrementedValue]()");
            string Booking_id = dt.Rows[0][0].ToString().Trim();
            string qyr = "insert into Turf_details (Booking_id,Name,Phone,Email,Turf_location,Turf_type,Turf_date,Form_time,To_time,Total_time,Total_amount,Adv_amount) values ('" + Booking_id + "','" + name + "'," + Phone + ",'" + Email + "','" + hidden_location.Value.Trim() + "','" + hidden_type.Value.Trim() + "','" + hidden_date.Value.Trim() + "','" + hidden_from_time.Value.Trim() + "','" + hidden_to_time.Value.Trim() + "','" + hidden_total_time.Value.Trim() + "'," + 100 + "," + 100 + ")";

            cls.DMLqueries(qyr);

            ScriptManager.RegisterStartupScript(this, this.GetType(), "ReloadPage", "$('#Modal_qr').modal('show');", true);
            //string fromMail = "kolwankarchaitanya@gmail.com";
            //string fromPassword = "msrnfhxqkixszgmx";

            //MailMessage message = new MailMessage();
            //message.From = new MailAddress(fromMail);
            //message.Subject = "Test Subject";
            //message.To.Add(new MailAddress("kolwankarchaitanya@gmail.com"));
            //message.To.Add(new MailAddress(txt_email.Text.Trim()));
            //message.Body = "<html><body> Test Body </body></html>";
            //message.IsBodyHtml = true;

            //var smtpClient = new SmtpClient("smtp.gmail.com")
            //{
            //    Port = 587,
            //    Credentials = new NetworkCredential(fromMail, fromPassword),
            //    EnableSsl = true,
            //};

            //smtpClient.Send(message);
        }
    }
}