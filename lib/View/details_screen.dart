import 'package:covid_app/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths, totalRecovered, active, critical,todayRecovered, todayDeath, test;
   DetailsScreen({required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.todayDeath,
     required this.test,
   });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      reUseable_row(title:  'Cases', value: widget.totalCases.toString()),
                      reUseable_row(title:  'Recovered', value: widget.totalRecovered.toString()),
                      reUseable_row(title:  'Deaths', value: widget.totalDeaths.toString()),
                      reUseable_row(title:  'Critical', value: widget.critical.toString()),
                      reUseable_row(title:  'Active', value: widget.active.toString()),
                      reUseable_row(title:  'Tests', value: widget.test.toString()),
                      reUseable_row(title:  'Today Recovered', value: widget.totalRecovered.toString()),
                      reUseable_row(title:  'Today Deaths', value: widget.totalDeaths.toString()),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 20,
                    )
                  ]
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}
