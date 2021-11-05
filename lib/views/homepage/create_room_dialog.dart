
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateRoomDialog extends StatelessWidget{

  CreateRoomDialog({Key? key}) : super(key: key);

  final TextEditingController _roomNameController = TextEditingController();

  final TextEditingController _roomTopicController = TextEditingController();

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

              const Text('Create Room'),

              TextFormField(

                controller: _roomNameController,

                decoration: const InputDecoration(

                  hintText: 'Enter Room Name'

                ),

                autovalidateMode: AutovalidateMode.always,

                validator: (v) => v!.length>=6 ? null : 'RoomName must be of length 6 at least',

              ),

              TextFormField(

                controller: _roomTopicController,

                decoration: const InputDecoration(

                    hintText: 'Enter Room Topic'

                ),

              ),

              // private or public mode option here

              TextButton(

                  onPressed: (){},

                  style: ButtonStyle(

                      backgroundColor: MaterialStateProperty.all(Colors.blue)

                  ),

                  child: const Text('Create Room', style: TextStyle(color: Colors.white),)

              )

            ],

          ),
        ),

      ),

    );
  }

}