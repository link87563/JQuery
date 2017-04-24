<%@ WebHandler Language="C#" Class="checkname" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

public class checkname : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        String name = context.Request.Params["name"];

        string conns = ConfigurationManager.ConnectionStrings["northwindConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(conns))
        {
            using (SqlCommand cmd = new SqlCommand("select count(*) from Employees where FirstName=@FirstName", conn))
            {
                    
                cmd.Parameters.AddWithValue("@FirstName", name);
                conn.Open();
                 String strMsg = "帳號不存在";

			
			if (Convert.ToInt32(cmd.ExecuteScalar()) >= 1) {
				strMsg = "帳號已存在";
			}

                context.Response.ContentType = "text/plain";
                context.Response.Write(strMsg);
                conn.Close();
            } 
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}