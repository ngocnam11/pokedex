import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String>? listType;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;

  const MultiSelectChip({
    super.key,
    this.listType,
    this.onSelectionChanged,
    this.onMaxSelected,
    this.maxSelection,
  });

  @override
  State<MultiSelectChip> createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> types = [
    "Bug",
    "Dark",
    "Dragon",
    "Electric",
    "Fairy",
    "Fighting",
    "Fire",
    "Flying",
    "Ghost",
    "Grass",
    "Ground",
    "Ice",
    "Normal",
    "Poison",
    "Psychic",
    "Rock",
    "Steel",
    "Water",
  ];

  List<String> selectedChoices = [];

  @override
  void initState() {
    selectedChoices = widget.listType ?? [];
    super.initState();
  }

  _buildChoiceList() {
    List<Widget> choices = [];

    for (var type in types) {
      choices.add(
        Container(
          padding: const EdgeInsets.all(4.0),
          child: ChoiceChip(
            label: Text(type),
            selected: selectedChoices.contains(type),
            onSelected: (selected) {
              if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                  !selectedChoices.contains(type)) {
                widget.onMaxSelected?.call(selectedChoices);
              } else {
                setState(() {
                  selectedChoices.contains(type)
                      ? selectedChoices.remove(type)
                      : selectedChoices.add(type);
                  widget.onSelectionChanged?.call(selectedChoices);
                });
              }
            },
            selectedColor: Colors.blue,
          ),
        ),
      );
    }

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
