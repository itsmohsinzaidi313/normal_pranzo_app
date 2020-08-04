import 'package:flutter/material.dart';
import 'package:normalpranzoapp/app_theme.dart';
import 'package:normalpranzoapp/models/events.dart';

class EventsView extends StatefulWidget {
  final List<Event> list = [];

  EventsView(List<Event> value) {
    this.list.addAll(value);
  }

  @override
  _EventsViewState createState() => _EventsViewState(this.list);
}

class _EventsViewState extends State<EventsView> {
  final List<Event> events = [];

  _EventsViewState(List<Event> events) {
    this.events.addAll(events);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppTheme.optpAppBarA(
        title: 'events',
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Card(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.network(events[index].image,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width * 0.92,
                          height: MediaQuery.of(context).size.height * 0.25,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 8, left: 8),
                        child: AppTheme.autoTextSizeWidget(
                            '${events[index].name.toUpperCase()}',
                            fontWeight: FontWeight.bold,
                            minFontSize: 16,
                            maxFontSize: 21),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: AppTheme.autoTextSizeWidget(
                              'From: ${events[index].dateFrom.substring(0, 10)}',
                              minFontSize: 16,
                              maxFontSize: 21)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 8, right: 8),
                          child: AppTheme.autoTextSizeWidget(
                              'To: ${events[index].dateTo.substring(0, 10)}',
                              minFontSize: 16,
                              maxFontSize: 21))
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
