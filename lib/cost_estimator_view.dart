import 'package:flutter/material.dart';
import 'package:final_project/city/models/CostEstimates.dart';
import 'package:final_project/city/models/CityData.dart';
import 'package:final_project/city/models/CityList.dart';

class CostEstimatorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CostEstimatorStatefulWidget(
        key: super.key,
      ),
    );
  }
}

class CostEstimatorStatefulWidget extends StatefulWidget {
  const CostEstimatorStatefulWidget({super.key});

  @override
  State<CostEstimatorStatefulWidget> createState() =>
      _CostEstimatorStatefulWidgetState();
}

class _CostEstimatorStatefulWidgetState
    extends State<CostEstimatorStatefulWidget> {
  final TextEditingController _searchController = TextEditingController();
  final CityList _cities = CityList();
  final List<CityData> _match = [];

  final _txtStyle = const TextStyle(fontSize: 15,);
  final _headStyle = const TextStyle(
    fontSize: 17,
  );

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
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(icon: Icon(Icons.search_rounded)),
          ),
        ),
        Expanded(
            child: ListView(
          children: List<Widget>.generate(_match.length, (index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Chip(
                        label: Text(
                          _match[index].city,
                          style: _headStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                          CostEstimator.esitmateRent(
                              costOfLiving: _match[index].costOfLiving,
                              rent: _match[index].rent),
                          style: _txtStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                          CostEstimator.esitmateHouse(
                              housePrice: _match[index].medianHomePrice,
                              costOfLiving: _match[index].costOfLiving),
                          style: _txtStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                          CostEstimator.esitmateHouse15Year(
                              housePrice: _match[index].medianHomePrice,
                              costOfLiving: _match[index].costOfLiving),
                          style: _txtStyle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                          CostEstimator.esitmateHouse30Year(
                              housePrice: _match[index].medianHomePrice,
                              costOfLiving: _match[index].costOfLiving),
                          style: _txtStyle),
                    ),
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
      } else {
        for (CityData city in _cities.cities) {
          if (city.city
              .toLowerCase()
              .contains(_searchController.text.toLowerCase())) {
            _match.add(city);
          }
        }
      }
    });
  }
}
