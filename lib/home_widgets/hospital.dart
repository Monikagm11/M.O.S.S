import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final Function? onMapFunction;
  const HospitalCard({super.key, this.onMapFunction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              onMapFunction!("Hospitals Near me");
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
                    Icons.local_hospital_rounded,
                    size: 50,
                    color: Color.fromARGB(255, 237, 139, 237),
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Hospitals",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}