using System.Collections.Generic;
using ISoftGeeks.Data;
namespace Order
{
    public interface IOrderRepository<TEntity> : IRepository<TEntity>
    {
        IEnumerable<Order> GettSearchedOrder(string queryText);
    }
}