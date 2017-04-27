<%@ WebHandler Language="C#" Class="CategoryHandler" %>

using System;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Configuration;

public class CategoryHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
       // System.Threading.Thread.Sleep(5000);
        String strConn = ConfigurationManager.ConnectionStrings["NorthwindConnectionString"].ConnectionString;
        List<Category> Categories = new List<Category>();
        using (SqlConnection conn = new SqlConnection(strConn))
        {
            String strCmd = "select CategoryID,CategoryName from Categories";
            using (SqlCommand cmd = new SqlCommand(strCmd, conn))
            {
               
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read()) {
                    Category category = new Category();
                    category.CategoryID = Convert.ToInt32(dr["CategoryID"]);
                    category.CategoryName = dr["CategoryName"].ToString();

                    Categories.Add(category);
                    
                }
                conn.Close();
            }

        }
        context.Response.ContentType = "application/json";
        context.Response.Write(JsonConvert.SerializeObject(Categories));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}

public class Category {
    public int CategoryID { get; set; }
    public string CategoryName { get; set; }
}