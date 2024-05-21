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
        if (!IsPostBack)
        {
            if (Convert.ToString(Session["user"]) != "#" && Convert.ToString(Session["clg_code"]) != "#")
            {
                dataonpageload();
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }

    public void dataonpageload()
    {
        DataTable dt = cls.fillDataTable("select * from admin_tbl");
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

    protected void btn_edit_Click(object sender, EventArgs e)
    {
        if (btn_edit.Text == "Edit")
        {
            txt_full.Enabled = true;
            txt_open.Enabled = true;
            txt_box.Enabled = true;
            txt_adv.Enabled = true;
            btn_img.Enabled = true;
            btn_save.Enabled = true;
            btn_edit.Text = "Refresh";
        }
        else if (btn_edit.Text == "Refresh")
        {
            btn_edit.Text = "Edit";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ReloadPage", "location.reload();", true);
        }
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        string full = txt_full.Text.Trim();
        string open = txt_open.Text.Trim();
        string box = txt_box.Text.Trim();
        string adv = txt_adv.Text.Trim();

        if (full == "")
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
        else if(Convert.ToInt32(adv) > 100)
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Advance Is In Percentage Cannot Be More Than 100', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else if (hidden_img.Value == null || hidden_img.Value == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Upload QR Code', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
        else
        {
            string quesdata = "update admin_tbl set Full_price=@Full_price,Open_price=@Open_price,Box_price=@Box_price,Adv_price=@Adv_price,Qr_code=@Qr_code";

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connect"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand(quesdata, con);

            cmd.Parameters.AddWithValue("@Full_price", full);
            cmd.Parameters.AddWithValue("@Open_price", open);
            cmd.Parameters.AddWithValue("@Box_price", box);
            cmd.Parameters.AddWithValue("@Adv_price", adv);
            byte[] imageData = Convert.FromBase64String(hidden_img.Value);
            cmd.Parameters.Add("@Qr_code", SqlDbType.Image).Value = imageData;

            if (cmd.ExecuteNonQuery() > 0)
            {
                dataonpageload();
                txt_full.Enabled = false;
                txt_open.Enabled = false;
                txt_box.Enabled = false;
                txt_adv.Enabled = false;
                btn_img.Enabled = false;
                btn_save.Enabled = false;
                btn_edit.Text = "Edit";

                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('College Details Saved Successfully', { color: '#006600', background: '#ccffcc', blur: 0.2, delay: 0 });", true);
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
}