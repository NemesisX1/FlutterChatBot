import 'package:flutter/material.dart';
import 'package:TemplateBot_DialogFlow/dialogflow/dialogflow_v2.dart';
import 'package:TemplateBot_DialogFlow/widget/custom_widget.dart';
import 'package:TemplateBot_DialogFlow/sms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Epitech Chatbot',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ChatBot(
          isEpitech: false,
        ));
  }
}

class AppBar extends StatelessWidget {
  final bool isEpitech;

  AppBar({this.isEpitech});

  @override
  Widget build(BuildContext context) {
    return (CustomAppBar(
      compenants: [
        Expanded(
          child: SizedBox(),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * (0.19)),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Nao Marvin Jr",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
            )),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}

class ChatBot extends StatefulWidget {
  ChatBot({Key key, this.isEpitech}) : super(key: key);
  final bool isEpitech;
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  List<Widget> messageList = [
    Sms('bot', "Je te suis 👽"),
  ];

  void agentResponse(query) async {
    _controller.clear();
    AuthGoogle authGoogle = await AuthGoogle(fileJson: "asset/bot.json")
        .build(); //N'hésitez pas à modifier le contenu du bot.json avec vous propres informations
    Dialogflow dialogFlow = Dialogflow(authGoogle: authGoogle, language: "fr");
    AIResponse response = await dialogFlow.detectIntent(query);
    Sms message = Sms(
        'bot',
        response.getMessage() ??
            CardDialogflow(response.getListMessage()[0]).title);
    setState(() {
      messageList.insert(0, message);
    });
  }

  _sendingTexto(String texto) async {
    Sms usrSms = Sms('user', texto);

    setState(() {
      if (_controller.text == 'kClear')
        messageList.clear();
      else
        messageList.insert(0, usrSms);
    });
    agentResponse(texto.isEmpty ? "Reessayer svp !" : texto);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(isEpitech: widget.isEpitech),
      ),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true, //To keep the latest messages at the bottom
            itemBuilder: (_, int index) => messageList[index],
            itemCount: messageList.length,
          )),
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (value) => _sendingTexto(
                          value), //A enlever quand on est sur mobile
                      decoration:
                          InputDecoration.collapsed(hintText: "Ecrivez ici !"),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).accentColor),
                  onPressed: () => _sendingTexto(_controller.text),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
