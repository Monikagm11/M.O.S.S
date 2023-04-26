import 'package:flutter/material.dart';

class BusStationCard extends StatelessWidget {
  final Function? onMapFunction;
  const BusStationCard({super.key, this.onMapFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!("Bus Stations Near me");
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
                    Icons.bus_alert,
                    size: 50,
                    color: Colors.orangeAccent,
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Bus Stations",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}