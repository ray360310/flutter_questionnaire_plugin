import 'package:equatable/equatable.dart';
import 'package:questionnaire_plugin/src/domain/option_data.dart';
import 'package:questionnaire_plugin/src/domain/question_type.dart';

class QuestionData extends Equatable {

  QuestionData({
    required this.id,
    required this.type,
    this.title,
    this.imageList,
    required this.isMandatory,
    List<OptionData>? options,
    List<OptionData>? answers,
  }):answers = answers ?? [],
        options = options ?? [];


  final int id;
  final QuestionType type;
  final String? title;
  final List<String>? imageList;
  final bool isMandatory;
  final List<OptionData>? options;
  late final List<OptionData> answers;

  @override
  List<Object?> get props => [id, type, title, imageList, isMandatory];

}

//class QuestionnaireQuestion {
//   final int id;
//   final int type;
//   final String title;
//   final bool isRequired;
//   List<QuestionnaireOption> options = <QuestionnaireOption>[];
//
//   QuestionnaireQuestion({required QuestionData questionData})
//       : id = questionData.id,
//         type = questionData.type,
//         title = questionData.title,
//         isRequired = questionData.isRequired,
//         options = questionData.options.map((option) => QuestionnaireOption(option)).toList();
//
//   void toggleOption(int optionId) {
//     if (type == QuestionType.singleChoice.value) {
//       for (var option in options) {
//         option.selected = option.id == optionId;
//       }
//     } else if (type == QuestionType.multipleChoice.value) {
//       final index = options.indexWhere((element) => element.id == optionId);
//       options[index].selected = !options[index].selected;
//     }
//   }
//
// }