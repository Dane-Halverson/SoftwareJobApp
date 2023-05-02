
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/CityData.dart';

class CityStatsBrowser extends StatefulWidget {
  const CityStatsBrowser({super.key});

  @override
  State<CityStatsBrowser> createState() => _CityStatsBrowserState();
}

class _CityStatsBrowserState extends State<CityStatsBrowser> {
  late Future<Map<String, List<CityData>>> _cityToStateMap;

  @override
  void initState() {
    super.initState();
    _cityToStateMap = mapCitiesToState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder<Map<String, List<CityData>>>(
      future: _cityToStateMap,
      builder: (context, snapshot) {
        final tiles = <ExpansionTile>[];
        if (snapshot.hasData) {
          final map = snapshot.data!;
          final states = map.keys.toList();
          states.sort();
          for (final state in states) {
            final tile = ExpansionTile(title: Text(state,style: Theme.of(context).textTheme.labelLarge), children: <Widget>[],);
            final cities = map[state]!;
            for (final city in cities) {
              tile.children.add(
                ListTile(title: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text('Overview for ${city.city}', style: Theme.of(context).textTheme.titleLarge),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Average Cost of Living: ${city.costOfLiving}', style: Theme.of(context).textTheme.bodyMedium),
                                    Text('Average Adjusted Software Developer Salary: ${city.meanSalaryAdjusted}', style: Theme.of(context).textTheme.bodyMedium),
                                    Text('Average Unadjusted Salary: ${city.meanSalaryUnadjusted}', style: Theme.of(context).textTheme.bodyMedium),
                                    Text('Median Home Price: ${city.medianHomePrice}', style: Theme.of(context).textTheme.bodyMedium),
                                    Text('Number of Software Developer Jobs: ${city.numberOfSoftwareJobs}', style: Theme.of(context).textTheme.bodyMedium),
                                    Text('Average Local Purchasing Power: ${city.purchasingPower}', style: Theme.of(context).textTheme.bodyMedium),
                                    Text('Average Rent Cost: ${city.rent}', style: Theme.of(context).textTheme.bodyMedium),
                                  ],
                                ),
                                Center(child: OutlinedButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Close')
                                )),
                              ]
                            )
                          );
                        }
                    );
                  },
                  child: Text(city.city)
                ))
              );
            }
            tiles.add(tile);
          }
          return ListView(
            children: tiles
          );
        } else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    ));
  }
}