<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
            
        string strName = context.Request.Params["name"];
        string strAge = context.Request.Params["age"];
        context.Response.ContentType = "text/plain";
        context.Response.Write(String.Format("Hello {0}, you are {1} years old.",strName,strAge));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}