using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

public partial class booking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btn_confrim_Click(object sender, EventArgs e)
    {

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