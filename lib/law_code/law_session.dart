// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:riderapp/screens/drawer_screens/laws/laws.dart';
import 'package:riderapp/screens/drawer_screens/laws/pdf_viewer_page.dart';

class LawSession extends StatelessWidget {
  const LawSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: const Text('Law Session')),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "This panel aids users with Acts and Rules of Nepal Government in favour of Women safety, empowerment and encouragement.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                const url = 'Women RIghts.pdf';
                final file = await PdfApi.loadFirebase(url);
                if (file == null) return;
                openPDF(context, file);
              },
              child: Card(
                // shadowColor: Colors.blue,
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      "Women Right Act",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                const url = 'Muluki Criminal Code,2074.pdf';
                final file = await PdfApi.loadFirebase(url);
                if (file == null) return;
                openPDF(context, file);
              },
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      "Muluki Criminal Code for Harassment",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                const url = 'GEnder Equality And Women Empowerment.pdf';
                final file = await PdfApi.loadFirebase(url);
                if (file == null) return;
                openPDF(context, file);
              },
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      "Women Empowerment and \n Gender Equality Act",
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                const url = 'Domestic Violence.pdf';
                final file = await PdfApi.loadFirebase(url);
                if (file == null) return;
                openPDF(context, file);
              },
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      "Domestic Violence Act",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () async {
                const url = 'Abuse on Workplace.pdf';
                final file = await PdfApi.loadFirebase(url);
                if (file == null) return;
                openPDF(context, file);
              },
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.all(12),
                  child: const Center(
                    child: Text(
                      "Abuse on Workplace Act",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => PDFViewerPage(
                  file: file,
                )),
      );
}
