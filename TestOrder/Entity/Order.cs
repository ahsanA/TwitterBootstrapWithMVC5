using System;
namespace Order
{
	public class Order : Entity,IOrder
	{
		public decimal OrderCost { get; set; }
		
	}
}