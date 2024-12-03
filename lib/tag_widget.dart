import 'package:bestloop_app/shared.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

typedef DeleteTag<T> = void Function(T index);
typedef TagTitle<String> = Widget Function(String tag);

class SmallTag extends StatefulWidget {
  SmallTag({
    required this.tags,
    this.minTagViewHeight = 0,
    this.maxTagViewHeight = 150,
    this.tagBackgroundColor = Colors.transparent, 
    this.selectedTagBackgroundColor = Colors.lightBlue,
    this.deletableTag = true,
    this.onDeleteTag,
    this.tagTitle,
  });

  final List<String> tags;
  final Color tagBackgroundColor;
  final Color selectedTagBackgroundColor;
  final bool deletableTag;
  final double maxTagViewHeight;
  final double minTagViewHeight;
  final DeleteTag<int>? onDeleteTag;
  final TagTitle<String>? tagTitle;

  @override
  _SmallTagState createState() => _SmallTagState();
}

class _SmallTagState extends State<SmallTag> {
  List<int> selectedTagIndices = [];
  int selectedTagIndex = -1;

  @override
  Widget build(BuildContext context) {
    return getTagView();
  }

  Widget getTagView() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.minTagViewHeight,
        maxHeight: widget.maxTagViewHeight,
      ),
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 6.0, // Adjust for spacing between entries horizontally
          runSpacing: 4.0, // Adjust for vertical spacing between tags
          direction: Axis.horizontal,
          children: buildTags(),
        ),
      ),
    );
  }

  List<Widget> buildTags() {
    List<Widget> tags = <Widget>[];
    for (int i = 0; i < widget.tags.length; i++) {
      tags.add(createTag(i, widget.tags[i]));
    }
    // Add the plus icon tag at the end
    tags.add(createAddTag());
    return tags;
  }

  Widget createTag(int index, String tagTitle) {
    return InkWell(
      onTap: () {
        setState(() {
          if (tagTitle != "+") {
            if (selectedTagIndices.contains(index)) {
              selectedTagIndices.remove(index);
            } else {
              selectedTagIndices.add(index);
            }
            selectedTagIndex = index;
            print(index);
          }
        });
      },
      child: Container(
        height: 16.0,
        padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjust left padding of text
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: selectedTagIndices.contains(index)
                ? LinearGradient(colors: [const Color.fromARGB(255, 30, 233, 172), const Color.fromARGB(255, 46, 10, 177)])
                : BestLoopColors.primaryGradient,
            width: 1, // Line width
          ),
          borderRadius: BorderRadius.circular(8), // Amount of circleness
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.tagTitle == null
                ? Text(tagTitle, style: Theme.of(context).textTheme.bodySmall)
                : widget.tagTitle!(tagTitle),
          ],
        ),
      ),
    );
  }

  Widget createAddTag() {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            String newTag = '';
            return AlertDialog(
              backgroundColor: Colors.grey[800], // Grey background
              title: Text('Add Tag', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white)),
              content: TextField(
                onChanged: (value) {
                  newTag = value;
                },
                style: TextStyle(color: Colors.white), // Dark text color
                decoration: InputDecoration(
                  hintText: "Enter tag text",
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[700], // Dark text box
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Add', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      widget.tags.add(newTag);
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        height: 16.0,
        width: 16.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: GradientBoxBorder(
            gradient: BestLoopColors.primaryGradient,
            width: 1, // Line width
          ),
        ),
        child: Icon(Icons.add, size: 12.0, color: Colors.white),
      ),
    );
  }

  void deleteTag(int index) {
    if (widget.onDeleteTag != null) {
      widget.onDeleteTag!(index);
    } else {
      setState(() {
        widget.tags.removeAt(index);
      });
    }
  }
}