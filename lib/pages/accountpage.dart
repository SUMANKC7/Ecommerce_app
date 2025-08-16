import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        title: Title(color: Colors.black, child: const Text("My Account")),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Basic Information",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 20),
            Material(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("My Name", style: TextStyle(fontSize: 19)),
                subtitle: Text("My Numeber", style: TextStyle(fontSize: 19)),
              ),
            ),
            SizedBox(height: 40),
            Text(
              "Security Setting",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 20),
            Material(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout", style: TextStyle(fontSize: 19)),
                subtitle: Text("Logout", style: TextStyle(fontSize: 16)),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            SizedBox(height: 30),
            Material(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Change Passeord", style: TextStyle(fontSize: 19)),
                subtitle: Text(
                  "Change Password",
                  style: TextStyle(fontSize: 16),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            ),
            SizedBox(height: 30),
            Material(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text("Security Tips", style: TextStyle(fontSize: 19)),
                subtitle: Text("Security Tips", style: TextStyle(fontSize: 16)),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
