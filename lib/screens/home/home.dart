import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/models/brew.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SettingsForm();
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: new PreferredSize(
          preferredSize: new Size(MediaQuery.of(context).size.width, 50.0),
          child: new Container(
            padding:
                new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: new Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 1.0, bottom: 1.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Brew Crew',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      FlatButton.icon(
                        padding: EdgeInsets.only(left: 50),
                        icon: Icon(Icons.person, color: Colors.white),
                        label: Text(
                          'logout',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          await _auth.signOut();
                        },
                      ),
                      VerticalDivider(
                          color: Colors.black, thickness: 2, width: 20),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        label: Text(
                          "settings",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () => _showSettingsPanel(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [Colors.blueGrey, Colors.lightBlueAccent])
                    ),
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/coffee_bg.png'), fit: BoxFit.cover),
            ),
            child: BrewList()),
      ),
    );
  }
}
