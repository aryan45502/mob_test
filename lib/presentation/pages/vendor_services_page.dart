import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_event_planner/domain/entities/vendor.dart';
import 'package:wedding_event_planner/presentation/cubits/booking_cubit.dart';
import 'package:wedding_event_planner/presentation/cubits/vendor_cubit.dart';

class VendorServicesPage extends StatefulWidget {
  const VendorServicesPage({super.key});

  @override
  _VendorServicesPageState createState() => _VendorServicesPageState();
}

class _VendorServicesPageState extends State<VendorServicesPage> {
  @override
  void initState() {
    super.initState();
    // ✅ Ensure that the VendorCubit is provided before calling fetchVendors()
    Future.microtask(() => context.read<VendorCubit>().fetchVendors());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vendor Services")),
      body: BlocBuilder<VendorCubit, VendorState>(
        builder: (context, state) {
          if (state is VendorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VendorLoaded) {
            final vendors = state.vendors;

            if (vendors.isEmpty) {
              return const Center(child: Text("No vendors available."));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: vendors.length,
              itemBuilder: (context, index) {
                final Vendor vendor = vendors[index];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        vendor.image.replaceAll(
                            "localhost", "10.0.2.2"), // ✅ Fix image URL
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image_not_supported,
                              size: 60, color: Colors.grey);
                        },
                      ),
                    ),
                    title: Text(
                      vendor.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "${vendor.category} - \$${vendor.price.toStringAsFixed(2)}"),
                    trailing: ElevatedButton(
                      onPressed: () => _showBookingDialog(context, vendor.id),
                      child: const Text("Book"),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Failed to load vendors"));
          }
        },
      ),
    );
  }

  void _showBookingDialog(BuildContext context, String serviceId) {
    final TextEditingController dateController = TextEditingController();
    final TextEditingController guestCountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Book Service"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: dateController,
                decoration: const InputDecoration(
                  labelText: "Booking Date (YYYY-MM-DD)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: guestCountController,
                decoration: const InputDecoration(
                  labelText: "Guest Count",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Confirm"),
              onPressed: () {
                final date = dateController.text;
                final guestCount = int.tryParse(guestCountController.text) ?? 1;
                context
                    .read<BookingCubit>()
                    .bookService(serviceId, date, guestCount);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
