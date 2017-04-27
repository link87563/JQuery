<%@ WebHandler Language="C#" Class="DeleteProductHandler" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

public class DeleteProductHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string strMessage = "";
        string productID = "";
        if (context.Request.QueryString["productID"] != null)
        {
            productID = context.Request.QueryString["productID"];
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("delete Products where ProductID=@ProductID", conn))
                {
                    cmd.Parameters.AddWithValue("@ProductID", productID);
                    try
                    {
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        strMessage = "刪除成功";
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
        }
        else
        {
            strMessage = "產品刪除失敗";
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