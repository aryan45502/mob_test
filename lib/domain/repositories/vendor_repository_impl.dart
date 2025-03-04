import 'package:wedding_event_planner/data/datasources/vendor_remote_datasource.dart';
import 'package:wedding_event_planner/domain/repositories/vendor_repository.dart';
import 'package:wedding_event_planner/domain/entities/vendor.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorRemoteDataSource vendorRemoteDataSource;

  VendorRepositoryImpl({required this.vendorRemoteDataSource});

  @override
  Future<List<Vendor>> getVendors() async {
    try {
      return await vendorRemoteDataSource.fetchVendors();
    } catch (e) {
      throw Exception("Error fetching vendors: $e");
    }
  }
}
