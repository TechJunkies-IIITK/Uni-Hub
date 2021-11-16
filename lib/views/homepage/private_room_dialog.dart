
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:unihub/controllers/socket_controller.dart';
import 'package:unihub/views/snackbar.dart';

class PrivateRoomDialog extends StatelessWidget{

  PrivateRoomDialog({Key? key}) : super(key: key);

  final TextEditingController _codeController = TextEditingController();

  @override

  Widget build(BuildContext context) {

    return Dialog(

      child: Container(

        padding: const EdgeInsets.all(8.0),

        decoration: BoxDecoration(

            border: Border.all( color: Colors.teal, )

        ),

        child: Center(

          child: Column(

            children: [

              const Text('Enter Unique Six character Code To Join Private Room'),

              PinCodeTextField(

                appContext: context,

                length: 6,

                onChanged: (v){},

                validator: (v) => v!.length==6 ? null : 'Enter all 6 characters',

                keyboardType: TextInputType.text,

                controller: _codeController,

              ),

              TextButton(

                  onPressed: (){

                    if(_codeController.text.length == 6){

                      SocketController.socket.emit('join',{

                        'hubCode': _codeController.text,

                        'isPublic': false

                      });

                    } else{

                      showSnackBar('Invalid Code', context, SnackBarType.error);

                    }

                    if(Navigator.canPop(context)) Navigator.pop(context);

                  },

                  style: ButtonStyle(

                    backgroundColor: MaterialStateProperty.all(Colors.blue)

                  ),

                  child: const Text('Join Private Room', style: TextStyle(color: Colors.white),)

              )

            ],

          ),
        ),

      ),

    );
  }

}