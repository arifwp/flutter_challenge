import 'package:flutter/material.dart';
import 'package:flutter_challenge/components/alert.dart';
import 'package:flutter_challenge/components/app_date_picker.dart';
import 'package:flutter_challenge/components/style_textfield.dart';
import 'package:flutter_challenge/db/database_helper.dart';
import 'package:flutter_challenge/models/activity_model.dart';

class AppCrud extends StatefulWidget {
  const AppCrud({super.key});

  @override
  State<AppCrud> createState() => _AppCrudState();
}

class _AppCrudState extends State<AppCrud> {
  @override
  Widget build(BuildContext context) {
    final conActivity = TextEditingController();
    final conDate = TextEditingController();

    addActivity() async {
      String activity = conActivity.text;
      String date = conDate.text;

      if (activity.isEmpty) {
        alertDialog(context, 'Enter activity name');
      } else if (date.isEmpty) {
        alertDialog(context, 'Enter activity date');
      } else {
        ActivityModel data = ActivityModel(null, activity, date);
        await DatabaseHelper().saveActivity(data).then((value) {
          if (value != null) {
            print(' ini activity');
            print(activity);
            print('ini date');
            print(date);
            alertDialog(context, 'Successfully added new data');
          } else {
            alertDialog(context, 'Failed add new data');
          }
        }).catchError((error) {
          print(error);
          alertDialog(context, 'Sistem sedang dibenahi');
        });
      }
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: double.infinity,
          child: Card(
            color: Color(0xffeeeeee),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                    bottom: 0,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Tambah Data',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StyleTextField(
                        'Nama Kegiatan',
                        conActivity,
                        false,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AppDatePicker(
                        'Tanggal kegiatan',
                        conDate,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: addActivity,
                              child: Text(
                                'Add Activity',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Activity List',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FutureBuilder(
                        future: DatabaseHelper().getActivity(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              if (snapshot.hasData) {
                                var dataSnapshot = snapshot.data!;
                                return ListTile(
                                  title: Text(
                                    dataSnapshot[index]
                                        .activity_name
                                        .toString(),
                                  ),
                                  subtitle: Text(
                                    dataSnapshot[index].date.toString(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          radius: 30 + 2,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/flutter_logo.png'),
            radius: 30,
          ),
        )
      ],
    );
  }
}
