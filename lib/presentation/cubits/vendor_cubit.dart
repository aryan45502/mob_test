import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_event_planner/domain/repositories/vendor_repository.dart';
import 'package:wedding_event_planner/domain/entities/vendor.dart';

abstract class VendorState {}

class VendorInitial extends VendorState {}

class VendorLoading extends VendorState {}

class VendorLoaded extends VendorState {
  final List<Vendor> vendors;
  VendorLoaded(this.vendors);
}

class VendorError extends VendorState {
  final String message;
  VendorError(this.message);
}

class VendorCubit extends Cubit<VendorState> {
  final VendorRepository vendorRepository;

  VendorCubit({required this.vendorRepository}) : super(VendorInitial());

  Future<void> fetchVendors() async {
    try {
      emit(VendorLoading());
      final vendors = await vendorRepository.getVendors();
      emit(VendorLoaded(vendors));
    } catch (e) {
      emit(VendorError("Failed to load vendors"));
    }
  }
}
