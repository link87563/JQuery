using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Product 的摘要描述
/// </summary>
public class Product
{
	public Product()
	{
		//
		// TODO: 在這裡新增建構函式邏輯
		//
	}

    public int ProductID { get; set; }
    public string ProductName { get; set; }
    public decimal UnitPrice { get; set; }
    public int UnitsInStock { get; set; }
}