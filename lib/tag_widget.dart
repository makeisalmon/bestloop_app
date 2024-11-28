import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

typedef DeleteTag<T> = void Function(T index);
typedef TagTitle<String> = Widget Function(String tag);
/*
  HEAVY HELP FROM https://knnx.medium.com/how-to-build-a-tags-widget-in-flutter-7944cf870476 

  Add functionality postponed until figured out in general. Issue with adding icon is spacing with text, which to my knowledge cant
  be fixed. This is okay, because to my knowledge the only time the add button is needed is at the end, not at every widget. 
  Comments show where to edit to get changes. this.maxTagView acts as the box, can be adjusted as necessary.

  My idea to get full functionality it to just always make the last tag an add button, which onpressed creates a tag. Who knows...
*/
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
  }) : assert(tags.isNotEmpty, 'Tags can\'t be empty\nProvide the list of tags');

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
        scrollDirection: Axis.horizontal,
        child: Row(
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
    return tags;
  }

  Widget createTag(int index, String tagTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0), // Padding between tags
      child: InkWell(
        onTap: () {
          setState(() {
            selectedTagIndex = index;
          });
        },
        child: Container(
          height:20,
          padding: const EdgeInsets.symmetric(horizontal: 8.0 ), // Padding inside the tag
          decoration: BoxDecoration(
            border: const GradientBoxBorder(
              gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
              width: 1, // Line width
            ),
            borderRadius: BorderRadius.circular(20), // Border radius
          ),
          child: Center(
            child: Text(
              tagTitle,
              style: TextStyle(fontSize: 16, color: Colors.white), // Text style
            ),
          ),
        ),
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