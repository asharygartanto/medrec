import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:medrec/core/presentation/res/assets.dart';
import 'package:medrec/src/pages/home/home.dart';
import 'package:medrec/src/services/auth.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medrec/src/widgets/loadings/loading_add_record.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddMedicalReCordPage extends StatefulWidget {
  AddMedicalReCordPage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  AddMedicalReCordPageState createState() => AddMedicalReCordPageState();
}

class AddMedicalReCordPageState extends State<AddMedicalReCordPage> {
  
final _formKey = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  //TypeOperation typeOperation = TypeOperation.download;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final String keyMyPosts = 'keyMyPosts';
  bool isLoading = true;
  bool isSuccess = true;
  bool isGridView = true;
  final List<String> myPosts = [];
  User user;
  String _recordid;
  bool isComplete =false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          
          child:Scaffold(
            appBar: AppBar(title: Text('Add Medical Record')),
            body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                  try{
                     user = AuthService().getUser();
                  DatabaseServices.createOrUpdateUserDataRecord(user.uid,anamnesis: formBloc.anamnesis.value,
                  diagnosis: formBloc.diagnosis.value,docter: formBloc.docter.value,
                  hospital: formBloc.hospital.value,medicalTreatment: formBloc.medicalTreatment.value,
                  medicine: formBloc.medicine.value,physicalExamination: formBloc.physicalExamination.value,
                  time1: DateTime.now(),inoroutpatient: formBloc.inoroutpatinet.value);
                  }
                  catch(e)
                  {
                    print(e);
                  }
                  
                },
                onSuccess: (context, state) {
                  _getLastRecordid().then((value) => {
                    _recordid=value
                  }).whenComplete(() {
                    if(_recordid!=""){
                      isComplete=true;
                    LoadingDialog.hide(context);
                    }
                    
                  
                  }
                  );
                  

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Data saved successfully")));
                
                  

                 

                 // Navigator.of(context).pushReplacement(
                 //     MaterialPageRoute(builder: (_) => MyHomePage()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                    Form(
                      key: _formKey,
                      child: 
                          Column(
                          children: <Widget>[
                            RadioButtonGroupFieldBlocBuilder<String>(
                              selectFieldBloc: formBloc.inoroutpatinet,
                              decoration: InputDecoration(
                                labelText: 'Inpatient or Outpatient',
                                prefixIcon: SizedBox(),
                              ),
                              itemBuilder: (context, item) => item,
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.anamnesis,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Anamnesis',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                            ),
                            DateTimeFieldBlocBuilder(
                              dateTimeFieldBloc: formBloc.dateAndTime,
                              canSelectTime: true,
                              format: DateFormat('dd-mm-yyyy  hh:mm'),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              decoration: InputDecoration(
                                labelText: 'DateTimeFieldBlocBuilder',
                                prefixIcon: Icon(Icons.date_range),
                                helperText: 'Date and Time',
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.physicalExamination,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Physical Examination',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.diagnosis,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Diagnosis',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.medicalTreatment,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Medical Treatment',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.medicine,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Medicine',
                                prefixIcon: Icon(Icons.text_fields),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 1,
                              textFieldBloc: formBloc.docter,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Doctor',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.hospital,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Hospital / Clinic',
                                prefixIcon: Icon(Icons.local_hospital),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 20.0, top: 15.0,bottom: 30),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: new OutlineButton(
                                        child: new Text("Save"),
                                        onPressed: (){
                                          formBloc.submit();
                                          },
                                        borderSide: BorderSide(
                                          color: Colors.blue, //Color of the border
                                          style: BorderStyle.solid, //Style of the border
                                          width: 0.8, //width of the border
                                        ),
                                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                                      )/*new TextField(
                                        decoration: const InputDecoration(
                                            hintText: "Name"),
                                        enabled: !_status,
                                      ),*/
                                    ),
                                    flex: 2,
                                  ),
                                  /*Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Phone Number"),
                                      enabled: !_status,
                                    ),
                                    flex: 2,
                                  ),*/
                                  
                                ],
                              )),
                              /*Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 20.0, top: 5.0,bottom: 30),
                              child:
                                Center(
                                  child: Column(
                                    children: [
                                      OutlineButton(
                                      onPressed: () async {
                                        File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                        if (image == null) {
                                          return;
                                        }
                                        List<String> splitPath = image.path.split('/');
                                        String filename = splitPath[splitPath.length - 1];
                                        StorageReference ref = firebaseStorage.ref().child('images').child(filename);
                                        StorageUploadTask uploadTask = ref.putFile(image);
                                        StreamSubscription streamSubscription = uploadTask.events.listen((event) async {
                                          var eventType = event.type;
                                          if (eventType == StorageTaskEventType.progress) {
                                            setState(() {
                                              //typeOperation = TypeOperation.upload;
                                              isLoading = true;
                                            });
                                          } else if (eventType == StorageTaskEventType.failure) {
                                            SnackBar(
                                              content: Text('Photo failed to upload'),
                                            );
                                            setState(() {
                                              isLoading = false;
                                              isSuccess = false;
                                              //typeOperation = null;
                                            });
                                          } else if (eventType == StorageTaskEventType.success) {
                                            var downloadUrl = await event.snapshot.ref.getDownloadURL();
                                            myPosts.add(downloadUrl);
                                            //sharedPreferences.setStringList(keyMyPosts, myPosts);
                                            SnackBar(
                                              content: Text('Photo uploaded successfully'),
                                            );
                                            setState(() {
                                              isLoading = false;
                                              isSuccess = true;
                                            // typeOperation = null;
                                            });
                                          }
                                        });
                                        await uploadTask.onComplete;
                                        streamSubscription.cancel();
                                      },
                                      child: Text("Add Attachment"),
                                      ),
                                      _buildWidgetMyPosts()
                                    ],
                                  )
                                  
                                ) 
                              ),*/
                          ],
                        ),
                      ),
                    ),
                    
                ),
              ),
            )
          );
        }
      )
    );
  }

   Widget _buildWidgetMyPosts() {
    if (isLoading ) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (myPosts.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WidgetTextMont(
            'No post available',
            fontWeight: FontWeight.bold,
            fontSize: 56,
            textColor: Colors.grey[600],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(24),
          ),
          WidgetTextMont(
            'When you share photos and videos, they\'ll appear in here',
            textAlign: TextAlign.center,
            textColor: Colors.grey[700],
          ),
        ],
      );
    } else {
      double paddingBottomScreen = MediaQuery.of(context).padding.bottom;
      return isGridView
          ? Padding(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: GridView.count(
                padding: EdgeInsets.zero,
                crossAxisCount: 3,
                children: myPosts.map(
                  (item) {
                    return ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: item,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset(
                            img_placeholder,
                            fit: BoxFit.cover,
                          );
                        },
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            img_not_found,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
                crossAxisSpacing: ScreenUtil().setWidth(48),
                mainAxisSpacing: ScreenUtil().setHeight(48),
              ),
            )
          : Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(48),
                bottom: paddingBottomScreen == 0 ? ScreenUtil().setHeight(48) : paddingBottomScreen,
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: myPosts.length,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: ScreenUtil().setHeight(48),
                  );
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: myPosts[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return Image.asset(
                          img_placeholder,
                          fit: BoxFit.cover,
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          img_not_found,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  );
                },
              ),
            );
    }
  }

  Future<String> _getLastRecordid() async {
    
   QuerySnapshot snapshot= await DatabaseServices.getLastRecordid(FirebaseAuth.instance.currentUser.uid);
   return snapshot.docs[0]["recordid"].toString();
      
  }
}

