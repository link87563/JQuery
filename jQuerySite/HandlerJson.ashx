<%@ WebHandler Language="C#" Class="HandlerJson" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using Newtonsoft.Json;
using System.Collections.Generic;

public class HandlerJson : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        Int32 id = 1;
        if (context.Request.QueryString["categoryId"] != null)
        {
            id = Convert.ToInt32(context.Request.QueryString["categoryId"]);
        }
         //步驟一給予適當的名稱空間
        //步驟二建立連線物件(需要連線字串)
        string strConn = ConfigurationManager.ConnectionStrings["northwindConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(strConn))
        {
            //步驟三讀取資料庫的資料
            string strCmd = "select ProductID,ProductName,UnitPrice,UnitsInStock from Products where CategoryId=@CategoryId";
            using (SqlCommand cmd = new SqlCommand(strCmd, conn)){
                cmd.Parameters.AddWithValue("@CategoryId", id);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                
                List<Product> products = new List<Product>();
                while (dr.Read())
                {
                    Product product = new Product();
                    product.ProductID = Convert.ToInt32(dr["ProductID"]);
                    product.ProductName = dr["ProductName"].ToString();
                    product.UnitPrice = Convert.ToDecimal(dr["UnitPrice"]);
                    product.UnitsInStock = Convert.ToInt32(dr["UnitsInStock"]);
                    products.Add(product);
                }
                conn.Close();
                context.Response.ContentType = "application/json";
                context.Response.Write(JsonConvert.SerializeObject(products)); 
            }
        
        }

       
        
        
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}