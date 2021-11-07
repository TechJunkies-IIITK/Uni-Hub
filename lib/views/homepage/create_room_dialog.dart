
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unihub/controllers/socket_controller.dart';
import 'package:unihub/views/snackbar.dart';

class CreateRoomDialog extends StatefulWidget{

  const CreateRoomDialog({Key? key}) : super(key: key);

  @override

  _CreateRoomDialogState createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<CreateRoomDialog>{

  late final TextEditingController _roomNameController;

  late final TextEditingController _roomTopicController;

  bool _isPublic = true;

  void _toggle() => setState(() => _isPublic=!_isPublic);


  @override
  void initState() {

    super.initState();

    _roomTopicController = TextEditingController();

    _roomNameController = TextEditingController();

  }


  @override
  void dispose() {

    super.dispose();

    _roomNameController.dispose();

    _roomTopicController.dispose();

  }

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

                validator: (v) => v!.length>=4 ? null : 'RoomName must be of length 6 at least',

              ),

              TextFormField(

                controller: _roomTopicController,

                decoration: const InputDecoration(

                    hintText: 'Enter Room Topic'

                ),

              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  Expanded(

                    child: Column(

                      children: [

                        Radio(
                            value: true,

                            groupValue: _isPublic,

                            onChanged: (b)=>_toggle()

                        ),

                        Stack(

                          alignment: Alignment.center,

                          children: const [

                            Icon(Icons.public, size: 100, color: Colors.deepPurple,),

                            Icon(Icons.lock_open_outlined, size: 40, color: Colors.green,)

                          ],

                        ),

                        const Text('Public')

                      ],

                    ),

                  ),

                  Expanded(

                    child: Column(

                      children: [

                        Radio(
                            value: false,

                            groupValue: _isPublic,

                            onChanged: (b)=>_toggle()
                        ),

                        Stack(

                          alignment: Alignment.center,

                          children: const [

                            Icon(Icons.public, size: 100, color: Colors.blueAccent,),

                            Icon(Icons.lock, size: 40, color: Colors.red,)

                          ],

                        ),

                        const Text('Private')

                      ],

                    ),

                  )

                ],

              ),

              TextButton(

                  onPressed: (){

                    if(_roomNameController.text.length>=4){

                      SocketController.socket.emit('create',{

                        'hubName': _roomNameController.text,

                        'hubTopic': _roomTopicController.text,

                        'isPublic': _isPublic

                      });

                    } else {

                      showSnackBar('Invalid RoomName', context, SnackBarType.error);

                    }

                  },

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