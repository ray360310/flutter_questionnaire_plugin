import 'package:flutter/cupertino.dart';
import 'package:questionnaire_plugin/questionnaire_plugin.dart';

class SentenceQuestionWidget extends StatefulWidget {

  const SentenceQuestionWidget({
    super.key,
    required this.questionData,
    required Function(int, int, OptionData) onToggleOption,
  });

  final QuestionData questionData;

  @override
  State<StatefulWidget> createState() => _SentenceQuestionWidgetState();

}

class _SentenceQuestionWidgetState extends State<SentenceQuestionWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          QuestionDisplayWidget(
            questionId: widget.questionData.id.toString(),
            isRequired: widget.questionData.isMandatory,
            questionText: widget.questionData.title,
            imageList: widget.questionData.imageList,
          ),

        ],
      ),
    );
  }

}