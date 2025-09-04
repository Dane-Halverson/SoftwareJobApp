import 'package:flutter/material.dart';

// Create a journal for user to write notes...
class JournalEntry {
  String companyTitle;
  String body;
  double? rating;
  late DateTime date;

  JournalEntry({required this.companyTitle, required this.body, this.rating}) {
    date = DateTime.now();
  }

}

class Journal {
  late List<JournalEntry> entries;

  Journal() {
    entries = [];
  }

  void addEntry(JournalEntry entry) {
    entries.add(entry);
  }

  void removeEntry(int index) {
    entries.removeAt(index);
  }
}

class JobsPage extends StatefulWidget {
  final journal = Journal();

  JobsPage({super.key});

  @override
  State<JobsPage> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JobsPage> {
  void _addEntry() async {
    String title = await _showTextInputDialog('Entry Title');
    String body = await _showTextInputDialog('Entry Body');

    if (title.isNotEmpty && body.isNotEmpty) {
      JournalEntry entry = JournalEntry(companyTitle: title, body: body);
      setState(() {
        widget.journal.addEntry(entry);
      });
    }
  }

  void _removeEntry(int index) {
    setState(() {
      widget.journal.removeEntry(index);
    });
  }

  Future<String> _showTextInputDialog(String title) async {
    TextEditingController controller = TextEditingController();

    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter $title',
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context, controller.text),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.journal.entries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(widget.journal.entries[index].companyTitle),
            subtitle: Text(widget.journal.entries[index].date.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _removeEntry(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addEntry,
      ),
    );
  }
}

class NumericSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double currentValue;
  final ValueChanged<double> onChanged;

  NumericSlider({
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
    required this.onChanged,
  });

  @override
  _NumericSliderState createState() => _NumericSliderState();
}

class _NumericSliderState extends State<NumericSlider> {
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _value = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('${_value.toStringAsFixed(1)}'),
        SizedBox(width: 10.0),
        Expanded(
          child: Slider(
            value: _value,
            min: widget.minValue,
            max: widget.maxValue,
            divisions: ((widget.maxValue - widget.minValue) / 0.1).round(),
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
                widget.onChanged(newValue);
              });
            },
          ),
        ),
      ],
    );
  }
}
