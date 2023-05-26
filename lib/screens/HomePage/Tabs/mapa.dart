
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mapa extends StatefulWidget {
  const mapa({Key? key}) : super(key: key);

  @override
  State<mapa> createState() => _MapaState();
}

class _MapaState extends State<mapa> {
  Position? _currentPosition;
  final MapController _mapController = MapController.withPosition(
    initPosition: GeoPoint(
      latitude: 0,
      longitude: 0,

    ),
  );
  List<GeoPoint> _markers = []; // Lista para almacenar los marcadores
  GeoPoint? _nearestMarker;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
    _loadMarkers();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Los servicios de ubicación están deshabilitados. Habilite los servicios.'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Los permisos de ubicación están denegados')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Los permisos de ubicación se niegan permanentemente, no podemos solicitar permisos.'),
        ),
      );
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    final prefs = await SharedPreferences.getInstance();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  void _loadMarkers() {
    _markers = [
      GeoPoint(latitude: 19.474180976330988, longitude: -99.04588082060995),
      // fes aragon
      GeoPoint(latitude: 19.398269, longitude: -99.052546),
      // San Juan
      GeoPoint(latitude: 19.444123, longitude: -99.151972),
      // cultural del chopo
      GeoPoint(latitude: 19.432774, longitude: -99.133473),
      // Antiguedades
      GeoPoint(latitude: 19.352780, longitude: -99.159232),
      // Coyoacan
      GeoPoint(latitude: 19.408966, longitude: -99.123685),
      // Jamaica
      GeoPoint(latitude: 19.449525, longitude: -99.161501),
      // Santa Maria la Ribera
      GeoPoint(latitude: 19.443121, longitude: -99.127647),
      // Tepito
      GeoPoint(latitude: 19.390545, longitude: -99.163119),
      // Portales
      GeoPoint(latitude: 19.471177, longitude: -99.138652),
      // La Raza
      // Agrega más marcadores aquí...
    ];

    for (var marker in _markers) {
      _mapController.addMarker(marker);
    }
  }

  void _findNearestMarker() {
    if (_currentPosition != null) {
      double minDistance = double.infinity;
      GeoPoint? nearestMarker;

      for (var marker in _markers) {
        double distance = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          marker.latitude,
          marker.longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          nearestMarker = marker;
        }
      }

      setState(() {
        _nearestMarker = nearestMarker;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 350, // Establece un ancho específico
            height: 500, // Establece una altura específica
            child: OSMFlutter(
              controller: _mapController,
              trackMyPosition: true,
              initZoom: 15,
              minZoomLevel: 2,
              maxZoomLevel: 19,
              stepZoom: 1.0,
            ),
          ),
          SizedBox(height: 19),
          if (_nearestMarker != null)
            Text(
              'Tianguis más cercano: (${_nearestMarker!
                  .latitude}, ${_nearestMarker!.longitude})',
              style: TextStyle(fontSize: 16),
            ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          onPressed: _findNearestMarker,
          child: Icon(Icons.location_on_outlined),
        ),
      ),
    );
  }
}