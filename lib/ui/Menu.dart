import 'package:final_project/app/bloc/app_blocs.dart';
import 'package:final_project/app/bloc/app_events.dart';
import 'package:final_project/job_journal.dart';
import 'package:final_project/ui/CostEstimatorView.dart';
import 'package:final_project/ui/VideosView.dart';
import 'package:final_project/ui/preferences.dart';
import 'package:final_project/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import '../city/views/city_stats_browser.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuStatefulWidgetState();
}

class _MenuStatefulWidgetState extends State<Menu> with SingleTickerProviderStateMixin{

  final List<Widget> _pages = [];
  int _value = 0;

  late AnimationController _settingController;


  //pages
  final _videosPage = const VideosView();
  final _estimatorPage = const CostEstimatorView();
  final _settingsPage = SettingsView();
  final _pageTitles = <String>['Explore Jobs', 'Videos', 'City Cost Estimation', 'Browse Cities', 'Preferences', 'Settings'];

  @override
  void initState() {
    super.initState();
    _pages.add(JobsPage());
    _pages.add(_videosPage);
    _pages.add(_estimatorPage);
    _pages.add(const CityStatsBrowser());
    _pages.add(PreferencesPage());
    _pages.add(_settingsPage);
    _settingController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _settingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      return
        Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 52),
            child: SliderDrawer(
              appBar: SliderAppBar(
                appBarColor: Theme.of(context).colorScheme.background,
                title: Text(
                  _pageTitles[_value],
                  style: Theme.of(context).textTheme.labelLarge,
                )
              ),
              slider: SingleChildScrollView(
                child: Container(color: Theme.of(context).colorScheme.background,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      [
                        TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _value = 0;
                              });
                            },
                            label: const Text('Jobs',),
                            icon: const Icon(
                                Icons.cases_rounded,
                                size: 32.0
                            )
                        ),
                        TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _value = 3;
                              });
                            },
                            label: const Text('Browse Cities',),
                            icon: const Icon(
                                Icons.browse_gallery,
                                size: 32.0
                            )
                        ),
                        TextButton.icon(
                            onPressed: switchToVideos,
                            label: const Text("Videos",),
                            icon: const Icon(
                                Icons.play_arrow,
                                size: 32.0
                            )
                        ),
                        TextButton.icon(
                            onPressed: switchToEstimator,
                            label: const Text("Cost Estimator",),
                            icon: const Icon(
                                Icons.money,
                                size: 32.0
                            )
                        ),
                        TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _value = _pages.length - 2;
                              });
                            },
                            label: const Text('Preferences',),
                            icon: const Icon(
                                Icons.info,
                                size: 32.0
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 100),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child:  IconButton(
                              splashRadius: 50,
                              iconSize: 70,
                              onPressed: switchToSettings,
                              icon: const Icon(Icons.settings,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

         child: _pages.elementAt(_value),
        ),
      ),
    );
  }

  void switchToVideos() {
    setState(() {
      _value = _pages.indexOf(_videosPage);
    });
  }

  void switchToEstimator() {
    setState(() {
      _value = _pages.indexOf(_estimatorPage);
    });
  }

  void switchToSettings() {
    setState(() {
      _value = _pages.indexOf(_settingsPage);
    });
  }



}

class GuestMenu extends StatefulWidget {
  const GuestMenu({super.key});

  @override
  State<GuestMenu> createState() => _GuestMenuStatefulWidgetState();
}

class _GuestMenuStatefulWidgetState extends State<GuestMenu> with SingleTickerProviderStateMixin{

  final List<Widget> _pages = [];
  int _value = 0;

  //pages
  final _browsePage = const CityStatsBrowser();
  final _estimatorPage = const CostEstimatorView();
  final _pageTitles = <String>['Browse Cities', 'City Cost Estimation'];

  @override
  void initState() {
    super.initState();
    _pages.add(_browsePage);
    _pages.add(_estimatorPage);
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 52),
            child: SliderDrawer(
              appBar: SliderAppBar(
                  title: Text(
                    _pageTitles[_value],
                    style: Theme.of(context).textTheme.labelLarge,
                  )
              ),
              slider: Container(color: Theme.of(context).colorScheme.background,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [
                      TextButton(
                        child: const Text('Create Account or Login'),
                        onPressed: () => {
                          context.read<AppBloc>().add(
                            const GuestWantsToRegisterEvent()
                          )
                        },
                      ),
                      TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _value = 0;
                            });
                          },
                          label: const Text('Browse Cities',),
                          icon: const Icon(
                              Icons.browse_gallery,
                              size: 32.0
                          )
                      ),
                      TextButton.icon(
                          onPressed: switchToEstimator,
                          label: const Text('Cost Estimator',),
                          icon: const Icon(
                              Icons.money,
                              size: 32.0
                          )
                      ),
                    ],
                  ),
                ),

              ),
              child: _pages.elementAt(_value),
            ),
          )
      );


  }

  void switchToEstimator() {
    setState(() {
      _value = _pages.indexOf(_estimatorPage);
    });
  }

}




