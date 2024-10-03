import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:yolo_deepsort/common/color.dart';
import 'package:yolo_deepsort/common/style.dart';
import 'package:yolo_deepsort/secrets.dart';

class InfoPage extends StatelessWidget {
  final String info;

  const InfoPage({
    super.key,
    required this.info,
  });

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  Future<String> fetchInformationFromGemini(String info) async {
    const apiKey = GOOGLE_GEMINI_API_KEY;
    final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=$apiKey');

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": "Explain the $info algorithm."}
          ]
        }
      ]
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['candidates'] != null &&
          jsonData['candidates'].isNotEmpty &&
          jsonData['candidates'][0]['content'] != null &&
          jsonData['candidates'][0]['content']['parts'] != null &&
          jsonData['candidates'][0]['content']['parts'].isNotEmpty) {
        final textResponse =
            jsonData['candidates'][0]['content']['parts'][0]['text'];
        return textResponse ?? 'No information available for this topic.';
      } else {
        return 'Unexpected response structure: ${response.body}';
      }
    } else {
      return 'Failed to load information: ${response.body}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryRegularColor,
        title: Text(
          info,
          style: AppTextStyle.primaryTextStyle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => goBack(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: fetchInformationFromGemini(info),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error loading information: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  children: [
                    Text(
                      getInfoText(info, snapshot.data ?? ''),
                      style: AppTextStyle.secondaryBlackTextStyle
                          .copyWith(color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('No Information available'),
              );
            }
          },
        ),
      ),
    );
  }
}

String getInfoText(String info, String fetchedInfo) {
  switch (info.toLowerCase()) {
    case 'yolo':
      return 'YOLO (You Only Look Once): $fetchedInfo';
    case 'deepsort':
      return 'DeepSort: $fetchedInfo';
    default:
      return 'Information about this topic is currently unavailable.';
  }
}
