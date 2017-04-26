<%@ WebHandler Language="C#" Class="Hello" %>

using System;
using System.Web;

public class Hello : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        string name = context.Request.QueryString["keyword"];
        context.Response.ContentType = "text/plain";
        context.Response.Write(string.Format("Hello {0}",name));
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}