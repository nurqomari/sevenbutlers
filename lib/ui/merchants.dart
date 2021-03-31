import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:sevenbutlers/domain/merchant.dart';
import 'package:sevenbutlers/utils/services/app_url.dart';

class MapWidget extends StatefulWidget {
  // final RouteArgument routeArgument;
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  MapWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  CameraPosition cameraPosition = new CameraPosition(
    target: LatLng(-7.23333, 112.73333),
    zoom: 15,
  );

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = <Marker>[];
  var currentAddress = '';
  TextEditingController searchController = TextEditingController();
  PlacesSearch placesSearch;
  List<MapBoxPlace> placePred = [];
  MapBoxPlace mapboxPredictions;
  dynamic lat;
  dynamic lng;

  Future<void> _goToLocation(lat, lng) async {
    setState(() {
      allMarkers.clear();
    });
    final CameraPosition _kLake = CameraPosition(
        // bearing: 192.8334901395799,
        target: LatLng(lat, lng),
        // tilt: 59.440717697143555,
        zoom: 15);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    List<Map> listMerchant = await getMerchants();
    for (var merchant in listMerchant) {
      Merchant data = Merchant.parse(merchant);
      Marker marker = await getMarker(data.toMap());
      setState(() {
        allMarkers.add(marker);
      });
    }
  }

