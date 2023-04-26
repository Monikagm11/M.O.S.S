
import 'dart:io';
import 'package:flutter/material.dart';
import'../law_code/laws.dart';
import'../law_code/pdf_viewer_page.dart';

class LawSession extends StatelessWidget {
  const LawSession({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Law Session'),
        backgroundColor: Color.fromARGB(255, 170, 78, 184),
        
        ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Acts and Rules of Nepal Government in favour of Women safety, empowerment and encouragement:",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 40,
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
                color: Color.fromARGB(255, 231, 213, 231),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration:BoxDecoration(
                    shape:BoxShape.rectangle,
                    border:Border.all(color:Colors.purple ) ,
                    borderRadius:BorderRadius.circular(12)
                  ),
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
                color: Color.fromARGB(255, 231, 213, 231),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                    decoration:BoxDecoration(
                    shape:BoxShape.rectangle,
                    border:Border.all(color:Colors.purple ) ,
                    borderRadius:BorderRadius.circular(12)
                  ),
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
                color: Color.fromARGB(255, 231, 213, 231),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                    decoration:BoxDecoration(
                    shape:BoxShape.rectangle,
                    border:Border.all(color:Colors.purple ) ,
                    borderRadius:BorderRadius.circular(12)
                  ),
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
                color: Color.fromARGB(255, 231, 213, 231),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                    decoration:BoxDecoration(
                    shape:BoxShape.rectangle,
                    border:Border.all(color:Colors.purple ) ,
                    borderRadius:BorderRadius.circular(12)
                  ),
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
                color: Color.fromARGB(255, 231, 213, 231),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                    decoration:BoxDecoration(
                    shape:BoxShape.rectangle,
                    border:Border.all(color:Colors.purple ) ,
                    borderRadius:BorderRadius.circular(12)
                  ),
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