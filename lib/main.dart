import 'package:bank/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/clime/clime_bloc.dart';
import 'blocs/gps/gps_bloc.dart';
import 'blocs/location/location_bloc.dart';

void main() => runApp(MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AuthBloc()),
      BlocProvider(
        create: (context) => LocationBloc(),
      ),
      BlocProvider(
        create: (context) => ClimeBloc(),
      ),
      BlocProvider(
        create: (context) => GpsBloc(),
      ),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bank App',
      initialRoute: 'loading',
      routes: appRoutes,
    );
  }
}
