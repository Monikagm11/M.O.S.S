import 'package:flutter/material.dart';

class PoliceStationCard extends StatelessWidget {
  final Function? onMapFunction;
  const PoliceStationCard({super.key, this.onMapFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onMapFunction!("Police Stations Near me");
          },
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: 60,
              width: 60,
              child: const Center(
                child: Icon(
                  Icons.safety_check,
                  size: 50,
                  color: Color.fromARGB(255, 138, 113, 43),
                ),
              ),
            ),
          ),
        ),
        const Text(
          "Police Stations",
          style: TextStyle(fontSize: 15),
        ),
      ],
    );
  }
}