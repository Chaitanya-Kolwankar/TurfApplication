using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text;
using System.Net;
/// <summary>
/// Summary description for Class1
/// </summary>
public class Class1
{
    SqlCommand cmd = new SqlCommand();
    SqlDataAdapter da;
    DataSet ds = new DataSet();
    public SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connect"].ConnectionString);

    public Class1()
    {

    }

    public DataTable fillDataTable(string query)
    {
        cmd = new SqlCommand();
        cmd.CommandText = query;
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        cmd.CommandTimeout = 0;
        Conn();
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();

        da.Fill(ds);

        con.Close();
        return ds.Tables[0];
    }

    public bool DMLqueries(string query)
    {
        try
        {
            cmd = new SqlCommand();
            cmd.CommandText = query;
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                con.Open();
            }
            else
            {
                con.Open();
            }
            if (cmd.ExecuteNonQuery() > 0)
            {
                con.Close();
                return true;

            }
            else
            {
                con.Close();
                return false;

            }
        }
        catch (Exception)
        {
            return false;
        }

    }

    public object SetdropdownForMember(DropDownList ddl, string TABLE_NAME, string DATA_COLUMN, string VALUE_COLUMN, string CONDITION, string SELECT)
    {
        string Query;
        try
        {

            if (VALUE_COLUMN.Length > 0)
            {
                VALUE_COLUMN = "," + VALUE_COLUMN;
            }
            if (string.IsNullOrEmpty(CONDITION))
            {
                Query = "SELECT " + DATA_COLUMN + VALUE_COLUMN + " FROM " + TABLE_NAME;
            }
            else
            {
                Query = "SELECT " + DATA_COLUMN + VALUE_COLUMN + " FROM " + TABLE_NAME + " where " + CONDITION;
            }

            ds = fillDataset(Query);

            DataRow drr = ds.Tables[0].NewRow();
            drr[0] = SELECT;
            drr[1] = "";
            ds.Tables[0].Rows.InsertAt(drr, 0);
            ddl.DataSource = ds.Tables[0];
            ddl.DataTextField = ds.Tables[0].Columns[0].ColumnName;
            ddl.DataValueField = ds.Tables[0].Columns[1].ColumnName;
            ddl.DataSource = null;
            ddl.DataBind();
            ddl.DataSource = ds.Tables[0];
            ddl.DataBind();
        }
        catch (Exception)
        {
            return null;
        }
        return 0;
    }

    public void err_log(string error_type, string error_page, string error_on_function)
    {
        string qry = "insert into error_log (error_type,error_page,error_on_function,error_on_date) values('" + error_type + "','" + error_page + "','" + error_on_function + "',GETDATE())";
        DMLqueries(qry);
    }

    public void Conn()
    {
        if (con.State == ConnectionState.Open)
        {
            con.Close();
            con.Open();
        }
        else
        {
            con.Open();
        }

    }

    public DataSet fillDataset(string query)
    {
        cmd = new SqlCommand();
        cmd.CommandText = query;
        cmd.CommandType = CommandType.Text;
        cmd.Connection = con;
        Conn();
        da = new SqlDataAdapter(cmd);
        ds = new DataSet();

        da.Fill(ds);

        con.Close();
        return ds;
    }

}