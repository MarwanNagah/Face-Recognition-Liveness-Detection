import 'package:face_liveness_detection_app/Providers/institutionProvider.dart';
import 'package:face_liveness_detection_app/Screens/Widgets/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportData extends StatefulWidget {
  @override
  _ReportDataState createState() => _ReportDataState();
}

class _ReportDataState extends State<ReportData> {
  DateTime dateselected;
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      dateselected = ModalRoute.of(context).settings.arguments as DateTime;
    });
  }

  Future<void> refresh(BuildContext context) async {
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchReports();
    await Provider.of<InstitutionProvider>(context, listen: false)
        .fetchReportByDate(dateselected);
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
                          builder: (context, institution, child) => institution
                                  .ReportsByDate.isEmpty
                              ? Center(
                                  child: Text("NO data Yet"),
                                )
                              : ListView.builder(
                                  itemCount: institution.ReportsByDate.length,
                                  itemBuilder: (_, i) => Column(
                                    children: [
                                      ReportWidget(
                                        reportID: institution
                                            .ReportsByDate[i].reportID,
                                        date: institution
                                            .ReportsByDate[i].reportDate,
                                        status:
                                            institution.ReportsByDate[i].status,
                                        userID:
                                            institution.ReportsByDate[i].userID,
                                        img: institution
                                            .ReportsByDate[i].takenImage,
                                      )
                                    ],
                                  ),
                                )),
                    ));
          }),
    );
  }
}