  void _getLocation(BuildContext context, {locale = 'nl'}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      bool isLocationServiceEnableds =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnableds) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        Timer(Duration(seconds: 5), () async {
          double lat = position.latitude;
          double lng = position.longitude;
          // prefs.setString("lat", lat.toStringAsFixed(8));
          // prefs.setString("lng", lng.toStringAsFixed(8));
          final coordinates = new Coordinates(lat, lng);
          await Geocoder.local
              .findAddressesFromCoordinates(coordinates)
              .then((value) {
            setState(() {
              currentAddress = value[0].addressLine;
            });
          });
          _goToLocation(lat, lng);
        });
      } else {
        await Geolocator.openLocationSettings().then((value) {
          if (value) {
            _getLocation(context, locale: locale);
          } else {
            // Toast.show(locale.locpermission, context,
            //     duration: Toast.LENGTH_SHORT);
          }
        }).catchError((e) {
          // Toast.show(locale.locpermission, context,
          //     duration: Toast.LENGTH_SHORT);
        });
      }
    } else if (permission == LocationPermission.denied) {
      LocationPermission permissiond = await Geolocator.requestPermission();
      if (permissiond == LocationPermission.whileInUse ||
          permissiond == LocationPermission.always) {
        _getLocation(context, locale: locale);
      } else {
        // Toast.show(locale.locpermission, context, duration: Toast.LENGTH_SHORT);
      }
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings().then((value) {
        _getLocation(context, locale: locale);
      }).catchError((e) {
        // Toast.show(locale.locpermission, context, duration: Toast.LENGTH_SHORT);
      });
    }
  }

  static Future<Marker> getMarker(Map<String, dynamic> res) async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/marker.png', 120);
    final Marker marker = Marker(
        markerId: MarkerId(res['id'].toString()),
        icon: BitmapDescriptor.fromBytes(markerIcon),
//        onTap: () {
//          //print(res.name);
//        },
        anchor: Offset(0.5, 0.5),
        infoWindow: InfoWindow(
          title: res['name'],
          snippet: res['distance'].toStringAsFixed(1).toString() + ' meters',
          // onTap: () {
          //   print(CustomTrace(StackTrace.current, message: 'Info Window'));
          // }
        ),
        position: LatLng(res['latitude'], res['longitude']));

    return marker;
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<List<Map>> getMerchants() async {
    final Map<String, dynamic> data = {
      "latitude": 52.03518600000000304817,
      "longitude": 4.32757300000000011408,
      "zip_code": ["2288 DC"],
      "city": "",
      "street": "",
      "merchant_name": "",
      "delivery_option": 2,
      "filter": {"cuisines": [], "distance": 1000, "page": 1, "page_size": 10},
      "order": {"by_preparation_time": true, "by_price": true}
    };

    var dio = new Dio();
    // try {
    Response response = await dio.post(AppUrl.merchants,
        data: data, options: new Options(contentType: Headers.jsonContentType));

    if (response.data["status"] == "Success") {
      List<Map> data = new List<Map>();
      for (var merchant in response.data["data"]["list"]) {
        data.add(merchant);
      }
      // datas.forEach((element) {
      //   Merchant data = Merchant.parse(element);
      //   _list.add(data);
      // });
      // for (var merchant in response.data["data"]["list"]) {
      // Merchant data = Merchant.parse(merchant);
      //   _list.add(data);
      // }
      return data;
    } else {
      return null;
    }
    // } catch (e) {
    //   return null;
    // }
  }

  // void setMapBoxKey() async {
  //   http.get(mapboxUri).then((value) {
  //     if (value.statusCode == 200) {
  //       MapBoxApiKey googleMapD = MapBoxApiKey.fromJson(jsonDecode(value.body));
  //       if ('${googleMapD.status}' == '1') {
  //         setState(() {
  //           placesSearch = PlacesSearch(
  //             apiKey: '${googleMapD.data.mapboxApi}',
  //             country: 'id',
  //             limit: 15,
  //           );
  //         });
  //       }
  //     }
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }).catchError((e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      placesSearch = PlacesSearch(
        apiKey:
            'pk.eyJ1IjoibnVycW9tYXJpIiwiYSI6ImNrbW85dHd0dzIyZDcyd3FvNm9ucXZmbnQifQ.QLzoDVLLJeMhpZiLOe3IdA',
        country: 'nl',
        limit: 5,
      );
    });
    searchController.addListener(() async {
      if (searchController.text != null && searchController.text.length > 0) {
        if (placesSearch != null) {
          placesSearch.getPlaces(searchController.text).then((value) {
            if (searchController.text != null &&
                searchController.text.length > 0) {
              setState(() {
                placePred.clear();
                placePred = List.from(value);
                print(value[0].placeName);
                print(
                    '${value[0].geometry.coordinates[0]} ${value[0].geometry.coordinates[1]}');
              });
            } else {
              setState(() {
                placePred.clear();
              });
            }
          }).catchError((e) {
            setState(() {
              placePred.clear();
            });
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: new Icon(Icons.arrow_back, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'maps',
          style: Theme.of(context)
              .textTheme
              .headline6
              .merge(TextStyle(letterSpacing: 1.3)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.my_location,
              color: Theme.of(context).hintColor,
            ),
            onPressed: () {
              _getLocation(context);
            },
          ),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          GoogleMap(
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: cameraPosition,
            markers: Set.from(allMarkers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onCameraMove: (CameraPosition cameraPosition) {
              // _con.cameraPosition = cameraPosition;
            },
            onCameraIdle: () {
              // _con.getRestaurantsOfArea();
            },
          ),
          Positioned(
              top: 10,
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter Zip Code",
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: EdgeInsets.only(
                          top: 2,
                          left: 10, // HERE THE IMPORTANT PART
                        )),
                    controller: searchController,
                  ),
                ),
                Visibility(
                  visible: (placePred != null && placePred.length > 0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    // color: kWhiteColor,
                    height: 300,
                    margin: EdgeInsets.only(top: 0),
                    padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                    child: ListView.builder(
                      itemCount: placePred.length,
                      shrinkWrap: true,
                      primary: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              mapboxPredictions = placePred[index];
                              lng = mapboxPredictions.geometry.coordinates[0];
                              lat = mapboxPredictions.geometry.coordinates[1];
                              searchController.clear();
                              placePred.clear();
                            });
                            _goToLocation(lat, lng);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/map_pin.png',
                                  scale: 3,
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                Expanded(
                                  child: Text(
                                    '${placePred[index].placeName}',
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.caption,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      // separatorBuilder: (context, index) {
                      //   return Divider(
                      //     thickness: 1,
                      //     color: Colors.grey,
                      //   );
                      // },
                    ),
                  ),
                ),
              ]))
        ],
      ),
    );
  }
}
