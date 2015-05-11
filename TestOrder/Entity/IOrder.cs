using System;
namespace Order
{
	public interface IOrder : IEntity
	{
		decimal OrderCost { get; set; }
		
	}
}