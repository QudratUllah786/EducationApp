import 'package:flutter/material.dart';
class OptionTile extends StatefulWidget {
  final String option,description,correctAnswer,optionSelected;
  OptionTile({
    required this.description,
    required this.correctAnswer,
    required this.option,
    required this.optionSelected,
});
  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
             shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                color:widget.description == widget.optionSelected?
                    widget.optionSelected == widget.correctAnswer?
                        Colors.green.withOpacity(0.7)
                        :Colors.red.withOpacity(0.7):Colors.grey

              )
            ),
            child: Text('${widget.option}',style: TextStyle(
              color: widget.optionSelected == widget.description?
                  widget.correctAnswer == widget.optionSelected?
                      Colors.green.withOpacity(0.3):
                      Colors.red
                      :Colors.black54
            ),),
          ),
          SizedBox(width: 8,),
          Text(widget.description,style: TextStyle(
            fontSize: 17,
            color: Colors.black54
          ),)
        ],
      ),
    );
  }
}
