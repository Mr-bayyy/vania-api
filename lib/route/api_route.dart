import 'package:vania/vania.dart';
import 'package:vania_api/app/http/controllers/auth_controller.dart';
import 'package:vania_api/app/http/controllers/orders_controller.dart';
import 'package:vania_api/app/http/controllers/orderitems_controller.dart';
import 'package:vania_api/app/http/controllers/vendors_controller.dart';
import 'package:vania_api/app/http/controllers/productnotes_controller.dart';
import 'package:vania_api/app/http/controllers/products_controller.dart';
import 'package:vania_api/app/http/controllers/customers_controller.dart';


// produk, kostumer, order, order item, vendor, produk notes

class ApiRoute implements Route {
  @override
  void register() {
    Router.get('/customers', CustomersController().show);
    Router.get('/vendors', VendorsController().show);
    Router.get('/products', ProductsController().show);
    Router.get('/productnotes', ProductnotesController().show);
    Router.get('/orders', OrdersController().show);
    Router.get('/orderitems', OrderitemsController().show);
    Router.post('/customers-store', CustomersController().store);
    Router.post('/vendors-store', VendorsController().store);
    Router.post('/products-store', ProductsController().store);
    Router.post('/productnotes-store', ProductnotesController().store);
    Router.post('/orders-store', OrdersController().store);
    Router.post('/orderitems-store', OrderitemsController().store);
    Router.post('/login', AuthController().login);
    Router.put('/customers/edit/{cust_id}', CustomersController().update);
    Router.put('/vendors/edit/{vend_id}', VendorsController().update);
    Router.put('/products/edit/{prod_id}', ProductsController().update);
    Router.put('/productnotes/edit/{note_id}', ProductnotesController().update);
    Router.put('/orders/edit/{order_num}', OrdersController().update);
    Router.put('/orderitems/edit/{order_item}', OrderitemsController().update);
    Router.delete('/customers/delete/{custid}', CustomersController().destroy);
    Router.delete('/vendors/delete/{vendid}', VendorsController().destroy);
    Router.delete('/products/delete/{prodid}', ProductsController().destroy);
    Router.delete('/productnotes/delete/{noteid}', ProductnotesController().destroy);
    Router.delete('/orders/delete/{orderid}', OrdersController().destroy);
    Router.delete('/orderitems/delete/{orderitem}', OrderitemsController().destroy);

  }
}
