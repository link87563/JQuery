<%@ WebHandler Language="C#" Class="HandlerXml" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class HandlerXml : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
        //步驟一給予適當的名稱空間
        //步驟二建立連線物件(需要連線字串)
        string strConn = ConfigurationManager.ConnectionStrings["northwindConnectionString"].ConnectionString;
        using (SqlConnection conn = new SqlConnection(strConn)) {
           //步驟三讀取資料庫的資料
           string strCmd = "select CategoryId,CategoryName from Categories";
           SqlDataAdapter da = new SqlDataAdapter(strCmd,conn);

           //步驟四將資料放進DataSet中
           DataSet ds = new DataSet();
           ds.DataSetName = "Categories";  //Categories會變成跟元素的名稱
           da.Fill(ds,"Category");  //Category會是一筆筆的分類資料


           context.Response.ContentType = "text/xml";
           context.Response.Write(ds.GetXml());
            
        };
       
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}