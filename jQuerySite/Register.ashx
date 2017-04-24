<%@ WebHandler Language="C#" Class="Register" %>

using System;
using System.Web;

public class Register : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
       string strName = context.Request.Params["name"];
        string strEmail = context.Request.Params["email"];
        string strPassword = context.Request.Params["password"];
        context.Response.ContentType = "text/plain";
        context.Response.Write(String.Format("Hello {0}, your email is {1} and password is {2}.",strName,strEmail,strPassword));
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}