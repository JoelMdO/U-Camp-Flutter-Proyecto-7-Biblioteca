import 'package:books_app/screens/result_search.dart';
import 'package:books_app/utils/colors.dart';
import 'package:books_app/utils/shapes/triangle.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBookDropdownMenu extends StatefulWidget {
  const SearchBookDropdownMenu({Key? key}) : super(key: key);

  @override
  State<SearchBookDropdownMenu> createState() => _SearchBookDropdownMenuState();
}

class _SearchBookDropdownMenuState extends State<SearchBookDropdownMenu> {
  final TextEditingController myController = TextEditingController();
  List<DropdownMenuItem<String>> get categories {
    List<DropdownMenuItem<String>> categoryItems = [
      const DropdownMenuItem(value: "Select", child: Text('Select')),
      const DropdownMenuItem(value: "Arts", child: Text('Arts')),
      const DropdownMenuItem(value: "Crime", child: Text('Crime')),
      const DropdownMenuItem(value: "Drama", child: Text('Drama')),
      const DropdownMenuItem(value: "Fiction", child: Text('Fiction')),
      const DropdownMenuItem(value: "Romance", child: Text('Romance')),
      const DropdownMenuItem(value: "Science", child: Text('Science')),
      const DropdownMenuItem(value: "Self-help", child: Text('Self-help')),
      const DropdownMenuItem(value: "Terror", child: Text('Terror')),
      const DropdownMenuItem(value: "Technology", child: Text('Technology')),
    ];
    return categoryItems;
  }

  String selectedCategory = 'Select';

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items: categories,
      icon: Transform.rotate(
        angle: math.pi,
        child: ClipPath(
          clipper: TriangleShape(),
          child: Container(
            width: 15,
            height: 15,
            color: Colores.orange,
          ),
        ),
      ),
      dropdownColor: Colores.purple,
      style: GoogleFonts.inder(color: Colors.white, fontSize: 15),
      onChanged: (String? value) {
        setState(() {
          selectedCategory = value!;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultSearchBook(
                    searchType: 'genre', searchSubject: selectedCategory)));
        selectedCategory = 'Select';
      },
    );
  }
}
