<%@ WebHandler Language="C#" Class="UpdateProductHandler" %>

using System;
using System.Web;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.IO;
using System.Configuration;


public class UpdateProductHandler : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {

        
        //接收傳過來的JSON資料
        //StreamReader reader = new StreamReader(context.Request.InputStream);
        //string strProduct = reader.ReadToEnd();

        //Product product = (Product)JsonConvert.DeserializeObject(strProduct, typeof(Product));

        //Int32 productID = product.ProductID;
        //String productName = product.ProductName;
        //String unitPrice = product.UnitPrice;
        //String unitsInStock = product.UnitsInStock;
        Int32 productID = Convert.ToInt32(context.Request.Form["ProductID"]);
        String productName = context.Request.Form["ProductName"];
        String unitPrice = context.Request.Form["UnitPrice"];
        String unitsInStock = context.Request.Form["UnitsInStock"];
        String strMessage = "";
            
        // Response.Write(String.Format("{0}-{1}-{2}",strName,strEmail,strAge));

        //步驟一給予適當的名稱空間
        //步驟二建立連線物件
   
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["northwindConnectionString"].ConnectionString))
        {
            //步驟三新增資料到資料庫
            String strCmd = "Update Products set ProductName=@ProductName,UnitPrice=@UnitPrice,UnitsInStock=@UnitsInStock where ProductID=@ProductID";
            using (SqlCommand cmd = new SqlCommand(strCmd, conn))
            {
                //宣告參數
                cmd.Parameters.AddWithValue("@ProductID", productID);
                cmd.Parameters.AddWithValue("@ProductName", productName);
                cmd.Parameters.AddWithValue("@UnitPrice", unitPrice);
                cmd.Parameters.AddWithValue("@UnitsInStock", unitsInStock);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    strMessage = "修改成功";
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

public class Product
{
    public int ProductID { get; set; }
    public string ProductName { get; set; }
    public string UnitPrice { get; set; }
    public string UnitsInStock { get; set; }
}