import 'package:flutter/material.dart';
import 'package:cinema_application/widgets/customappbar.dart';

class BookingSeats extends StatefulWidget {
  BookingSeats({super.key});

  @override
  State<BookingSeats> createState() => _BookingSeats();
}

class _BookingSeats extends State<BookingSeats> {
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  // List to manage selected seats
  List<List<bool>> seatStatus = List.generate(
    25, // rows
    (_) => List.generate(25, (_) => false), // columns, default to false
  );

  @override
  void initState() {
    super.initState();
    // Center the scroll view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _verticalController.jumpTo(_verticalController.position.minScrollExtent);
      _horizontalController.jumpTo(_horizontalController.position.maxScrollExtent / 2);
    });
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 167, 212, 203),
      appBar: CustomAppBar(centerText: 'Theater Name'),
      body: SingleChildScrollView(
        controller: _verticalController,
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          controller: _horizontalController,
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 26, 18, 4),
            child: 
            Column(
              children: <Widget>[
                Container(
                  width: 1100,
                  padding: const EdgeInsets.fromLTRB(18, 4, 18, 4),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 220),
                  decoration: BoxDecoration(
                    // color: const Color.fromARGB(255, 106, 149, 140),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: Colors.white70,
                      width: 2.8,
                    ),
                  ),
                  child: const Text(
                    "SCREEN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // seats generator
                for (int jindex = 0; jindex < 25; jindex++)
                  Row(
                    children: <Widget>[
                      for (int index = 0; index < 25; index++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // Toggle the seat selection
                              seatStatus[jindex][index] = !seatStatus[jindex][index];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(6),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: seatStatus[jindex][index]
                                  ? Color.fromARGB(255, 255, 196, 64) // Selected seat color
                                  : Color.fromARGB(255, 245, 240, 224), // Default seat color
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: Colors.black,
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'A',
                                style: TextStyle(
                                  color: seatStatus[jindex][index]
                                      ? Colors.black // Text color for selected seats
                                      : Colors.black, // Text color for unselected seats
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
