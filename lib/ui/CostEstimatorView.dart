import 'package:flutter/material.dart';
import '../city/models/CityData.dart';
import '../city/models/CityList.dart';
import '../city/models/CostEstimates.dart';

class CostEstimatorView extends StatelessWidget {
  const CostEstimatorView({super.key});

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
  List<CityData> _match = [];
  late List<CityData> _cities;
  late Future<List<CityData>> _citiesList;
  bool _copied = false;

  final _txtStyle = const TextStyle(fontSize: 15,);
  final _headStyle = const TextStyle(
    fontSize: 17,
  );

  @override
  void initState() {
    super.initState();
    _searchController.addListener(onSearch);
    _citiesList = CityList.getCities();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _citiesList,
        builder: (BuildContext context, AsyncSnapshot<List<CityData>> snapshot) {
          if (snapshot.hasData) {
            List<CityData> cities = snapshot.data!;
            if (!_copied) {
              _cities = cities;
              _match.addAll(_cities);
              _copied = true;
            }
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
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
  }

  void onSearch() {
    setState(() {
      _match.clear();
      if (_searchController.text == '') {
        _match.addAll(_cities);
      } else {
        for (CityData city in _cities) {
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
