<%@ WebHandler Language="C#" Class="corsHandler" %>

using System;
using System.Web;

public class corsHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.AppendHeader("Access-Control-Allow-Origin", "*");
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello CORS!!");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}