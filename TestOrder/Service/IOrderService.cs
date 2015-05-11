using System;
using System.Collections.Generic;

namespace Order
{
	public interface IOrderService
	{
		#region Order
		void AddOrder(Order order);
		void EditOrder(Order order);
		void DeleteOrder(Guid id);
		Order GetOrder(Guid id);
		IEnumerable<Order> GetAllOrder();
		IEnumerable<Order> GetAllPagedOrder(int pageSize, int pageNumber);
		int GetTotalOrder();
        IEnumerable<Order> GettSearchedOrder(string queryText);
		#endregion

		}
}