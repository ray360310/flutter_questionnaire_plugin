import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:questionnaire_plugin/questionnaire_plugin.dart';


class QuestionCardViewWidget extends StatefulWidget {

  const QuestionCardViewWidget({
    super.key,
    required this.questionData,
    required Function(int, int, OptionData) onToggleOption,
  });

  final QuestionData questionData;

  @override
  State<StatefulWidget> createState() => _QuestionCardViewWidgetState();

}

class _QuestionCardViewWidgetState extends State<QuestionCardViewWidget> {

  ///multiple answers question
  late List<OptionData> _answers;

  ///single answer question
  OptionData? _selectedAnswer;

  @override
  void initState() {
    if(widget.questionData.type == QuestionType.multipleChoice) {
      _answers = [];
      _answers.addAll(widget.questionData.answers);
    }else if(widget.questionData.type == QuestionType.singleChoice) {
      if (widget.questionData.answers.isNotEmpty) {
        _selectedAnswer = widget.questionData.answers.first;
      }
    }else {
      //TODO: need sentence answer
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
          _buildAnswerView(),
        ],
      ),
    );
  }

  Widget _buildAnswerView() {
    switch (widget.questionData.type) {
      case QuestionType.multipleChoice:
        return _buildAnswerCheckboxes(context, widget.questionData, (p0, p1, p2) => null);
      case QuestionType.singleChoice:
        return _buildAnswerRadiobtns(context, widget.questionData, (p0, p1, p2) => null);
      case QuestionType.sentenceAnswer:
        return Container();
    }
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