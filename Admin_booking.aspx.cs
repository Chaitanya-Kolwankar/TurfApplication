using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
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
        string name = txt_name.Text.Trim();
        string phone = txt_phone.Text.Trim();
        string mail = txt_mail.Text.Trim();
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
            to_time = to_time == "24:00" ? "23:59" : to_time;
            DateTime start, end;
            DateTime.TryParse(from_time, out start);
            DateTime.TryParse(to_time, out end);
            TimeSpan totalTime = end.TimeOfDay.Subtract(start.TimeOfDay);
            totalTime = totalTime.Minutes == 59 ? totalTime.Add(new TimeSpan(0, 1, 0)) : totalTime;
            int totalHours = totalTime.Hours;
            int totalMinutes = totalTime.Minutes;

            if (totalMinutes % 30 != 0)
            {
                totalMinutes = (totalMinutes / 30) * 30 + 30;
            }
            string time = (totalHours < 10 ? "0" + totalHours.ToString() : totalHours.ToString()) + ":" + (totalMinutes < 10 ? "0" + totalMinutes.ToString() : totalMinutes.ToString());
            DataTable dt = cls.fillDataTable("select [dbo].[GenerateIncrementedValue]()");
            string Booking_id = dt.Rows[0][0].ToString().Trim();
            string qyr = "";
            if (btn_save.Text.Contains("Save"))
            {
                qyr = "insert into Turf_details (Booking_id,Name,Phone,Email,Turf_location,Turf_type,Turf_date,Form_time,To_time,Total_time,Total_amount,Adv_amount,confirm_flag,curr_dt) values ('" + Booking_id + "','" + name + "'," + phone + ",'" + mail + "','" + location + "','" + type + "','" + date + "','" + from_time + "','" + to_time + "','" + time + "'," + amount + "," + Advance + "," + status + ",GETDATE());";
            }
            else
            {
                Booking_id = txt_Bk_id.Text.Trim();
                qyr = "update Turf_details set Name='" + name + "',Phone=" + phone + ",Email='" + mail + "',Turf_location='" + location + "',Turf_type='" + type + "',Turf_date='" + date + "',Form_time='" + from_time + "',To_time='" + to_time + "',Total_time='" + time + "',Total_amount=" + amount + ",Adv_amount=" + Advance + ",confirm_flag=" + status + ",mod_dt=GETDATE() where Booking_id='" + Booking_id + "';";
            }

            if (cls.DMLqueries(qyr))
            {

                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Booking Details Saved Successfully', { color: '#006600', background: '#ccffcc', blur: 0.2, delay: 0 });$('#Modal_add').modal('hide');", true);
                load_grd();
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('Something Went Wrong', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
            }
        }
    }

    protected void btn_edit_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        string date = ((Label)gvRow.FindControl("grdlbl_Date")).Text.Trim();
        DateTime dateValue;
        DateTime.TryParseExact(date, "dd/MM/yyyy", CultureInfo.InvariantCulture, DateTimeStyles.None, out dateValue);
        txt_Bk_id.Text = ((Label)gvRow.FindControl("grdlbl_id")).Text.Trim();
        ddl_location.SelectedValue = ((Label)gvRow.FindControl("grdlbl_Location")).Text.Trim();
        ddl_type.SelectedValue = ((Label)gvRow.FindControl("grdlbl_Type")).Text.Trim();
        txt_bk_date.Text = dateValue.ToString("yyyy-MM-dd");
        txt_from_time.Text = ((Label)gvRow.FindControl("grdlbl_Form_time")).Text.Trim();
        txt_to_time.Text = ((Label)gvRow.FindControl("grdlbl_To_time")).Text.Trim();
        txt_adv_amt.Text = ((Label)gvRow.FindControl("grdlbl_Adv_amount")).Text.Trim();
        txt_amt.Text = ((Label)gvRow.FindControl("grdlbl_Total_amount")).Text.Trim();
        ddl_status.SelectedValue = Convert.ToBoolean(((Label)gvRow.FindControl("grdlbl_status")).Text.Trim()) == true ? "1" : "0";
        txt_name.Text = ((Label)gvRow.FindControl("grdlbl_name")).Text.Trim();
        txt_phone.Text = ((Label)gvRow.FindControl("grdlbl_Phone")).Text.Trim();
        txt_mail.Text = ((Label)gvRow.FindControl("grdlbl_Email")).Text.Trim();
        btn_save.Text = "Update Booking";
        ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$('#Modal_add').modal('show');", true);
    }
}