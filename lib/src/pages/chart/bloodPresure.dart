import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BloodPresureChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BloodPresureChartState();
}

class BloodPresureChartState extends State<BloodPresureChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 110, 80);
    final barGroup2 = makeGroupData(1, 90, 70);
    final barGroup3 = makeGroupData(2, 100, 70);
    final barGroup4 = makeGroupData(3, 120, 80);
    final barGroup5 = makeGroupData(4, 100, 70);
    final barGroup6 = makeGroupData(5, 110, 80);
    final barGroup7 = makeGroupData(6, 110, 70);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          //elevation: 0.7,
          backgroundColor:  Colors.blue,
          
        ),
        body: 
        
        Column(
          
          children: [
            new Padding(padding: EdgeInsets.only(top: 20.0)),
             AspectRatio(
                aspectRatio: 1,
                child: 
          
                Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                color: const Color(0xff2c4260),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          makeTransactionsIcon(),
                          const SizedBox(
                            width: 38,
                          ),
                          const Text(
                            'Blood Presure',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Upper/Lower',
                            style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 38,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: BarChart(
                            BarChartData(
                              maxY: 250,
                              barTouchData: BarTouchData(
                                  touchTooltipData: BarTouchTooltipData(
                                    tooltipBgColor: Colors.grey,
                                    getTooltipItem: (_a, _b, _c, _d) => null,
                                  ),
                                  touchCallback: (response) {
                                    if (response.spot == null) {
                                      setState(() {
                                        touchedGroupIndex = -1;
                                        showingBarGroups = List.of(rawBarGroups);
                                      });
                                      return;
                                    }

                                    touchedGroupIndex = response.spot.touchedBarGroupIndex;

                                    setState(() {
                                      if (response.touchInput is FlLongPressEnd ||
                                          response.touchInput is FlPanEnd) {
                                        touchedGroupIndex = -1;
                                        showingBarGroups = List.of(rawBarGroups);
                                      } else {
                                        showingBarGroups = List.of(rawBarGroups);
                                        if (touchedGroupIndex != -1) {
                                          double sum = 0;
                                          for (BarChartRodData rod
                                              in showingBarGroups[touchedGroupIndex].barRods) {
                                            sum += rod.y;
                                          }
                                          final avg =
                                              sum / showingBarGroups[touchedGroupIndex].barRods.length;

                                          showingBarGroups[touchedGroupIndex] =
                                              showingBarGroups[touchedGroupIndex].copyWith(
                                            barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                                              return rod.copyWith(y: avg);
                                            }).toList(),
                                          );
                                        }
                                      }
                                    });
                                  }),
                              titlesData: FlTitlesData(
                                show: true,
                                bottomTitles: SideTitles(
                                  showTitles: true,
                                  textStyle: TextStyle(
                                      color: const Color(0xff7589a2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  margin: 20,
                                  getTitles: (double value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return 'Mn';
                                      case 1:
                                        return 'Te';
                                      case 2:
                                        return 'Wd';
                                      case 3:
                                        return 'Tu';
                                      case 4:
                                        return 'Fr';
                                      case 5:
                                        return 'St';
                                      case 6:
                                        return 'Sn';
                                      default:
                                        return '';
                                    }
                                  },
                                ),
                                leftTitles: SideTitles(
                                  showTitles: true,
                                  textStyle: TextStyle(
                                      color: const Color(0xff7589a2),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                  margin: 32,
                                  reservedSize: 14,
                                  getTitles: (value) {
                                    if (value == 10) {
                                      return '10';
                                    } else if (value == 110) {
                                      return '110';
                                    } else if (value == 220) {
                                      return '220';
                                    } else {
                                      return '';
                                    }
                                  },
                                ),
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              barGroups: showingBarGroups,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      
                    ],
                    
                  ),
                ),
              
          )
          
        ),
        new Padding(padding: EdgeInsets.only(top: 60.0)),
        new Text('Your Blood Presure Today is 110/80',
            style: new TextStyle(color: Colors.blue, fontSize: 20.0),),
          ],
          
        )   

         
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        y: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    const double width = 4.5;
    const double space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
