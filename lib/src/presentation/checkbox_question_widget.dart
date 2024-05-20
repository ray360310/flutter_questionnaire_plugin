import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questionnaire_plugin/questionnaire_plugin.dart';
import 'package:questionnaire_plugin/src/domain/option_data.dart';
import 'package:questionnaire_plugin/src/domain/question_data.dart';
import 'package:questionnaire_plugin/src/domain/question_type.dart';

class CheckboxQuestionWidget extends ConsumerStatefulWidget {

  const CheckboxQuestionWidget({
    super.key,
    required this.questionData,
  });

  final QuestionData questionData;


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CheckboxQuestionWidgetState();

}

class _CheckboxQuestionWidgetState extends ConsumerState<CheckboxQuestionWidget> {

  late List<OptionData> _answers;

  @override
  void initState() {
    _answers = [];
    _answers.addAll(widget.questionData.answers);
    super.initState();
  }

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
          _buildAnswerCheckboxes(context, widget.questionData, (p0, p1, p2) => null)
        ],
      ),
    );
  }

  Widget _buildAnswerCheckboxes(
      BuildContext context,
      QuestionData question,
      Function(int, QuestionType, OptionData) onToggleOption) {
    return Column(
      children: question.options!.map((option) => _buildAnswerCheckbox(context, option, (option) {
        onToggleOption(question.id, question.type, option);
      }
      )).toList(),
    );
  }

  Widget _buildAnswerCheckbox(
      BuildContext context,
      OptionData option,
      Function(OptionData) onToggleOption) {
    return GestureDetector(
      onTap: () {
        debugPrint(option.toString());
        onToggleOption(option);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          color: _answers.contains(option)
              ? const Color(0xFFF9FBFF)
              : null,
          shape: RoundedRectangleBorder(
            side: _answers.contains(option)
                ? const BorderSide(width: 1, color: Color(0xFF2A50AC))
                : const BorderSide(width: 1, color: Color(0xFF737373)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Checkbox(
              activeColor: const Color(0xFF2A50AC),
              value: _answers.contains(option),
              onChanged: (value) {
                onToggleOption(option);
              },
            ),
            const SizedBox(width: 8,),
            Flexible(
              child: Text(
                  option.name,
                  style: const TextStyle(
                    color: Color(0xFF818181),
                    fontSize: 18,
                    fontFamily: 'PingFang TC',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.32,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

}