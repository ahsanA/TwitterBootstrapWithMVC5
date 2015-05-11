//using System;

using System;
using System.Collections.Generic;

namespace Order
{
    public class OrderService : IOrderService
    {
        IOrderRepository<Order> _orderRepository;

        public OrderService(IOrderRepository<Order> orderRepository)
        {
            _orderRepository = orderRepository;

        }

        #region Order
        public void AddOrder(Order order)
        {
            try
            {
                _orderRepository.AddItem(order);
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        public void EditOrder(Order order)
        {
            try
            {
                _orderRepository.UpdateItem(order);
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        public void DeleteOrder(Guid id)
        {
            try
            {
                _orderRepository.DeleteItem(id);
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        public IEnumerable<Order> GetAllOrder()
        {
            try
            {
                return _orderRepository.GetAllItem();
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        public IEnumerable<Order> GetAllPagedOrder(int pageSize, int pageNumber)
        {
            try
            {
                return _orderRepository.GetPagedAllItem(pageSize, pageNumber);
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        public Order GetOrder(Guid id)
        {
            try
            {
                return _orderRepository.GetItem(id);
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        public int GetTotalOrder()
        {
            try
            {
                return _orderRepository.GetTotalCount();
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        public IEnumerable<Order> GettSearchedOrder(string queryText)
        {
            try
            {
                if (queryText != null)
                {
                    return _orderRepository.GettSearchedOrder(queryText);
                }
                else
                {
                    return _orderRepository.GetAllItem();
                }
                
            }
            catch (Exception exception)
            {
                //_logger.WriteLog("Cannot insert data \n-----------------\n"+ exception);
                throw;
            }
        }

        #endregion
    }
}