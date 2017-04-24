<%@ WebHandler Language="C#" Class="ProductsJSON" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using Newtonsoft.Json;
using System.Configuration;

public class ProductsJSON : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
         String strConn = ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString ;
       
        using (SqlConnection conn = new SqlConnection(strConn))
        {
            string strCmd = "select ProductID,ProductName,unitPrice,unitsInStock from Products";
            using (SqlDataAdapter da = new SqlDataAdapter(strCmd, conn))
            {
                DataSet ds = new DataSet();
                da.Fill(ds, "product");
                var dataProducts = new
                {
                    data = ds.Tables["product"]
                };
                context.Response.ContentType = "application/json";
                context.Response.Write(JsonConvert.SerializeObject(dataProducts));
             
            }
            
       
        }
        
      
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}