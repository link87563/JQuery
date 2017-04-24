<%@ WebHandler Language="C#" Class="CreateProductHandler" %>

using System;
using System.Web;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.IO;
using System.Configuration;


public class CreateProductHandler : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {

        
        //接收傳過來的FormData資料
      
        Int32 categoryID = Convert.ToInt32(context.Request.Form["CategoryID"]);
        String productName = context.Request.Form["ProductName"];
        String unitPrice = context.Request.Form["UnitPrice"];
        String unitsInStock = context.Request.Form["UnitsInStock"];
        

        String strMessage = "";
           
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString))
        {
            //步驟三新增資料到資料庫
            String strCmd = "Insert into Products(ProductName,UnitPrice,UnitsInStock,CategoryID)values(@ProductName,@UnitPrice,@UnitsInStock,@CategoryID)";
            using (SqlCommand cmd = new SqlCommand(strCmd, conn))
            {
                //宣告參數
                cmd.Parameters.AddWithValue("@CategoryID", categoryID);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@UnitPrice", unitPrice);
                cmd.Parameters.AddWithValue("@UnitsInStock", unitsInStock);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    strMessage = "新增成功";
                }
                catch (Exception ex)
                {
                    strMessage = ex.Message.ToString();
                }
                finally
                {
                    conn.Close();
                }

            }
        }

        context.Response.ContentType = "text/plain";
        context.Response.Write(strMessage);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}

