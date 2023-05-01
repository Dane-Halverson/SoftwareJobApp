import 'package:cloud_firestore/cloud_firestore.dart';

import 'CityData.dart';

class CityList {
  

  static Future<List<CityData>> getCities() async {
    List<CityData> cities = [];
    var citiesList = FirebaseFirestore.instance.collection('cities');
    var snap = await citiesList.get();
    for (var i in snap.docs) {
      cities.add(CityData(
          city: i.get('Metro'),
          meanSalaryAdjusted: i.get('Mean Software Developer Salary'),
          meanSalaryUnadjusted: i.get('Mean Unadjusted Salary'),
          numberOfSoftwareJobs: i.get('Number of Software Developer Jobs'),
          medianHomePrice: i.get('Median Home Price'),
          costOfLiving: i.get('Cost of Living avg'),
          rent: i.get('Rent avg'),
          purchasingPower: i.get('Local Purchasing Power avg')
      ));
    }
    return cities;
  }

  
}