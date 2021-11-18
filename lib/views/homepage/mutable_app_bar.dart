
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MutableAppBar extends StatefulWidget{

  final Function onSearch;

  const MutableAppBar({required this.onSearch ,Key? key}) : super(key: key);

  @override

  // ignore: no_logic_in_create_state
  _MutableAppBarState createState() => _MutableAppBarState( onSearch: onSearch );

}

class _MutableAppBarState extends State<MutableAppBar>{

  final Function onSearch;

  bool _isSearchMode = false;

  void _toggleSearchMode() => setState(() => _isSearchMode=!_isSearchMode);

  _MutableAppBarState({ required this.onSearch });

  @override
  Widget build(BuildContext context) {

    return AppBar(

      centerTitle: true,

      title: _isSearchMode ? TextField(

        onSubmitted: (String value) => onSearch(value),

      ) : const Text('UniHub'),

      actions: [

        IconButton(

            onPressed: _toggleSearchMode,

            icon: !_isSearchMode ? const Icon(Icons.search_outlined, color: Colors.white,) : const Icon(Icons.close, color: Colors.white,)

        )

      ],

    );
  }

}