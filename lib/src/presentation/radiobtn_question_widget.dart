import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:questionnaire_plugin/questionnaire_plugin.dart';
import 'package:questionnaire_plugin/src/domain/question_type.dart';

class RadiobtnQuestionWidget extends ConsumerStatefulWidget {

  const RadiobtnQuestionWidget({
    super.key,
    required this.questionData,
    required Function(int, int, OptionData) onToggleOption,
  });

  final QuestionData questionData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RadiobtnQuestionWidgetState();

}

class _RadiobtnQuestionWidgetState extends ConsumerState<RadiobtnQuestionWidget> {

  OptionData? _selectedAnswer;

  @override
  void initState() {
    if (widget.questionData.answers.isNotEmpty) {
      _selectedAnswer = widget.questionData.answers.first;
    }
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
          _buildAnswerRadiobtns(context, widget.questionData, (p0, p1, p2) => null)
        ],
      ),
    );
  }

  Widget _buildAnswerRadiobtns(
      BuildContext context,
      QuestionData question,
      Function(int, QuestionType, OptionData) onToggleOption) {
    return Column(
      children: question.options!.map((option) => _buildAnswerRadioButton(
          context,
          option,
              (option) {
                onToggleOption(question.id, question.type, option);
                setState(() {

                });
          }
      )).toList(),
    );
  }

  Widget _buildAnswerRadioButton(
      BuildContext context,
      OptionData option,
      Function(OptionData) pickOption) {
    return GestureDetector(
      onTap: () {
        debugPrint(option.toString());
        pickOption(option);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
              color: option == _selectedAnswer
                  ? const Color(0xFFF9FBFF)
                  : null,
              shape: RoundedRectangleBorder(
                side: option == _selectedAnswer
                    ? const BorderSide(width: 1, color: Color(0xFF2A50AC))
                    : const BorderSide(width: 1, color: Color(0xFF737373)),
                borderRadius: BorderRadius.circular(10),
              )
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Radio<OptionData?>(
                      activeColor: const Color(0xFF2A50AC),
                      value: option,
                      groupValue: option == _selectedAnswer ? option : null,
                      onChanged: (value) {
                        pickOption(option);
                      }
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    option.name,
                    style: const TextStyle(
                      color: Color(0xFF737373),
                      fontSize: 18,
                      fontFamily: 'PingFang TC',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.36,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}