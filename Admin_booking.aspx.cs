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
            ScriptManager.RegisterClientScriptBlock(this, typeof(Page), "anything", "$.notify('No Data Found', { color: '#802019', background: '#ffb3b3', blur: 0.2, delay: 0 });", true);
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
}