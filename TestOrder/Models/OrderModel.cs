using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TestOrder.Models
{
    public class OrderModel
    {
        public IEnumerable<Order.Order> Orders { get; set; }
        public string SearchText { get; set; }
    }
}