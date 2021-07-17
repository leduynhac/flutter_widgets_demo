import 'package:flutter/material.dart';

//Refs:
//https://flutter.dev/docs/cookbook/forms/validation
//Steps:
//1. Create a Form with a GlobalKey => done
//2. Add a TextFormField with validation logic => done
//3. Create a button to validate and submit the form

//https://flutter.dev/docs/cookbook/forms/text-input

//https://flutter.dev/docs/cookbook/forms/text-field-changes
//02 ways to handle changes to a text field:
//1. Supply an onChanged() callback to a TextField or TextFormField
//2. Use a TextEditingController

// https://flutter.dev/docs/cookbook/forms/focus
// 1. Create a FocusNode
// 2. Pass the FocusNode to Text form field
// 3. Give focus to the Text form field when a button is tapped

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({ Key? key }) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

//Define a corresponding State class.
//This class holds data related to the form
class _MyCustomFormState extends State<MyCustomForm> {
  //create a global key that uniquely identifies the Form widget and allows validation of the form

  //Note: This is a `GlobalKey<FormState>`
  //not a GlobalKey<MyCustomFormState>
  final _formKey = GlobalKey<FormState>();

  // Create a text controller. Later, use it to retrieve the
  // current value of the TextFormField
  final _myController = TextEditingController();

  // Define the focus node. To manage the lifecycle, create the FocusNode in
  // the initState method, and clean it up in the dispose method
  late FocusNode _myFocusNode;

  @override
  void initState() {
    // Start listening to changes
    _myController.addListener(() { 
      print('Second text form field: ${_myController.text}');
    });

    super.initState();

    _myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _myController.dispose();

    // Clean up the focus node when the Form is disposed
    _myFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Build a Form widget using the _formKey created above
    return Scaffold(
      appBar: AppBar(
        title: Text('Build a form with validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: createForm(),
      ),

    );
  }

  Widget createForm(){
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          createTextFormField(),
          SizedBox(height: 8,),
          createTextFormFieldWithOutlineBorder(),
          SizedBox(height: 8,),
          createTextFormFieldWithOnChangedHandler(),
          SizedBox(height: 8,),
          createTextFormFieldWithTextEditingController(),
          SizedBox(height: 8,),
          createTextFormFieldFocusWhenVisible(),
          SizedBox(height: 8,),
          createTextFormFieldWithFocusNode(),
          SizedBox(height: 8,),
          createSubmitAndValidateButton(),
        ],
      ),
    );
  }

  Widget createTextFormField(){
    return TextFormField(
      //The validator receives the text that the user has entered.
      validator: (value){
        if (value == null || value.isEmpty){
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  Widget createTextFormFieldWithOutlineBorder(){
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Enter your username',
      ),
    );
  }

  Widget createSubmitAndValidateButton(){
    return ElevatedButton(
      onPressed: (){
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()){
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
        }

        // Give focus to the text field using _myFocusNode
        _myFocusNode.requestFocus();
      }, 
      child: Text('Submit'));
  }

  Widget createTextFormFieldWithOnChangedHandler(){
    return TextFormField(
      onChanged: (text){
        print('First text form field: $text');
      },
    );
  }

  Widget createTextFormFieldWithTextEditingController(){
    return TextFormField(
      controller: _myController,
    );
  }

  Widget createTextFormFieldFocusWhenVisible(){
    return TextFormField(
      autofocus: true,
    );
  }

  Widget createTextFormFieldWithFocusNode(){
    return TextFormField(
      focusNode: _myFocusNode,
      decoration: InputDecoration(
        hintText: 'Give focus to this textbox when Submit btn is tapped',
      ),
    );
  }
}