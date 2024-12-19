import 'package:vania_api/app/models/customers.dart';
import 'package:vania/vania.dart';

class CustomersController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello Bayu'});
  }

  Future<Response> store(Request request) async {
    try {
      final customersData = request.input();

      if (customersData == null) {
        throw Exception("Data tidak ditemukan dalam database");
      }

      await Customers().query().insert(customersData);

      return Response.json({
        'message': 'Data customer berhasil disimpan dalam database',
        'data': customersData,
      }, 201);
    } catch (e) {
      return Response.json({
        'messsage': 'Error 500',
      }, 500);
    }
  }

  Future<Response> show() async {
    try {
      final listCustomers = await Customers().query().get();
      return Response.json({
        'message': 'Data customer',
        'data': listCustomers,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Error',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> update(Request request, String cust_id) async {
    try {
      final customersData = request.input();

      final customer =
          await Customers().query().where('cust_id', '=', cust_id).first();

      if (customer == null) {
        return Response.json({
          'message': 'Data customer tersebut tidak ditemukan pada database',
        }, 404);
      }

      final updatedRows = await Customers()
          .query()
          .where('cust_id', '=', cust_id)
          .update(customersData);

      if (updatedRows == 0) {
        return Response.json({
          'message': 'Data tidak diperbarui',
        }, 400);
      }

      return Response.json({
        'message': 'Data customer berhasil diperbarui',
        'data': customersData,
      }, 200);
    } catch (e) {
      print("Error occurred: $e");
      return Response.json({
        'message': 'eror ketika proses update',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(String custid) async {
    try {
      final customer =
          await Customers().query().where('cust_id', '=', custid).first();
      
      if (customer == null) {
        return Response.json({
          'message': 'Data customer tersebut tidak ditemukan!',
        }, 404);
      }

      await Customers().query().where('cust_id', '=', custid).delete();

      return Response.json({
        'message': 'Data customer berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Error',
        'error': e.toString(),
      }, 500);
    }
  }
}

final CustomersController customersController = CustomersController();
