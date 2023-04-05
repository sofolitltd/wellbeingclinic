import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    Key? key,
    required this.index,
    required this.testItems,
    required this.testScale,
    required this.testAnswer,
  }) : super(key: key);
  final int index;
  final List testItems;
  final List testScale;
  final Map testAnswer;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  int _selectedOption = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //
        Container(
          color: Colors.grey.shade200,
          padding: const EdgeInsets.all(16),
          child: Text(
            '${widget.testItems[widget.index].id}. ${widget.testItems[widget.index].title}',
            style: GoogleFonts.tiroBangla(),
          ),
        ),

        //
        Container(
          height: 48,
          color: Colors.grey.shade300,
          child: Row(
            children: widget.testScale
                .map((e) => Expanded(
                      child: RadioButton<int>(
                        description: e.toString(),
                        value: e,
                        groupValue: _selectedOption,
                        onChanged: (value) {
                          _selectedOption = value!;

                          widget.testAnswer
                              .remove(widget.testItems[widget.index].id);
                          widget.testAnswer.putIfAbsent(
                              widget.testItems[widget.index].id, () => value);
                          print(widget.testAnswer);

                          //
                          setState(() {});
                        },
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
