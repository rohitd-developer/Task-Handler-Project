import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(
                    top: 30,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('lib/images/aw.jpeg'),
                          fit: BoxFit.fill)),
                ),
                Text(
                  'Rohit Dabane',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'rohitdabane44@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(
            'Setting',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: null,
        ),
        ListTile(
          leading: Icon(Icons.arrow_back),
          title: Text(
            'Logout',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onTap: null,
        )
      ],
    ));
  }
}
