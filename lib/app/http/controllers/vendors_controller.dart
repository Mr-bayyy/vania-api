import 'package:vania_api/app/models/vendors.dart';
import 'package:vania/vania.dart';

class VendorsController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    try {
      final vendorsData = request.input();

      if (vendorsData == null) {
        throw Exception("Data tidak ditemukan dalam database");
      }

      await Vendors().query().insert(vendorsData);

      return Response.json({
        'message': 'Data berhasil disimpan dalam database',
        'data': vendorsData,
      }, 201);
    } catch (e) {
      return Response.json({
        'messsage': 'Error',
      }, 500);
    }
  }

  Future<Response> show() async {
    try {
      final listVendors = await Vendors().query().get();
      return Response.json({
        'message': 'Data data vendors',
        'data': listVendors,
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Error',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> update(Request request, String vend_id) async {
    try {
      final vendorsData = request.input();

      final vendor =
          await Vendors().query().where('vend_id', '=', vend_id).first();

      if (vendor == null) {
        return Response.json({
          'message': 'vendor dengan id $vend_id tidak ditemukan',
        }, 404);
      }

      final updatedRows = await Vendors()
          .query()
          .where('vend_id', '=', vend_id)
          .update(vendorsData);

      if (updatedRows == 0) {
        return Response.json({
          'message': 'gagal diperbarui ',
        }, 400);
      }

      return Response.json({
        'message': 'Vendor berhasil diperbarui',
        'data': vendorsData,
      }, 200);
    } catch (e) {
      print("Error occurred: $e");
      return Response.json({
        'message': 'eror ketika proses update',
        'error': e.toString(),
      }, 500);
    }
  }

  Future<Response> destroy(String vendid) async {
    try {
      final customer =
          await Vendors().query().where('vend_id', '=', vendid).first();

      if (customer == null) {
        return Response.json({
          'message': 'vendor dengan id $vendid tidak ditemukan',
        }, 404);
      }

      await Vendors().query().where('vend_id', '=', vendid).delete();

      return Response.json({
        'message': 'vendor berhasil dihapus',
      }, 200);
    } catch (e) {
      return Response.json({
        'message': 'Error',
        'error': e.toString(),
      }, 500);
    }
  }
}

final VendorsController vendorsController = VendorsController();
