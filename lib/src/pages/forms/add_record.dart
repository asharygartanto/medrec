import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:medrec/src/pages/home/home.dart';
import 'package:medrec/src/services/auth.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medrec/src/widgets/loadings/loading_add_record.dart';

class AddMedicalReCordPage extends StatefulWidget {
  AddMedicalReCordPage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  AddMedicalReCordPageState createState() => AddMedicalReCordPageState();
}

class AddMedicalReCordPageState extends State<AddMedicalReCordPage> {
  
final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    User user = AuthService().getUser();
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
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Data saved successfully")));
                
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => MyHomePage()));
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


