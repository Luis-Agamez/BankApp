import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                child: Column(
      children: [
        SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: state.transfers.length,
                itemBuilder: (context, index) {
                  return _Card(
                      origin: state.transfers[index].accountorigin,
                      destiny: state.transfers[index].accountdestiny[0],
                      value: '${state.transfers[index].amount}');
                },
              );
            },
          ),
        ))
      ],
    ))));
  }
}

class _Card extends StatelessWidget {
  final String destiny;
  final String origin;
  final String value;
  const _Card({
    Key? key,
    required this.destiny,
    required this.origin,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text('Transferencia Bancaria',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            _CardData(
              title: 'Cuenta de Destino',
              current: Text(destiny,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            const SizedBox(height: 10),
            _CardData(
              title: 'Cuenta de Origen',
              current: Text(origin,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            ),
            const SizedBox(height: 5),
            _CardData(
              title: 'Valor',
              current: Text(value,
                  style: const TextStyle(
                      color: Colors.purple,
                      fontSize: 14,
                      fontWeight: FontWeight.w900)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardData extends StatelessWidget {
  const _CardData({
    Key? key,
    required this.title,
    required this.current,
  }) : super(key: key);
  final String title;
  final Text current;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ),
          current
        ],
      ),
    );
  }
}
