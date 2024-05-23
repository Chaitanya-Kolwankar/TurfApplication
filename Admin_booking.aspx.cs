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
        grd_data.DataSource = dt;
        grd_data.DataBind();
        if (grd_data.Rows.Count > 0)
        {
            grd_data.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
    }

    protected void btn_data_Click(object sender, EventArgs e)
    {
        load_grd();
    }
}