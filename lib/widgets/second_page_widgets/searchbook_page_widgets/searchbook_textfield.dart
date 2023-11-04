import 'package:books_app/screens/result_search.dart';
import 'package:books_app/utils/colors.dart';
import 'package:flutter/material.dart';

class SearchBookTextField extends StatefulWidget {
  final String useOfTextField;
  const SearchBookTextField({Key? key, required this.useOfTextField})
      : super(key: key);

  @override
  State<SearchBookTextField> createState() => _SearchBookTextFieldState();
}

class _SearchBookTextFieldState extends State<SearchBookTextField> {
  TextEditingController mycontroller = TextEditingController();
  String userTextInput = '';
  bool finalFillColor = false;

  @override
  void initState() {
    super.initState();
    if (widget.useOfTextField == 'carrousel') {
      finalFillColor = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: mycontroller,
      maxLines: 1,
      maxLength: 20,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.search_sharp),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colores.purple, width: 4)),
        labelText: 'Type to search:',
        filled: true,
        fillColor: finalFillColor ? Colors.white : Colors.grey.withOpacity(0.2),
      ),
      enableSuggestions: true,
      onEditingComplete: () {
        setState(() {
          userTextInput = mycontroller.text;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultSearchBook(
                    searchType: 'freetext', searchSubject: userTextInput)));
      },
    );
  }

  @override
  void dispose() {
    mycontroller.dispose();
    super.dispose();
  }
}
