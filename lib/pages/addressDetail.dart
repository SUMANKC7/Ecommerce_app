import 'package:flutter/material.dart';

class Addressdetail extends StatelessWidget {
  const Addressdetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Shipping Address")),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailAddress()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.07,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add address", style: TextStyle(fontSize: 17)),
                    SizedBox(width: 5),
                    Icon(Icons.add, size: 26),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.1,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Suman KC"), Text("Mobile no")],
                  ),
                  Text("Address"),
                  Text("Home"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailAddress extends StatelessWidget {
  const DetailAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Shipping Address")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 11, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recipient's Name"),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Input the real name",
                  hintStyle: TextStyle(color: Colors.grey),
                  errorText: "Please enter name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text("Phone Number"),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Please input Phone Number",
                  hintStyle: TextStyle(color: Colors.grey),
                  errorText: "Number is incorrect",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text("City/District"),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Please input City/District",
                  errorText: "Please enter address",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text("Address"),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "House no/building/street/area",
                  hintStyle: TextStyle(color: Colors.grey),
                  errorText: "Please enter address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 244, 107, 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: Size(
                    MediaQuery.sizeOf(context).width * 1,
                    MediaQuery.sizeOf(context).height * 0.06,
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
