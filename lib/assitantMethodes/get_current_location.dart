import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../global/global.dart';



class UserLocation{


  Future<Position> _determinePosition() async {
    bool serviceEnabled ;
    LocationPermission permission ;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if( permission == LocationPermission.denied) {
      permission =await Geolocator.requestPermission();
      if(permission ==  LocationPermission.denied){
        return Future.error('Location permission are denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error("we cannot request permission");
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  getCurrentLocation() async{

    Position newPosition = await _determinePosition(

    );
    position = newPosition;
    placeMark = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    Placemark pMark = placeMark![0];

    completeAddress = '${pMark.subThoroughfare} ${pMark.thoroughfare},${pMark.subLocality} ${pMark.locality} , ${pMark.subAdministrativeArea} , ${pMark.administrativeArea} ${pMark.postalCode} , ${pMark.country} ';
  }
}

