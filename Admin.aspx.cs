using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{
    Class1 cls = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["username"]) != "")
        {
            if (!IsPostBack)
            {
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        string full = txt_full.Text.Trim();
        string open = txt_open.Text.Trim();
        string box = txt_box.Text.Trim();
        string adv = txt_adv.Text.Trim();
        string turf_location = ddl_location.SelectedValue.Trim();

        if (turf_location == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Select Turf Location', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else if (full == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter Full Court Price', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else if (open == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter Open Court Price', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else if (box == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter Box Court Price', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else if (adv == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter Advance Percentage', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else if (Convert.ToInt32(adv) > 100)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Advance Is In Percentage Cannot Be More Than 100', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else if (hidden_img.Value == null || hidden_img.Value == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Upload QR Code', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else
        {
            string quesdata = "update admin_tbl set Full_price=@Full_price,Open_price=@Open_price,Box_price=@Box_price,Adv_price=@Adv_price,Qr_code=@Qr_code where Turf_location=@Turf_location";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connect"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(quesdata, con);

            cmd.Parameters.AddWithValue("@Full_price", full);
            cmd.Parameters.AddWithValue("@Open_price", open);
            cmd.Parameters.AddWithValue("@Box_price", box);
            cmd.Parameters.AddWithValue("@Adv_price", adv);
            cmd.Parameters.AddWithValue("@Turf_location", turf_location);
            byte[] imageData = Convert.FromBase64String(hidden_img.Value);
            cmd.Parameters.Add("@Qr_code", SqlDbType.Image).Value = imageData;

            if (cmd.ExecuteNonQuery() > 0)
            {
                ddl_location_SelectedIndexChanged(sender, e);
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Admin Details Updated', { color: '#006600', background: '#ccffcc', blur: 0.2, delay: 0 });", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            }
        }
    }

    protected void btn_imgdelete_Click(object sender, EventArgs e)
    {
        Image1.ImageUrl = null;
        Image1.Style["display"] = "none";
        btn_imgdelete.Style["display"] = "none";
        hidden_img.Value = null;
    }

    protected void ddl_location_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddl_location.SelectedIndex == 0)
        {
            Image1.ImageUrl = null;
            Image1.Style["display"] = "none";
            btn_imgdelete.Style["display"] = "none";
            hidden_img.Value = null;
            txt_full.Text = "";
            txt_open.Text = "";
            txt_box.Text = "";
            txt_adv.Text = "";
        }
        else
        {
            DataTable dt = cls.fillDataTable("select * from admin_tbl where Turf_location='" + ddl_location.SelectedValue.Trim() + "'");
            if (dt.Rows.Count > 0)
            {
                txt_full.Text = dt.Rows[0]["Full_price"].ToString();
                txt_open.Text = dt.Rows[0]["Open_price"].ToString();
                txt_box.Text = dt.Rows[0]["Box_price"].ToString();
                txt_adv.Text = dt.Rows[0]["Adv_price"].ToString();
                if (dt.Rows[0]["Qr_code"].ToString() != "")
                {
                    byte[] imageBytes = (byte[])dt.Rows[0]["Qr_code"];
                    string base64Image = Convert.ToBase64String(imageBytes);
                    string imageUrl = "data:image/jpeg;base64," + base64Image;
                    Image1.Style["display"] = "";
                    Image1.ImageUrl = imageUrl;
                    hidden_img.Value = base64Image;
                }
                else
                {
                    Image1.ImageUrl = null;
                    Image1.Style["display"] = "none";
                    btn_imgdelete.Style["display"] = "none";
                    hidden_img.Value = null;
                }
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            }
        }
    }
}