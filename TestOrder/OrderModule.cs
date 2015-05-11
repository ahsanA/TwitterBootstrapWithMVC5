using System.Configuration;
using Ninject.Modules;
using Order;

namespace TestOrder
{
    public class OrderModule : NinjectModule
    {
        public override void Load()
        {
            Bind<IOrderRepository<Order.Order>>().To<OrderRepository<Order.Order>>().WithConstructorArgument("dbConnection", ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            Bind<IOrderService>().To<OrderService>();
            Bind<IOrder>().To<Order.Order>();
            Bind<IEntity>().To<Entity>();
        }
    }
}