class AllFieldsFormBloc extends FormBloc<String, String> {
  final anamnesis = TextFieldBloc();
  final physicalExamination = TextFieldBloc();
  final diagnosis = TextFieldBloc();
  final medicalTreatment = TextFieldBloc();
  final medicine = TextFieldBloc();
  final docter = TextFieldBloc();
  final hospital = TextFieldBloc();

  final boolean1 = BooleanFieldBloc();

  final boolean2 = BooleanFieldBloc();

  final inoroutpatinet = SelectFieldBloc(
    items: ['Inpatient', 'Outpatient'],
  );

  final select2 = SelectFieldBloc(
    items: ['Option 1', 'Option 2'],
  );

  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Option 1',
      'Option 2',
    ],
  );

  final date1 = InputFieldBloc<DateTime, Object>();

  final dateAndTime = InputFieldBloc<DateTime, Object>();

  final time1 = InputFieldBloc<TimeOfDay, Object>();

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      inoroutpatinet,
      anamnesis,
      physicalExamination,
      diagnosis,
      medicalTreatment,
      medicine,
      docter,
      hospital,
      time1,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }
}

class WidgetTextMont extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign textAlign;

  WidgetTextMont(
    this.text, {
    this.fontSize = 36,
    this.fontWeight = FontWeight.normal,
    this.textColor = Colors.white,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: ScreenUtil().setSp(fontSize),
        fontWeight: fontWeight,
        fontFamily: 'Mont',
      ),
      textAlign: textAlign,
    );
  }
}


