import 'package:cinema_application/data/helpers/sharedprefsutil.dart';
import 'package:flutter/material.dart';

import 'package:cinema_application/data/helpers/apihelper.dart';
import 'package:cinema_application/widgets/searchfield.dart';
import 'package:flutter_svg/svg.dart';

class LocationPanel extends StatefulWidget {
  final Function(String) onSelect;

  const LocationPanel({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<LocationPanel> createState() => _LocationPanelState();
}

class _LocationPanelState extends State<LocationPanel> {
  String selectedLocation = '-';

  final apiHelper = ApiHelper();
  final TextEditingController _controller = TextEditingController();

  bool _isEmptyText = true;
  List<dynamic>? allLocations;
  List<dynamic> filteredLocation = [];

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final query = _controller.text.toLowerCase();
      final isQueryEmpty = query.isEmpty;

      if (isQueryEmpty != _isEmptyText) {
        setState(() {
          _isEmptyText = isQueryEmpty;
        });
      }

      setState(() {
        if (!isQueryEmpty && allLocations != null) {
          filteredLocation = allLocations!.where((location) {
            return location['c_name'].toLowerCase().startsWith(query);
            // location['c_name], karena value dari db bentuknya list dari maps, bukan raw values (harus ada key berarti)
          }).toList();
        } else {
          filteredLocation = [];
        }
      });
    });
  }

  Future<List<dynamic>> _fetchLocations() async {
    try {
      final locationRows = await apiHelper.getListofLocation();
      allLocations = locationRows;
      return locationRows;
    } catch (e) {
      throw Exception('Failed to fetch locations.');
    }
  }

  Future<void> _handleLocationSelection(String location) async {
    setState(() {
      selectedLocation = location;
    });
    await LocationService.saveLocation(location);
    widget.onSelect(location);
    Navigator.pop(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
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

            // Search Field, duhh
            SearchField(
              controller: _controller,
              isEmptyText: _isEmptyText,
              suffixIcon: _isEmptyText,
            ),

            SizedBox(height: 0),

            // Builder of Cities
            Expanded(
              child: allLocations == null
                  ? FutureBuilder<List<dynamic>>(
                      future: _fetchLocations(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              'Please ensure network is nvailable',
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF0E2522),
                              )
                            )
                          );
                        } else {
                          allLocations = snapshot.data!;
                          return _buildLocationList();
                        }
                      },
                    )
                  : _buildLocationList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationList() {
    // if there is no query sent by user
    if (_isEmptyText) {
      return ListView.builder(
        itemCount: allLocations!.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              allLocations![index]['c_name'],
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0E2522),
              ),
            ),
            onTap: () {
              _handleLocationSelection(allLocations![index]['c_name']);
            },
          );
        },
      );
    }

    // if the city not found
    if (filteredLocation.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icon/not_found.svg',
              height: 120,
            ),
            const SizedBox(height: 16),
            Text(
              "We Are Sorry, We Can Not Find '${_controller.text}' :(",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Double check your search word spelling, or try another word",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      itemCount: filteredLocation.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            filteredLocation[index]['c_name'],
            style: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0E2522),
            ),
          ),
          onTap: () {
            _handleLocationSelection(allLocations![index]['c_name']);
          },
        );
      },
    );
  }
}