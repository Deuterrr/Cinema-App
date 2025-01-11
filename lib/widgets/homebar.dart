import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinema_application/data/helpers/apihelper.dart';
import 'package:cinema_application/domain/controllers/auth_controller.dart';
import 'package:cinema_application/pages/flows/booking/searchpage.dart';
import 'package:cinema_application/widgets/searchfield.dart';

class HomeBarButton extends StatefulWidget implements PreferredSizeWidget {
  const HomeBarButton({super.key});

  @override
  State<HomeBarButton> createState() => HomeBarButtonState();

  @override
  Size get preferredSize => Size.fromHeight(65.0);
}

class HomeBarButtonState extends State<HomeBarButton> {
  final TextEditingController _controller = TextEditingController();
  bool _isEmptyText = true;
  List<dynamic> filteredLocation = [];
  
  final apiHelper = ApiHelper();

  @override
  void initState() {
    super.initState();
    _initializeLocations();

    _controller.addListener(() {
      final query = _controller.text.toLowerCase();
      final isQueryEmpty = query.isEmpty;

      if (isQueryEmpty != _isEmptyText) {
        setState(() {
          _isEmptyText = isQueryEmpty;
        });
      }

      if (!isQueryEmpty) {
        _searchLocations(query);
      } else {
        setState(() {
          filteredLocation = [];
        });
      }
    });
  }

  // Initialize locations by fetching from API
  Future<List> _initializeLocations() async {
    try {
      final allLocations = await apiHelper.getListofLocation();
      setState(() {
        filteredLocation = allLocations;
      });
      return filteredLocation;
    } catch (e) {
      print('Error fetching locations: $e');
      return [];
    }
  }

  Future<void> _searchLocations(String query) async {
    try {
      setState(() {
        filteredLocation = filteredLocation.where((location) {
          return location['location_name'].toLowerCase().startsWith(query);
        }).toList();
      });
    } catch (e) {
      print('Error filtering locations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SafeArea(
          child: Container(
            height: widget.preferredSize.height,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: const Color(0xFF94CBC0), // Tosca
              border: const Border(
                bottom: BorderSide(
                  color: Color(0xFF0E2522), // Black
                  width: 1.2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Text(
                  'Cinema Scope',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0E2522), // Black
                  ),
                ),

                // Icons Container
                Row(
                  children: [
                    // Location Icon
                    _buildIconButton(
                      icon: Icons.location_on_outlined,
                      onPressed: () => locationPanel(context),
                    ),

                    SizedBox(width: 6),

                    // Search Icon
                    _buildIconButton(
                      icon: Icons.search_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage())
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper function to build IconButtons
  Widget _buildIconButton({required IconData icon, required VoidCallback onPressed}) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: const Color(0xFFFEC958), // Orange
        border: Border.all(
          color: const Color(0xFF0E2522), // Black
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1.4, 1.8),
            color: Color(0xFF0E2522).withOpacity(1),
          ),
        ],
      ),
      child: IconButton(
        iconSize: 19,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: const Color(0xFF0E2522), // Black
        ),
      ),
    );
  }

  // Show the location panel with a blurred background
  void locationPanel(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BlurredDialog",
      transitionDuration: Duration(milliseconds: 190),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            // Static blur background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 3.0),
                child: Container(
                  color: Color(0xFFFFFFFF).withOpacity(0.35),
                ),
              ),
            ),

            // The Panel
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1),
                  end: Offset(0, 0),
                ).animate(CurvedAnimation(
                  parent: anim1,
                  curve: Curves.easeOut,
                )),
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(
                        color: const Color(0xFF0E2522),
                        width: 1.2,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Close Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEC958),
                                border: Border.all(
                                  color: Color(0xFF0E2522),
                                  width: 1.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(1.4, 1.8),
                                    color: Color(0xFF0E2522).withOpacity(1),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: Icon(Icons.close),
                                iconSize: 21,
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                          ],
                        ),

                        // Title and SearchField
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Pick your location",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0E2522),
                            ),
                          ),
                        ),

                        SizedBox(height: 4),

                        // just see the name
                        SearchField(
                          controller: _controller,
                          isEmptyText: _isEmptyText,
                          suffixIcon: _isEmptyText,
                        ),

                        SizedBox(height: 0),

                        // List of Cities
                        Expanded(
                          child: FutureBuilder<List<dynamic>>(
                            future: _initializeLocations(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return Center(child: Text('No locations available.'));
                              } else {
                                final cities = snapshot.data!;
                                return ListView.builder(
                                  itemCount: cities.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                        cities[index]['c_name'],
                                        style: const TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF0E2522),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
