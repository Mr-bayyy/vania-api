import 'package:vania_api/app/models/products.dart';
import 'package:vania/vania.dart';

class ProductsController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> store(Request request) async {
    try {
      final productsData = request.input();

      if (productsData == null) {
        throw Exception("Data tidak ditemukan dalam database");
      }

      await Products().query().insert(productsData);

      return Response.json({
        'message': 'Produk berhasil disimpan dalam database',
        'data': productsData,
      }, 201);
    } catch (e) {
      return Response.json({
        'messsage': 'Error',
      }, 500);
    }
  }

  Future<Response> show() async {
    try {
      final listProducts = await Products().query().get();
      return Response.json({
        'message': 'Data produk',
        'data': listProducts,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Error',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> update(Request request, String prod_id) async {
    try {
      final productsData = request.input();

      final produk =
          await Products().query().where('prod_id', '=', prod_id).first();

      if (produk == null) {
        return Response.json({
          'message': 'Data produk  tidak ditemukan',
        }, 404);
      }

      final updatedRows = await Products()
          .query()
          .where('prod_id', '=', prod_id)
          .update(productsData);

      if (updatedRows == 0) {
        return Response.json({
          'message': 'tidak dapat diperbarui ',
        }, 400);
      }

      return Response.json({
        'message': 'produk berhasil diperbarui',
        'data': productsData,
      }, 200);
    } catch (e) {
      print("Error occurred: $e");
      return Response.json({
        'message': 'eror ketika proses update',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(String prodid) async {
    try {
      final produk =
          await Products().query().where('prod_id', '=', prodid).first();

      if (produk == null) {
        return Response.json({
          'message': 'produk dengan id $prodid tidak ditemukan',
        }, 404);
      }

      await Products().query().where('prod_id', '=', prodid).delete();

      return Response.json({
        'message': 'produk dengan id $prodid berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Error',
        'error': e.toString(),
      }, 500);
    }
  }
}

final ProductsController productsController = ProductsController();
