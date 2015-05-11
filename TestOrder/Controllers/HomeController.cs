using System.Web.Mvc;
using Order;
using TestOrder.Models;

namespace TestOrder.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        private IOrderService _service;

        public HomeController(IOrderService service)
        {
            _service = service;
        }

        public ActionResult Index()
        {
            OrderModel model = new OrderModel();
            model.Orders = _service.GetAllOrder();
            return View(model);
        }

        [HttpPost]
        public ActionResult Index(OrderModel model)
        {
            model.Orders = _service.GettSearchedOrder(model.SearchText);
            return View(model);
        }

    }
}
