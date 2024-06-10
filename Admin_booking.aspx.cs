using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_booking : System.Web.UI.Page
{
    Class1 cls = new Class1();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["username"]) != "")
        {
            if (!IsPostBack)
            {
                dataonpageload();
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }
        if (grd_data.Rows.Count > 0)
        {
            grd_data.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }

    public void dataonpageload()
    {
        txt_date.Text = DateTime.Today.ToString("yyyy-MM-dd");
        load_grd();
    }

    public void load_grd()
    {
        string qry = "select *,convert(varchar,Turf_date,103) Date From turf_details where Turf_date=convert(varchar,'" + txt_date.Text.Trim() + "',103) and del_flag=0";
        DataTable dt = cls.fillDataTable(qry);
        if (dt.Rows.Count > 0)
        {
            grd_data.DataSource = dt;
            grd_data.DataBind();
            grd_data.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        else
        {
            grd_data.DataSource = null;
            grd_data.DataBind();
            //ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('No Data Found', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
        }
    }

    protected void btn_data_Click(object sender, EventArgs e)
    {
        load_grd();
    }

    protected void txt_date_TextChanged(object sender, EventArgs e)
    {
        load_grd();
    }

    protected void btn_save_Click(object sender, EventArgs e)
    {
        string location = ddl_location.SelectedValue.Trim();
        string type = ddl_type.SelectedValue.Trim();
        string date = txt_bk_date.Text.Trim();
        string from_time = txt_from_time.Text.Trim();
        string to_time = txt_to_time.Text.Trim();
        string Advance = txt_adv_amt.Text.Trim();
        string amount = txt_amt.Text.Trim();
        string status = ddl_status.SelectedValue.Trim();
        if (location == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Select Location', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (type == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Select Type', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (date == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter Date', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (from_time == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter From Time', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (to_time == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter From Time', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (Advance == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter Advane Amount', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (amount == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Enter Amount', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else if (status == "")
        {
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Select Confrim Status', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            return;
        }
        else
        {
            DataTable dt = cls.fillDataTable("select [dbo].[GenerateIncrementedValue]()");
            string Booking_id = dt.Rows[0][0].ToString().Trim();
            string qyr = "insert into Turf_details (Booking_id,Turf_location,Turf_type,Turf_date,Form_time,To_time,Total_time,Total_amount,Adv_amount) values ('" + Booking_id + "','" + hidden_location.Value.Trim() + "','" + hidden_type.Value.Trim() + "','" + hidden_date.Value.Trim() + "','" + hidden_from_time.Value.Trim() + "','" + hidden_to_time.Value.Trim() + "','" + hidden_total_time.Value.Trim() + "'," + hidden_price.Value.Trim() + "," + adv_amt + ")";
            if (cls.DMLqueries(qyr))
            {
            }
        }
    }
}