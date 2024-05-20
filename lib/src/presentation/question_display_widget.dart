import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionDisplayWidget extends ConsumerStatefulWidget {

  const QuestionDisplayWidget({
    super.key,
    required this.questionId,
    required this.isRequired,
    this.questionText,
    this.imageList,
  });

  final String questionId;
  final bool isRequired;
  final String? questionText;
  final List<String>? imageList;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionDisplayWidgetState();

}

class _QuestionDisplayWidgetState extends ConsumerState<QuestionDisplayWidget> {

  var verticalMargin = 10.0;
  var carouselImageHeight = 300.0;

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _questionId(widget.questionId),
              const SizedBox(width: 4,),
              if(widget.isRequired)...[
                _questionRequired(),
              ],
            ],
          ),
          SizedBox(height: verticalMargin,),
          Visibility(
            visible: widget.questionText != null || widget.questionText!.isNotEmpty,
            child: _questionText(widget.questionText),
          ),
          Visibility(
            visible: widget.imageList != null || widget.imageList!.isNotEmpty,
            child: _questionImageView(widget.imageList),
          ),
        ],
      ),
    );
  }

  Widget _questionId(String questionId) {
    return Text(
      questionId,
      style: const TextStyle(
        color: Color(0xFF0076AE),
        fontSize: 40,
        fontFamily: 'Karla',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _questionRequired() {
    return const Text(
      ' (必填)',
      style: TextStyle(
        color: Color(0xFF898989),
        fontSize: 16,
        fontFamily: 'Noto Sans TC',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _questionText(String? questionText) {
    return Container(
      margin: EdgeInsets.only(bottom: verticalMargin),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Text(
              questionText ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Noto Sans TC',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _questionImageView(List<String>? imageList) {
    if(widget.imageList != null || widget.imageList!.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(bottom: verticalMargin),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                    height: carouselImageHeight,
                    viewportFraction: 1.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }
                ),
                items: imageList!.map((imageUrl) {
                  return Builder(
                    builder: (context) {
                      return Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 85,
                              width: 85,
                              color: Colors.grey,
                            );
                          }
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }else {
      return Container();
    }
  }



}