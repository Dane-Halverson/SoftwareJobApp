import 'package:flutter/material.dart';
import 'CityData.dart';
import 'CityList.dart';
import 'CostEstimates.dart';

class CostEstimatorView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CostEstimatorStatefulWidget(key: super.key,),
    );
  }
}

class CostEstimatorStatefulWidget extends StatefulWidget{
  const CostEstimatorStatefulWidget({super.key});

  @override
  State<CostEstimatorStatefulWidget> createState() => _CostEstimatorStatefulWidgetState();

}

class _CostEstimatorStatefulWidgetState extends State<CostEstimatorStatefulWidget>{
  final TextEditingController _searchController = TextEditingController();
  final CityList _cities = CityList();
  final List<CityData> _match = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(onSearch);
    _match.addAll(_cities.cities);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              icon: Icon(Icons.search_rounded)
            ),
          ),
        ),
        Expanded(child: ListView(
          children: List<Widget>.generate(_match.length, (index) {
            return Padding(padding: EdgeInsets.all(10),
              child: Card(
                child: Column(
                  children: [
                    Text(_match[index].city),
                    Text(CostEstimator.esitmateRent(
                        costOfLiving: _match[index].costOfLiving,
                        rent: _match[index].rent)),
                    Text(CostEstimator.esitmateHouse(
                        housePrice: _match[index].medianHomePrice,
                        costOfLiving: _match[index].costOfLiving)),
                    Text(CostEstimator.esitmateHouse15Year(
                        housePrice: _match[index].medianHomePrice,
                        costOfLiving: _match[index].costOfLiving)),
                    Text(CostEstimator.esitmateHouse30Year(
                        housePrice: _match[index].medianHomePrice,
                        costOfLiving: _match[index].costOfLiving)),
                  ],
                ),
              ),
            );
          }),
        ))


      ],
    );
  }

  void onSearch() {
    setState(() {
      _match.clear();
      if (_searchController.text == '') {
        _match.addAll(_cities.cities);
      }
      else {
        for (CityData city in _cities.cities) {
          if (city.city.toLowerCase().contains(_searchController.text.toLowerCase())) {
            _match.add(city);
          }
        }
      }
    });
  }

}