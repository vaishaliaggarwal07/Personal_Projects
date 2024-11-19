import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitor_application/editInfo.dart';
import 'package:visitor_application/visitorInfo.dart';
import 'navbar.dart';
import 'visitor.dart';
import 'package:http/http.dart' as http;

class VisitorsListPage extends StatefulWidget {
  const VisitorsListPage({super.key});

  @override
  State<VisitorsListPage> createState() => _VisitorsListPageState();
}

class _VisitorsListPageState extends State<VisitorsListPage> {
  Future<List<Visitor>>? _visitorsFuture;
  List<Visitor> filteredtVisitorsList = [];
  DateTimeRange? selectedDateRange;
  String dropdownValue = 'All';
  @override
  void initState() {
    super.initState();
    _visitorsFuture = fetchVisitors();
  }

  Future<List<Visitor>> fetchVisitors() async {
    final apiUrl = Uri.parse('http://20.55.109.32:80/all_visitor');
    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      List<Visitor> updatedList =
          jsonData.map((item) => Visitor.fromJson(item)).toList();
      updatedList.sort((a, b) => b.visit_date.compareTo(a.visit_date));
      return updatedList;
    } else {
      throw Exception('Error fetching visitors from the server.');
    }
  }

  List<Visitor> filterActiveVisitors(List<Visitor> visitors) {
    return visitors.where((visitor) => visitor.status_visitor).toList();
  }

  List<Visitor> filterInactiveVisitors(List<Visitor> visitors) {
    return visitors.where((visitor) => !visitor.status_visitor).toList();
  }

  List<Visitor> filterVisitorsByDate(List<Visitor> visitors) {
    if (selectedDateRange == null) {
      return visitors;
    }

    return visitors.where((visitor) {
      final visitDate = DateTime.parse(visitor.visit_date);
      return selectedDateRange!.start.isBefore(visitDate) &&
          selectedDateRange!.end.isAfter(visitDate);
    }).toList();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final initialDateRange = selectedDateRange ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now(),
        );
    final pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialDateRange: initialDateRange,
    );

    if (pickedDateRange != null) {
      setState(() {
        selectedDateRange = pickedDateRange;
      });
    }
  }

  Future<void> fetchAndUpdateVisitorsList() async {
    setState(() {
      _visitorsFuture = fetchVisitors();
    });
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;

    List<String> words = input.split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalizedWord =
            word[0].toUpperCase() + word.substring(1).toLowerCase();
        capitalizedWords.add(capitalizedWord);
      }
    }

    return capitalizedWords.join(' ');
  }

  Future<ImageProvider> _fetchVisitorImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return MemoryImage(response.bodyBytes);
    } else {
      return AssetImage(
          'assets/default_avatar.png'); // Replace with your default avatar image
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFF6e5), Color(0xFFF39D23)],
        )),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            drawer: Navbar(),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                toolbarHeight: 100,
                backgroundColor: Colors.transparent,
                title: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.cover,
                  // height: 500,
                  width: 200,
                ),
              ),
            ),
            body: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              bool isTablet = constraints.maxWidth > 600;
              return SingleChildScrollView(
                child: FutureBuilder<List<Visitor>>(
                  future: _visitorsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Display loading indicator
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error loading visitors data'); // Display error message
                    } else if (snapshot.hasData) {
                      List<Visitor> visitorsList = snapshot.data!;
                      List<Visitor> displayList =
                          filteredtVisitorsList.isNotEmpty
                              ? filteredtVisitorsList
                              : filterVisitorsByDate(visitorsList);

                      return Column(children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Visitor List',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color(0xFFFE4C2D),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Divider(
                          color: Color(0xFFF39D23),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: TextField(
                                        onChanged: (value) async {
                                          setState(() {
                                            filteredtVisitorsList = visitorsList
                                                .where((visitor) => visitor
                                                    .visitor_name
                                                    .toLowerCase()
                                                    .contains(
                                                        value.toLowerCase()))
                                                .toList();

                                            displayList =
                                                filteredtVisitorsList.isNotEmpty
                                                    ? filteredtVisitorsList
                                                    : visitorsList;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Name',
                                          labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFFA2A2A2),
                                              fontFamily: 'Roboto'),
                                          prefixIcon: Icon(Icons.search,
                                              color: Color(0xFFFE4C2D),
                                              size: 15),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Color(0xFFFE4C2D))),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                              color: Color(
                                                  0xFFFE4C2D), // Change the focused border color here
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Color(0xFFFE4C2D)
                                                // Change the enabled border color here
                                                ),
                                          ),
                                        ),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            color: Color(0xFFA2A2A2)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                    child: ElevatedButton(
                                      onPressed: () =>
                                          _selectDateRange(context),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                              color: Color(0xFFF39D23),
                                              width: 0.3),
                                        ),
                                      ),
                                      child: Text(
                                        'Select Date Range',
                                        style: TextStyle(
                                          color: Color(0xFFFE4C2D),
                                          fontFamily: 'Roboto',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color(0xFFF39D23),
                                          width: 0.3,
                                        ),
                                      ),
                                      height: 30,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: DropdownButton<String>(
                                          value: dropdownValue,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          iconSize: 15,
                                          elevation: 16,

                                          style: TextStyle(
                                              color: Color(
                                                0xFFFE4C2D,
                                              ),
                                              fontFamily: 'Roboto',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                          iconEnabledColor: Color(
                                              0xFFFE4C2D), // Dropdown icon color
                                          focusColor: Colors.transparent,
                                          underline: Container(
                                            // To remove the underline
                                            height: 0,
                                            color: Colors.transparent,
                                          ),
                                          onChanged: (String? newValue) async {
                                            setState(() {
                                              dropdownValue = newValue!;

                                              if (dropdownValue == 'All') {
                                                filteredtVisitorsList =
                                                    visitorsList;
                                              } else if (dropdownValue ==
                                                  'Active') {
                                                filteredtVisitorsList =
                                                    filterActiveVisitors(
                                                        visitorsList);
                                              } else if (dropdownValue ==
                                                  'Inactive') {
                                                filteredtVisitorsList =
                                                    filterInactiveVisitors(
                                                        visitorsList);
                                              }
                                            });
                                          },
                                          items: <String>[
                                            'All',
                                            'Active',
                                            'Inactive'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(value),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(17, 10, 17, 0),
                          child: TextButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12)),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                  TextStyle(
                                      color: Color(0xFF7E7E7E),
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Roboto',
                                      fontSize: 13)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(width: 10, child: Text('id')),
                                  SizedBox(
                                    width: 90,
                                    child: Text('Name',
                                        style: TextStyle(
                                            color: Color(0xFF7E7E7E))),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Text('Email',
                                        style: TextStyle(
                                            color: Color(0xFF7E7E7E))),
                                  ),
                                  SizedBox(
                                    width: 52,
                                    child: Text('Date',
                                        style: TextStyle(
                                            color: Color(0xFF7E7E7E))),
                                  ),
                                  SizedBox(
                                      width: 42,
                                      child: Text('Status',
                                          style: TextStyle(
                                              color: Color(0xFF7E7E7E)))),
                                  // SizedBox(
                                  //   width: 20,
                                  // )
                                ],
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: displayList.length,
                          itemBuilder: (context, index) {
                            Visitor visitor = displayList[index];
                            bool isVisitorCheckedut = visitor.status_visitor;
                            TextStyle visitorTextStyle = TextStyle(
                                color: isVisitorCheckedut
                                    ? Color.fromRGBO(254, 76, 45, 1)
                                    : Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Roboto',
                                fontSize: 13);
                            Color statusColor = visitor.status_visitor
                                ? Colors.green
                                : Colors.red;

                            DateTime visitDate = DateTime.parse(
                                visitor.visit_date); // Parse the date string
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(visitDate);
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(17, 2, 17, 0),
                              child: TextButton(
                                onPressed: isVisitorCheckedut
                                    ? () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VisitorsInfo(
                                              visitor: visitor,
                                              fetchAndUpdateVisitorsList:
                                                  fetchAndUpdateVisitorsList,
                                            ),
                                          ),
                                        );
                                        initState();
                                      }
                                    : () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VisitorsInfo(
                                              visitor: visitor,
                                              fetchAndUpdateVisitorsList:
                                                  fetchAndUpdateVisitorsList,
                                            ),
                                          ),
                                        );
                                        initState();
                                      },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty
                                      .all<Color>(isVisitorCheckedut
                                          ? Colors.white
                                          : Color.fromARGB(255, 239, 236, 236)),
                                  textStyle:
                                      MaterialStateProperty.all<TextStyle>(
                                          visitorTextStyle),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      FutureBuilder<ImageProvider>(
                                          future: _fetchVisitorImage(
                                              visitor.image_url),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Icon(Icons.error);
                                            } else {
                                              return CircleAvatar(
                                                radius: 15,
                                                backgroundImage: snapshot.data,
                                              );
                                            }
                                          }),
                                      SizedBox(
                                          width: 50,
                                          child: Text(
                                            capitalizeFirstLetter(
                                                visitor.visitor_name),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: isVisitorCheckedut
                                                  ? Color.fromRGBO(
                                                      254, 76, 45, 1)
                                                  : Colors.black,
                                            ),
                                          )),
                                      SizedBox(
                                          width: 100,
                                          child: Text(visitor.visitor_email,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: isVisitorCheckedut
                                                    ? Color.fromRGBO(
                                                        254, 76, 45, 1)
                                                    : Colors.black,
                                              ))),
                                      SizedBox(
                                          width: 70,
                                          child: Text(formattedDate,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: isVisitorCheckedut
                                                    ? Color.fromRGBO(
                                                        254, 76, 45, 1)
                                                    : Color.fromARGB(
                                                        255, 59, 57, 57),
                                              ))),
                                      SizedBox(
                                          width: 40,
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: 3,
                                              backgroundColor: statusColor,
                                            ),
                                          )),
                                      // if (!isVisitorCheckedut)
                                      //   SizedBox(
                                      //     width: 38,
                                      //   ),
                                      if (isVisitorCheckedut)
                                        if (isTablet)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                1, 0, 2, 0),
                                            child: SizedBox(
                                              width: 8,
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 15.0,
                                                    color: Color(0xFFFE4C2D),
                                                  ),
                                                  tooltip: 'Edit',
                                                  onPressed: isVisitorCheckedut
                                                      ? () async {
                                                          final updatedVisitor =
                                                              await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => EditVisitor(
                                                                            visitor:
                                                                                visitor,
                                                                          )));

                                                          if (updatedVisitor !=
                                                              null) {
                                                            setState(() {
                                                              for (int i = 0;
                                                                  i <
                                                                      visitorsList
                                                                          .length;
                                                                  i++) {
                                                                if (visitorsList[
                                                                            i]
                                                                        .id ==
                                                                    updatedVisitor
                                                                        .id) {
                                                                  visitorsList[
                                                                          i] =
                                                                      updatedVisitor;
                                                                  break;
                                                                }
                                                              }
                                                            });
                                                          }
                                                          initState();
                                                        }
                                                      : null),
                                            ),
                                          ),
                                      if (isVisitorCheckedut)
                                        if (isTablet)
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                1, 0, 2, 0),
                                            child: SizedBox(
                                              width: 8,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 15.0,
                                                  color: Color(0xFFFE4C2D),
                                                ),
                                                tooltip: 'Delete',
                                                onPressed: isVisitorCheckedut
                                                    ? () async {}
                                                    : null,
                                              ),
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ]);
                    } else {
                      return Text('no visitors data available');
                    }
                  },
                ),
              );
            })));
  }
}
