import 'CityData.dart';

class CityList {
  
  final List<CityData> cities = [];
  
  CityList() {
    cities.add(
      CityData(city: "Columbus, OH",
          meanSalaryAdjusted: 117552,
          meanSalaryUnadjusted: 108500,
          meanSalaryAllOccupations: 51260,
          numberOfSoftwareJobs: 13430,
          medianHomePrice: 192000,
          costOfLiving: 984.8,
          rent: 1421.5,
          purchasingPower: 9335.4)
    );
  }
  
}