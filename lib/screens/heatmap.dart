import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class HeatMap extends StatefulWidget {
  const HeatMap({super.key});

  @override
  State<HeatMap> createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMap> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Total study for the month',
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: const Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.white,
                offset: const Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
          child: Text('')
          // HeatMapCalendar(
          //   defaultColor: Colors.white,
          //   flexible: true,
          //   colorMode: ColorMode.color,
          //   datasets: {
          //     DateTime(2023, 3, 6): 3,
          //     DateTime(2023, 3, 7): 7,
          //     DateTime(2023, 3, 8): 10,
          //     DateTime(2023, 3, 9): 13,
          //     DateTime(2023, 3, 13): 6,
          //   },
          //   colorsets: const {
          //     1: Colors.red,
          //     3: Colors.orange,
          //     5: Colors.yellow,
          //     7: Colors.green,
          //     9: Colors.blue,
          //     11: Colors.indigo,
          //     13: Colors.purple,
          //   },
          //   onClick: (value) {
          //     ScaffoldMessenger.of(context)
          //         .showSnackBar(SnackBar(content: Text(value.toString())));
          //   },
          // ),
        ),
      ],
    );
  }
}
