import 'package:cloud_firestore/cloud_firestore.dart';

class CityData {

  final String city;
  final double meanSalaryAdjusted;
  final double meanSalaryUnadjusted;
  final double numberOfSoftwareJobs;
  final double medianHomePrice;
  final double costOfLiving;
  final double rent;
  final double purchasingPower;

  CityData({
    required this.city,
    required this.meanSalaryAdjusted,
    required this.meanSalaryUnadjusted,
    required this.numberOfSoftwareJobs,
    required this.medianHomePrice,
    required this.costOfLiving,
    required this.rent,
    required this.purchasingPower,
  });


}

Future<Map<String, List<CityData>>> mapCitiesToState() async {
  final cities = FirebaseFirestore.instance.collection('cities');
  final citiesSnapshot = await cities.get();
  final Map<String, List<CityData>> citiesToStateMap = {};

  for (final doc in citiesSnapshot.docs) {
    final data = doc.data();
    final cityName = doc.id.split(',')[0];
    final state = doc.id.split(',')[1].trim();
    final cityData = CityData(
        city: cityName,
        meanSalaryAdjusted: data['Mean Software Developer Salary'],
        meanSalaryUnadjusted: data['Mean Unadjusted Salary'],
        numberOfSoftwareJobs: data['Number Of Software Developer Jobs'],
        medianHomePrice: data['Median Home Price'],
        costOfLiving: data['Cost of Living avg'],
        rent: data['Rent avg'],
        purchasingPower: data['Local Purchasing Power avg']
    );

    if (citiesToStateMap.containsKey(state)) {
      citiesToStateMap[state]?.add(cityData);
    }
    else {
      final stateCities = <CityData>[];

      stateCities.add(cityData);
      citiesToStateMap[state] = stateCities;
    }
  }

  return citiesToStateMap;
}