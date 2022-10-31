import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final authBlock = BlocProvider.of<AuthBloc>(context);
    return FloatingActionButton(
      backgroundColor: const Color.fromRGBO(236, 98, 188, 1),
      heroTag: 'btn1',
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);
        if (barcodeScanRes == '-1') {
          return;
        }
        print(barcodeScanRes);
        final check = await authBlock.sendTokenQr(barcodeScanRes);
      },
      child: const Icon(Icons.filter_center_focus, size: 40),
    );
  }
}
