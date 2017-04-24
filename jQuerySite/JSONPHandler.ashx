<%@ WebHandler Language="C#" Class="JSONPHandler" %>

using System;
using System.Web;

public class JSONPHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        var f = context.Request.QueryString["callback"]; //f="callback"
        //var data = "Hello JSONP";
        
        context.Response.ContentType = "text/plain";
       
        context.Response.Write(string.Format("{0}('Hello JSONP')",f)); //callback("Hello JSONP")
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}