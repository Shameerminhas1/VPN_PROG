import 'package:flutter/material.dart';
import 'countdowntimer.dart';
import '../models/vpn_config.dart';
import '../models/vpn_status.dart';
import '../services/vpn_engine.dart';
import 'package:vpn_prog/screens/countriesfree.dart';
import 'package:flag/flag.dart';

class HomeScreenFree extends StatefulWidget {
  @override
  _HomeScreenFreeState createState() => _HomeScreenFreeState();
}

class _HomeScreenFreeState extends State<HomeScreenFree> {
  bool shouldStartTimer = false; //nc ti
  String _vpnState = VpnEngine.vpnDisconnected;
  VpnConfig? _selectedVpn;

// Track the connection state               //update

  @override
  void initState() {
    super.initState();

    VpnEngine.vpnStageSnapshot().listen((event) {
      setState(() => _vpnState = event);
    });

    initVpn();
  }

  void initVpn() async {
    _selectedVpn = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/connected.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.06,
                  right: MediaQuery.of(context).size.width * 0.03,
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Material(
                    //   color: Colors.transparent,
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.pushNamed(context, 'dashboard');
                    //     },
                    //     child: const Icon(
                    //       Icons.dashboard,
                    //       color: Colors.blue,
                    //     ),
                    //   ),
                    // ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, 'register');
                        },
                        child: const Icon(
                          Icons.person_2_rounded,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.07,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      StreamBuilder<VpnStatus?>(
                          initialData: VpnStatus(),
                          stream: VpnEngine.vpnStatusSnapshot(),
                          builder: (context, snapshot) {
                            String byteInText = '00.00 bytes';
                            String byteOutText = '00.00 bytes';
                            // Update values if snapshot has data and byteIn/byteOut are not null
                            if (snapshot.hasData) {
                              if (snapshot.data!.byteIn != null) {
                                byteInText = "${snapshot.data!.byteIn}";
                              } else {
                                byteInText = '00.00 bytes';
                              }
                              if (snapshot.data!.byteOut != null) {
                                byteOutText = "${snapshot.data!.byteOut}";
                              } else {
                                byteOutText = '00.00 bytes';
                              }
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.089,
                                    width: MediaQuery.of(context).size.width *
                                        0.42,
                                    child: Row(
                                      children: [
                                        const Padding(
                                            padding:
                                                EdgeInsets.only(left: 0.8)),
                                        Image.asset(
                                          'assets/images/UP.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.035,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.015,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                            )),
                                            Text(
                                              byteOutText,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            const Text(
                                              'Upload',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        )
                                      ],
                                    )),
                                const SizedBox(width: 20),
                                Column(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.089,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.42,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/down.png',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.035),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.015,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.20,
                                                )),
                                                Text(
                                                  byteInText,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                const Text(
                                                  'Download',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            )
                                          ],
                                        )),
                                  ],
                                )
                              ],
                            );
                          }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.177,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: getButtonColor,
                        blurRadius: 14,
                        spreadRadius: 9.0,
                      ),
                    ],
                  ),
                  child: Container(
                    child: CircleAvatar(
                      radius: 81,
                      child: Container(
                        child: Column(
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.11,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.1,
                                  right:
                                      MediaQuery.of(context).size.width * 0.1,
                                  left: MediaQuery.of(context).size.width * 0.1,
                                ),
                              ),
                              child: Text(
                                _vpnState == VpnEngine.vpnDisconnected
                                    ? 'CONNECT'
                                    : _vpnState
                                        .replaceAll("_", " ")
                                        .toUpperCase(),
                                style: TextStyle(
                                  color: getButtonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: _connectClick,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  if (_vpnState == VpnEngine.vpnConnected)
                    CountDownTimer(
                      startTimer: true,
                    ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              if (_selectedVpn != null)
                Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.415,
                    left: MediaQuery.of(context).size.width * 0.415,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.0001,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.blue,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Flag.fromString(
                        _selectedVpn!.countrycode,
                        height: 30,
                        width: 15,
                      ),
                    ),
                  ),
                ),

              SizedBox(
                height: 2,
              ),
              TextButton(
                onPressed: () async {
                  final selectedVpn = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CountriesScreenFree()),
                  );
                  if (selectedVpn != null) {
                    setState(() {
                      _selectedVpn = selectedVpn;
                    });
                  }
                },
                child: Text(
                  'Select a Differet Region',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
              // SizedBox(
              //   height: 2,
              // ),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  void _connectClick() async {
    if (_selectedVpn == null) return;
    setState(() {});
    if (_vpnState == VpnEngine.vpnDisconnected) {
      await VpnEngine.startVpn(_selectedVpn!);
      setState(() {});
    } else {
      await VpnEngine.stopVpn();
      setState(() {});
    }
  }

  Color get getButtonColor {
    switch (_vpnState) {
      case VpnEngine.vpnDisconnected:
        return Colors.blue;
      case VpnEngine.vpnWaitConnection:
      case VpnEngine.vpnAuthenticating:
      case VpnEngine.vpnConnecting:
        return Colors.orange;
      case VpnEngine.vpnConnected:
        return Colors.green;
      case VpnEngine.vpnDenied:
      case VpnEngine.vpnReconnect:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }
}
