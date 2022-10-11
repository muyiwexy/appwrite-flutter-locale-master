import 'package:ecommerce/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/authenticate.dart';


class Mainhomepage extends StatefulWidget {
  late var user;
  Mainhomepage({super.key, required this.user});
  @override
  State<Mainhomepage> createState() => _MainhomepageState();
}
class _MainhomepageState extends State<Mainhomepage> {
  bool loading = true;
  void initializeLocaleAPI() {
    Authenticate state = Provider.of<Authenticate>(context, listen: false);
    var localization = state.localisation();
    localization.then((response) {
      setState(() {
        loading = false;
      });
    }).catchError((error) {
      print(error.response);
    });
  }
  @override
  void initState() {
    initializeLocaleAPI();
    super.initState();
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1F24),
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: InkWell(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Mainhomepage(
                            user: widget.user,
                          )));
            },
            child: const Text(
              'Swagga',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0x5AF1F4F8),
              ),
            ),
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Consumer<Authenticate>(
                  builder: (context, state, child) {
                    if (!state.isLoggedin) return Container();
                    return Text("Welcome, ${state.user?.name ?? ''}");
                  },
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () {
                  Authenticate state =
                      Provider.of<Authenticate>(context, listen: false);
                  state.signout();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ));
                },
                icon: const Icon(Icons.exit_to_app),
              )),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: loading
          ? const CircularProgressIndicator(
              color: Colors.blue,
            )
          : Consumer<Authenticate>(
              builder: (context, state, child) {
                if (!state.isLoggedin) return Container();
                return ListView(
                    padding: const EdgeInsets.all(16),
                    children: <Widget>[
                      Row(
                        children: [
                          const Center(
                            child: Text('Name:- ',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                            child: Text(state.user?.name ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Center(
                            child: Text('IP:- ',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                            child: Text(state.localedata?.ip ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Center(
                            child: Text('Country Code:- ',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                            child: Text(state.localedata?.countryCode ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Center(
                            child: Text('Country:- ',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                            child: Text(state.localedata?.country ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Center(
                            child: Text('Continent Code:- ',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                            child: Text(state.localedata?.continentCode ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Center(
                            child: Text('Continent:- ',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                            child: Text(state.localedata?.continent ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Center(
                            child: Text('Currency:- ',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                          Center(
                            child: Text(state.localedata?.currency ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                )),
                          ),
                        ],
                      ),
                    ]);
              },
            ),
    );
  }
}
