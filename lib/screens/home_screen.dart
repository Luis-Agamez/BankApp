import 'package:bank/screens/screens.dart';
import 'package:bank/screens/transfers_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/clime/clime_bloc.dart';
import '../blocs/location/location_bloc.dart';
import '../widgets/floating_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final screens = const [MainContent(), TransferScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        elevation: 8,
        iconSize: 28,
        selectedItemColor: const Color.fromRGBO(236, 98, 188, 1),
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'Enviados',
          )
        ],
      );
}

class MainContent extends StatefulWidget {
  const MainContent({
    Key? key,
  }) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  late LocationBloc locationBloc;
  late AuthBloc authBloc;
  late ClimeBloc climeBloc;
  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.getCurrentPosition();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.getAccountsStream();
    authBloc.getAccountsSaving();
    authBloc.GetTransfersSends();
    authBloc.getAccountsSaving();
    authBloc.getRegisteredSavingAccount();
    authBloc.getRegisteredStreamAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        climeBloc = BlocProvider.of<ClimeBloc>(context);
        climeBloc.getClime(state.ltd, state.lgd);
        climeBloc.getClimePredictions(state.ltd, state.lgd);
        return Stack(
          children: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _UserInformation(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionsBuilder: (((context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                })),
                                pageBuilder: (context, _, __) => AccountsScreen(
                                      title: 'Cuentas Ahorro',
                                      element: state.saving,
                                    )));
                          },
                          child: const _Item(
                              text: 'Cuentas de Ahorros',
                              icon: Icon(
                                Icons.balance_outlined,
                                size: 45,
                                color: Colors.green,
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(PageRouteBuilder(
                                transitionsBuilder: (((context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                })),
                                pageBuilder: (context, _, __) => AccountsScreen(
                                      title: 'Cuentas Corrientes',
                                      element: state.stream,
                                    )));
                          },
                          child: const _Item(
                              text: 'Cuentas Corrientes',
                              icon: Icon(Icons.balance_outlined,
                                  size: 45, color: Colors.purple)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Proximos 5 Dias',
                        style: TextStyle(
                            color: Color(0xff2E305F),
                            fontSize: 24,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<ClimeBloc, ClimeState>(
                      builder: (context, state) {
                        return state.climePredictions.isNotEmpty
                            ? Container(
                                height: 150,
                                padding: const EdgeInsets.only(top: 30),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Colors.blue,
                                          Colors.blueGrey
                                        ])),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const ScrollPhysics(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: state.climePredictions[0].list
                                        .map((item) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${item.dtTxt}'
                                                          .replaceRange(
                                                              0, 10, '')
                                                          .replaceRange(
                                                              5, 12, ''),
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      '${item.main.temp}º',
                                                      style: const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Image.asset(
                                                      'assets/${item.weather[0].icon}.png',
                                                      scale: 2.5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.air_outlined,
                                                          size: 14,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          ' :${item.wind.speed} m/s',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                        )
                                                      ],
                                                    ),
                                                  ]),
                                            ))
                                        .toList(),
                                  ),
                                ))
                            : Container();
                      },
                    )
                  ],
                );
              },
            ),
            BlocBuilder<ClimeBloc, ClimeState>(
              builder: (context, state) {
                return Positioned(
                  top: 60,
                  right: 50,
                  child: Stack(
                      children: state.clime
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              e.main.temp
                                                  .toStringAsPrecision(3),
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          const Text(
                                            'º',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Image.asset(
                                        'assets/${e.weather[0].icon}.png',
                                        scale: 1.2,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.air_outlined,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            ' :${e.wind.speed} m/s',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                    ]),
                              ))
                          .toList()),
                );
              },
            ),
            Positioned(
              bottom: 60,
              right: 30,
              child: FloatingActionButton(
                heroTag: 'send',
                backgroundColor: const Color.fromRGBO(236, 98, 188, 1),
                onPressed: () {
                  Navigator.pushNamed(context, 'data');
                },
                child: const Icon(
                  Icons.monetization_on_outlined,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 30,
              child: FloatingActionButton(
                heroTag: 'logout',
                backgroundColor: Color(0xff2E305F),
                onPressed: () {
                  authBloc.logout();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _UserInformation extends StatelessWidget {
  const _UserInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 250,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Color(0xff2E305F),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(80))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(50)),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Hola',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              print(state.existsUser);
              return state.existsUser
                  ? Text(
                      '${state.user!.name}',
                      style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          fontSize: 28),
                    )
                  : Text('');
            },
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final String text;
  final Icon icon;
  const _Item({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 150,
      child: Card(
          elevation: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(50)),
                  child: icon),
              Text(text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))
            ],
          )),
    );
  }
}
