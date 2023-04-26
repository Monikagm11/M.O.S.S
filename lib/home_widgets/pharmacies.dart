import 'package:flutter/material.dart';

class PharmaciesCard extends StatelessWidget {
  final Function? onMapFunction;
  const PharmaciesCard({super.key, this.onMapFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!("Pharmacies Near me");
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
                    Icons.medication,
                    size: 50,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Pharmacies",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}