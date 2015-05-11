using System.Collections.Generic;
using ISoftGeeks.Data;
namespace Order
{
    public class OrderRepository<TEntity> : Repository<TEntity>, IOrderRepository<TEntity>
    {
        public OrderRepository(string dbConnection) : base(dbConnection) { }

        public IEnumerable<Order> GettSearchedOrder(string queryText)
        {
            Dictionary<string,string> parameter = new Dictionary<string, string>();
            parameter.Add("SearchString",queryText);
            return ExecuteStoreProcidure<Order>("Order_GetAllOrder_Search", parameter);
        }
    }
}