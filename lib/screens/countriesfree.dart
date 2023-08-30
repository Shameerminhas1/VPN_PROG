import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/vpn_config.dart';
import 'package:flag/flag.dart';

class CountriesScreenFree extends StatefulWidget {
  @override
  _CountriesScreenFreeState createState() => _CountriesScreenFreeState();
}

class _CountriesScreenFreeState extends State<CountriesScreenFree> {
  List<VpnConfig> _listVpn = [];

  VpnConfig? _selectedVpn;

  @override
  void initState() {
    super.initState();
    initVpn();
  }

  void initVpn() async {
    _selectedVpn = null;

    List<VpnConfig> listVpn = [
      VpnConfig(
        config: await rootBundle.loadString('assets/vpn/japan.ovpn'),
        country: 'Japan',
        countrycode: 'JP',
        username: 'vpn',
        password: 'vpn',
      ),
      VpnConfig(
        config: await rootBundle.loadString('assets/vpn/russia.ovpn'),
        country: 'Russia',
        countrycode: 'RU',
        username: 'vpn',
        password: 'vpn',
      ),

      // Add more VPN configurations if needed
    ];

    setState(() {
      _listVpn = listVpn;
      _selectedVpn = listVpn.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a country'),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/signin.jpg'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.06,
          ),
          child: Container(
            child: ListView.builder(
              itemCount: _listVpn.length,
              itemBuilder: (context, index) {
                VpnConfig vpnConfig = _listVpn[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.02,
                    left: MediaQuery.of(context).size.width * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 22, 212, 237),
                      // const Color.fromARGB(255, 133, 187, 231),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.004,
                      ),
                      child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 1,
                          child: Flag.fromString(vpnConfig.countrycode,
                              height: 70, width: 50),
                        ),
                        title: Text(
                          vpnConfig.country,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        onTap: () {
                          log("${vpnConfig.country} is selected");
                          setState(() {
                            _selectedVpn = vpnConfig;
                          });
                          Navigator.pop(context, _selectedVpn);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
