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
          border: Border.all(
            color: _selectedOption == null ? Colors.transparent : Colors.indigo,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              '${widget.testItems[widget.index].id}. ${widget.testItems[widget.index].title}',
              style: const TextStyle(fontFamily: 'tiro'),
            ),
          ),

          //
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
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
