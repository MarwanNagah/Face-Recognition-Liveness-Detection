import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:face_liveness_detection_app/Screens/Widgets/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  Future<void> refresh(BuildContext context) async {
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Object>(
          future: refresh(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.greenAccent[400])),
                  )
                : RefreshIndicator(
                    onRefresh: () => refresh(context),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Consumer<InstitutionProvider>(
                          builder: (context, institution, child) =>
                              ListView.builder(
                                itemCount:
                                    institution.institutionReports.length,
                                itemBuilder: (_, i) => Column(
                                  children: [
                                    ReportWidget(
                                      reportID: institution
                                          .institutionReports[i].reportID,
                                      date: institution
                                          .institutionReports[i].reportDate,
                                      status: institution
                                          .institutionReports[i].status,
                                      userID: institution
                                          .institutionReports[i].userID,
                                      img: institution
                                          .institutionReports[i].takenImage,
                                    )
                                  ],
                                ),
                              )),
                    ));
          }),
    );
  }
}
