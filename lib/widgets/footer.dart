import 'package:flutter/material.dart';
import 'Home.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    int totalComplaints = complaints.length;

    int pendingComplaints = complaints
        .where((c) => c.status == "Pending")
        .length;

    return BottomNavigationBar(

      currentIndex: currentIndex,

      onTap: (index) {

        setState(() {
          currentIndex = index;
        });

        // HOME
        if (index == 0) {
          Navigator.pushNamed(context, '/');
        }

        // ADD COMPLAINT
        else if (index == 1) {
          Navigator.pushNamed(context, '/add');
        }

        // PROFILE
        else if (index == 2) {

          showDialog(
            context: context,

            builder: (context) {

              return AlertDialog(

                title: const Text(
                  "Student Profile",
                ),

                content: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                    const CircleAvatar(
                      radius: 35,
                      child: Icon(
                        Icons.person,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Aum Nanji",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      "Total Complaints : $totalComplaints",
                    ),

                    Text(
                      "Pending : $pendingComplaints",
                    ),
                  ],
                ),

                actions: [

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      "Close",
                    ),
                  ),
                ],
              );
            },
          );
        }
      },

      items: const [

        // HOME
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),

        // ADD
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          label: "Add",
        ),

        // PROFILE
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}