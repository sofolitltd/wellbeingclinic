import 'package:flutter/material.dart';

import '../models/scale_model.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    required this.index,
    required this.testItems,
    required this.testScale,
    required this.testAnswer,
  });

  final int index;
  final List testItems;
  final List testScale;
  final Map testAnswer;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  ScaleModel? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: _selectedOption == null
            ? null
            : const Border(left: BorderSide(color: Colors.indigo, width: 3,),),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //
          Container(
            color: Colors.grey.shade200,
            padding: const EdgeInsets.all(16),
            child: Text(
              '${widget.testItems[widget.index].id}. ${widget.testItems[widget.index].title}',
              style: const TextStyle(fontFamily: 'tiro'),
            ),
          ),

          //
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            color: Colors.grey.shade300,
            child: Column(
              children: widget.testScale
                  .map(
                    (option) => RadioListTile<ScaleModel>(
                      activeColor: Colors.indigo,
                      title: Text(
                        option.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'tiro',
                        ),
                      ),
                      value: option,
                      groupValue: _selectedOption,
                      onChanged: (value) {
                        print(value!.id);
                        setState(() {
                          _selectedOption = value;

                          //
                          widget.testAnswer
                              .remove(widget.testItems[widget.index].id);
                          widget.testAnswer.putIfAbsent(
                              widget.testItems[widget.index].id,
                              () => value.id);
                          print(widget.testAnswer);
                        });
                      },
                      visualDensity: const VisualDensity(vertical: -3),
                      dense: true,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
