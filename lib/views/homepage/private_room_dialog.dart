
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:unihub/utils/verifier.dart';

class PrivateRoomDialog extends StatelessWidget{

  PrivateRoomDialog({Key? key}) : super(key: key);

  final TextEditingController _otpController = TextEditingController();

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

              const Text('Enter Unique Six Digit Code To Join Private Room'),

              PinCodeTextField(

                appContext: context,

                length: 6,

                onChanged: (v){},

                validator: (v) => Verifier.isOTP(v!) ? null : 'Enter all 6 digits',

                keyboardType: TextInputType.text,

                controller: _otpController,

              ),

              TextButton(

                  onPressed: (){},

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