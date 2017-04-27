<%@ WebHandler Language="C#" Class="ProductsJSON" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Configuration;

public class ProductsJSON : IHttpHandler {

    public void ProcessRequest (HttpContext context) {

        Int32 categoryID = 1;
        if (context.Request.QueryString["categoryID"] != null)
        {
            categoryID = Convert.ToInt32(context.Request.QueryString["categoryID"]);
        }

        String strConn = ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(strConn))
        {
            string strCmd = "select ProductID,ProductName,unitPrice,unitsInStock from Products where CategoryID=@CategoryID";
            using (SqlDataAdapter da = new SqlDataAdapter(strCmd, conn))
            {
                da.SelectCommand.Parameters.AddWithValue("@CategoryID", categoryID);
                DataSet ds = new DataSet();
                da.Fill(ds, "product");
                context.Response.ContentType = "application/json";
                context.Response.Write(JsonConvert.SerializeObject(ds.Tables["product"]));

            }


        }


    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}