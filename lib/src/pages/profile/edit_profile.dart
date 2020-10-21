import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:medrec/src/pages/home/home.dart';
import 'package:medrec/src/pages/profile/profilePage.dart';
import 'package:medrec/src/services/auth.dart';
import 'package:medrec/src/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medrec/src/widgets/loadings/loading_add_record.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key, this.title}) : super(key: key);

  final String title;
  

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  
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
            appBar: AppBar(title: Text('Edit Profile')),
            body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                  try{
                    User user = AuthService().getUser();
                  DatabaseServices.createOrUpdateUserProfile(user.uid,address: formBloc.address.value,fullname: formBloc.name.value,phone: formBloc.phonenumber.value,
                  allergic: formBloc.allergic.value,bloodtype: formBloc.bloodtype.value,dateofbirth: formBloc.dateofbirth.value,emergencycontactname: formBloc.emergencycontactname.value,
                  emergencycontactnumber: formBloc.emergencycontactnumber.value,ktp: formBloc.ktp.value,placeofbirth: formBloc.placeofbirth.value,height: formBloc.height.value,weight: formBloc.weight.value );
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
                      MaterialPageRoute(builder: (_) => ProfilePage()));
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
                           
                            TextFieldBlocBuilder(
                              //maxLines: 3,
                              
                              textFieldBloc: formBloc.name,
                              //keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.people),
                              ),
                              
                            ),
                            DateTimeFieldBlocBuilder(
                              dateTimeFieldBloc: formBloc.dateofbirth,
                              canSelectTime: true,
                              format: DateFormat('dd-mm-yyyy'),
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                              decoration: InputDecoration(
                                labelText: 'Date of birth',
                                prefixIcon: Icon(Icons.date_range),
                                helperText: 'Your birth Date',
                              ),
                            ),
                            TextFieldBlocBuilder(
                             //maxLines: 3,
                              textFieldBloc: formBloc.placeofbirth,
                              //keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Place of birth',
                                prefixIcon: Icon(Icons.location_city),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              //maxLines: 3,
                              textFieldBloc: formBloc.ktp,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'National Identity Number',
                                prefixIcon: Icon(Icons.confirmation_number),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.address,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Address',
                                prefixIcon: Icon(Icons.home),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              //maxLines: 3,
                              textFieldBloc: formBloc.phonenumber,
                              //keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Phone number',
                                prefixIcon: Icon(Icons.phone),
                              ),
                            ),
                            DropdownFieldBlocBuilder<String>(
                              selectFieldBloc: formBloc.bloodtype,
                              decoration: InputDecoration(
                                labelText: 'Blood type',
                                prefixIcon: Icon(Icons.person),
                              ),
                              itemBuilder: (context, value) => value,
                            ),
                            TextFieldBlocBuilder(
                              //maxLines: 3,
                              textFieldBloc: formBloc.height,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Height',
                                prefixIcon: Icon(Icons.height),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              //maxLines: 3,
                              textFieldBloc: formBloc.weight,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Weight',
                                prefixIcon: Icon(Icons.confirmation_number),
                              ),
                            ),
                            TextFieldBlocBuilder(
                              maxLines: 3,
                              textFieldBloc: formBloc.allergic,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                labelText: 'Allergic',
                                prefixIcon: Icon(Icons.people,
                              ),
                            ),
                            ),
                            TextFieldBlocBuilder(
                              //maxLines: 3,
                              textFieldBloc: formBloc.emergencycontactname,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                labelText: 'Emergency Contact Name',
                                prefixIcon: Icon(Icons.people),
                              ),
                            ),
                           TextFieldBlocBuilder(
                              //maxLines: 3,
                              textFieldBloc: formBloc.emergencycontactnumber,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Emergency Contact Number',
                                prefixIcon: Icon(Icons.people),
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
  final name = TextFieldBloc(initialValue: "Ashary Gartanto");
  final placeofbirth = TextFieldBloc();
  final address = TextFieldBloc();
  final phonenumber = TextFieldBloc();
  final height = TextFieldBloc();
  final weight = TextFieldBloc();
  final ktp = TextFieldBloc();
  final allergic = TextFieldBloc();

  final emergencycontactname = TextFieldBloc();

  final emergencycontactnumber = TextFieldBloc();

  

  final bloodtype = SelectFieldBloc(
    items: ['A', 'AB', 'B', 'O'],
  );

  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Option 1',
      'Option 2',
    ],
  );

  final dateofbirth = InputFieldBloc<DateTime, Object>();

  final dateAndTime = InputFieldBloc<DateTime, Object>();

  final time1 = InputFieldBloc<TimeOfDay, Object>();

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      name,
      placeofbirth,
      address,
      dateofbirth,
      phonenumber,
      height,
      weight,
      ktp,
      allergic,
      emergencycontactname,
      emergencycontactnumber,
      bloodtype
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


