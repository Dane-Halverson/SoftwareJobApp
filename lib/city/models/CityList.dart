import 'package:cloud_firestore/cloud_firestore.dart';

import 'CityData.dart';

class CityList {
  static Future<List<CityData>> getCities() async {
    List<CityData> cities = [];
    var citiesList = FirebaseFirestore.instance
        .collection('cities')
        .withConverter(fromFirestore:
            (DocumentSnapshot<Map<String, dynamic>> snapshot,
                SnapshotOptions? options) {
      final i = snapshot.data()!;
      return CityData(
          city: i['Metro'],
          meanSalaryAdjusted: i['Mean Software Developer Salary'],
          meanSalaryUnadjusted: i['Mean Unadjusted Salary'],
          numberOfSoftwareJobs: i['Number of Software Developer Jobs'],
          medianHomePrice: i['Median Home Price'],
          costOfLiving: i['Cost of Living avg'],
          rent: i['Rent avg'],
          purchasingPower: i['Local Purchasing Power avg']);
    }, toFirestore: (CityData city, _) {
      final Map<String, dynamic> map = {
        'Metro': city.city,
        'Mean Software Developer Salary': city.meanSalaryAdjusted,
        'Mean Unadjusted Salary': city.meanSalaryUnadjusted,
        'Number of Software Developer Jobs': city.numberOfSoftwareJobs,
        'Median Home Price': city.medianHomePrice,
        'Cost of Living avg': city.costOfLiving,
        'Rent avg': city.rent,
        'Local Purchasing Power avg': city.purchasingPower,
        'Cost of Living Plus Rent avg': city.costOfLiving + city.rent
      };
      return map;
    });

    final snapshot = await citiesList.get();
    for (var document in snapshot.docs) {
      final CityData city = document.data();
      cities.add(city);
    }

    return cities;
  }
}
