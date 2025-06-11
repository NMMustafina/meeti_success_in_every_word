import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';

class CommunicationStylesInfo extends StatefulWidget {
  const CommunicationStylesInfo({super.key});

  @override
  State<CommunicationStylesInfo> createState() =>
      _CommunicationStylesInfoState();
}

class _CommunicationStylesInfoState extends State<CommunicationStylesInfo> {
  final List<String> _b = [
    'Friendly style',
    'Neutral style',
    'Aggressive style',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorM.background,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: ColorM.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorM.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Communication styles',
          style: TextStyle(
            color: ColorM.white,
            fontWeight: FontWeight.w500,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.0.r),
            child: Column(
              children: [
                _c(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _c() {
    return Column(
      children: List.generate(_b.length, (i) {
        return Card(
          color: Color(0xFF252B30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          margin: EdgeInsets.only(bottom: 16.h),
          child: ExpansionTile(
            shape: Border(),
            collapsedIconColor: ColorM.blue,
            iconColor: ColorM.blue,
            title: Text(
              _b[i],
              style: TextStyle(
                color: ColorM.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: _d(i),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _d(int i) {
    switch (i) {
      case 0:
        return _e();
      case 1:
        return _f();
      case 2:
        return _g();
      default:
        return Container();
    }
  }

  Widget _e() {
    final h = [
      {
        'title': 'Tone of communication:',
        'content':
            'Use a positive and polite tone. Begin with a greeting and express gratitude for your cooperation.'
      },
      {
        'title': 'Active listening:',
        'content':
            'Show that you value the other person\'s opinion. Ask clarifying questions and paraphrase his or her words to confirm understanding.'
      },
      {
        'title': 'Empathy:',
        'content':
            'Try to understand the feelings and needs of others. This will help create trust and strengthen relationships.'
      },
      {
        'title': 'Clarity and conciseness:',
        'content':
            'Be clear and concise, avoiding complex terms and jargon when inappropriate.'
      },
      {
        'title': 'Non-verbal communication:',
        'content':
            'Pay attention to body language, facial expressions and gestures. A friendly smile and open posture can make communication more comfortable.'
      },
      {
        'title': 'Positive language:',
        'content':
            'Try to use constructive and encouraging language, even when it comes to criticism or suggestions for improvement.'
      },
      {
        'title': 'Respect for time:',
        'content':
            'Be punctual and respect your interlocutor\'s time. If you\'re running late, be sure to let them know.'
      },
      {
        'title': 'Feedback:',
        'content':
            'Provide and solicit feedback on a regular basis. This will help improve interactions and identify potential problems.'
      },
      {
        'title': 'Culture of gratitude:',
        'content':
            'Don\'t forget to thank your colleagues for their help and support. This creates a positive climate in the team.'
      },
      {
        'title': 'Adapt your communication style:',
        'content':
            'Take into account the individual characteristics of your interlocutor and adapt your communication style depending on the situation.'
      },
    ];

    return _j(h);
  }

  Widget _f() {
    final h = [
      {
        'title': 'Clarity and accuracy:',
        'content':
            'Use simple and clear language. Avoid jargon and complex terms unless they are necessary.'
      },
      {
        'title': 'Structure:',
        'content':
            'Structure your messages. Start with the main idea, then provide details and conclude with conclusions or recommendations.'
      },
      {
        'title': 'Objectivity:',
        'content':
            'Avoid emotionally colored words and phrases. Focus on facts and data.'
      },
      {
        'title': 'Courtesy:',
        'content':
            'Use polite forms of address and expressions of gratitude. This helps to create a positive impression.'
      },
      {
        'title': 'Adapt to the audience:',
        'content':
            'Consider the knowledge level and interests of your audience. This will help make communication more effective.'
      },
      {
        'title': 'Active listening:',
        'content':
            'It is important to listen as well as speak. Make sure you understand the other person\'s point of view and are willing to engage in a dialog.'
      },
      {
        'title': 'Tone:',
        'content':
            'The tone should be professional and respectful, even if you are discussing difficult or controversial topics.'
      },
      {
        'title': 'Give feedback:',
        'content':
            'Remember to ask for and provide feedback. This will help improve communication and understand how well your messages were understood.'
      },
    ];

    return _j(h);
  }

  Widget _g() {
    final h = [
      {
        'title': 'Clear and confident:',
        'content':
            'Speak directly and confidently. State your thoughts without hesitation or uncertainty.'
      },
      {
        'title': 'Use strong words:',
        'content':
            'Use active verbs and confident statements. For example, instead of "I think" use "I am sure."'
      },
      {
        'title': 'Don\'t be afraid of conflict:',
        'content':
            'If you have disagreements, don\'t avoid them. Discuss problems openly and directly.'
      },
      {
        'title': 'Set boundaries:',
        'content':
            'Make your expectations and boundaries clear. This will help prevent misunderstandings.'
      },
      {
        'title': 'Control your emotions:',
        'content':
            'Despite your aggressive style, try to control your emotions. Don\'t let anger or irritation take over.'
      },
      {
        'title': 'Listen to your opponent:',
        'content':
            'Even with an aggressive style, it is important to listen to the other side. This will help you better understand their position and find a compromise.'
      },
      {
        'title': 'Focus on the result:',
        'content':
            'Focus on achieving specific goals rather than personal attacks.'
      },
      {
        'title': 'Use non-verbal cues:',
        'content':
            'Your body and facial expressions can reinforce your message. A confident posture and eye contact can emphasize your determination.'
      },
    ];

    return _j(h);
  }

  Widget _j(List<Map<String, String>> k) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: k.map((m) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              m['title']!,
              style: TextStyle(
                color: ColorM.blue,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              m['content']!,
              style: TextStyle(
                color: ColorM.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.h),
          ],
        );
      }).toList(),
    );
  }
}
