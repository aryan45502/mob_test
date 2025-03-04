import 'package:wedding_event_planner/domain/entities/vendor.dart';

abstract class VendorRepository {
  Future<List<Vendor>> getVendors();
}
