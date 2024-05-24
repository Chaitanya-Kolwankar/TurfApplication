using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    Class1 cls = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_username.Text = "";
            txt_password.Text = "";
            Session["username"] = "";
        }
    }

    protected void btn_lgn_Click(object sender, EventArgs e)
    {
        try
        {
            string username = txt_username.Text.Trim();
            string password = txt_password.Text.Trim();

            if (username == "")
            {
                lbl_message.Text = "Enter Username";
                txt_username.Text = "";
            }
            else if (password == "")
            {
                lbl_message.Text = "Enter Password";
                txt_password.Text = "";
            }
            else
            {
                DataTable id_chk = cls.fillDataTable("select * from login where username = '" + username + "'; ");

                if (id_chk.Rows.Count > 0)
                {
                    if (id_chk.Rows[0]["password"].ToString() == password && id_chk.Rows[0]["username"].ToString() == username)
                    {
                        Session["username"] = username;
                        Response.Redirect("Admin_booking.aspx");
                    }
                    else
                    {
                        lbl_message.Text = "Invalid Credentials";
                        txt_username.Text = "";
                        txt_password.Text = "";
                    }
                }
                else
                {
                    lbl_message.Text = "Invalid Credentials";
                    txt_username.Text = "";
                    txt_password.Text = "";
                }
            }
        }
        catch (Exception ex)
        {
            cls.err_log(ex.Message, "Login.aspx", "btn_lgn_Click");
        }
    }
}