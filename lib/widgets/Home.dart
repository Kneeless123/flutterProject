import 'package:flutter/material.dart';

class Complaint {
  String title;
  String description;
  String status;
  String date;

  Complaint({
    required this.title,
    required this.description,
    required this.status,
    required this.date,
  });
}

List<Complaint> complaints = [
  Complaint(
    title: "Water Problem",
    description: "No water in Room 101",
    status: "Pending",
    date: "19-05-2026",
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hostel Complaint",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [

            // TOP ROW
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [

                const Text(
                  "Complaints",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/add',
                    ).then((value) {
                      setState(() {});
                    });
                  },

                  icon: const Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
              ],
            ),

            

            const SizedBox(height: 10),

            // LIST
            Expanded(
              child: ListView.builder(
                itemCount: complaints.length,

                itemBuilder: (context, index) {

                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.only(
                      bottom: 10,
                    ),

                    child: Padding(
                      padding:
                          const EdgeInsets.all(10),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          // TITLE
                          Text(
                            complaints[index].title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // DESCRIPTION
                          Text(
                            complaints[index]
                                .description,
                          ),

                          const SizedBox(height: 8),

                          // STATUS
                          Row(
                            children: [

                              const Text(
                                "Status : ",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              Text(
                                complaints[index]
                                    .status,
                                style: const TextStyle(
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          // DATE
                          Row(
                            children: [

                              const Text(
                                "Date : ",
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              Text(
                                complaints[index]
                                    .date,
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // BUTTONS
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.end,

                            children: [

                              // EDIT
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/edit',
                                    arguments: index,
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },

                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),

                              // DELETE
                              IconButton(
                                onPressed: () {

                                  setState(() {
                                    complaints
                                        .removeAt(
                                            index);
                                  });
                                },

                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}