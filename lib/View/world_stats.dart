import 'package:covid_app/Services/Utilities/states_services.dart';
import 'package:covid_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStatesModel.dart';

class worldStatScreen extends StatefulWidget {
  const worldStatScreen({Key? key}) : super(key: key);

  @override
  State<worldStatScreen> createState() => _worldStatScreenState();
}

class _worldStatScreenState extends State<worldStatScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285f4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              FutureBuilder(
                  future: stateServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xff424242),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                )
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PieChart(
                                dataMap: {
                                  "Total": double.parse(
                                      snapshot.data!.cases!.toString()),
                                  'Recovered': double.parse(
                                      snapshot.data!.recovered.toString()),
                                  'Dead': double.parse(
                                      snapshot.data!.deaths.toString()),

                                },
                                chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: true),
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                                animationDuration: Duration(milliseconds: 1200),
                                chartType: ChartType.ring,
                                colorList: colorList,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .06),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xff424242),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 10,
                                  )
                                ]
                              ),
                              child: Card(
                                child: Column(
                                  children: [
                                    reUseable_row( title: 'Total', value: snapshot.data!.cases.toString(),),
                                    reUseable_row( title: 'Deaths', value: snapshot.data!.deaths.toString(),),
                                    reUseable_row( title: 'Recovered', value: snapshot.data!.recovered.toString(),),
                                    reUseable_row( title: 'Active', value: snapshot.data!.active.toString(),),
                                    reUseable_row( title: 'critical', value: snapshot.data!.critical.toString(),),
                                    reUseable_row( title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString(),),
                                    reUseable_row( title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString(),),


                                  ],
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap:(){ Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text('Track Counties'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class reUseable_row extends StatelessWidget {
  String title, value;
  reUseable_row({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: TextStyle(fontSize: 15,
            ),),
            Text(value,style: TextStyle(fontSize: 15,
            ),),
          ]),
          // SizedBox(
          //   height: 5,
          // ),
          Divider(),
        ],
      ),
    );
  }
}
