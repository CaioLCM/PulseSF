import 'package:flutter/material.dart';

class AboutsfPage extends StatelessWidget {
  const AboutsfPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About San Francisco",
          style: TextStyle(color: Colors.white, fontFamily: "Fredoka"),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text("San Fracisco: The city where code Meets the Future", style: TextStyle(fontSize: 20, fontFamily: "Fredoka"), textAlign: TextAlign.center,),
          ),
          Text("Ever dreamed of living where tech legends are born?", style: TextStyle(fontFamily: "Fredoka"), textAlign: TextAlign.center,),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 50,),
              CircleAvatar(
                child: Image.network("https://static-00.iconduck.com/assets.00/openai-icon-2021x2048-4rpe5x7n.png"),
              ),
              SizedBox(width: 15,),
              CircleAvatar(
                child: Image.network("https://toppng.com/uploads/preview/slack-new-logo-icon-11609376883z32jbkf8kg.png"),
              ),
              SizedBox(width: 15,),
              CircleAvatar(
                child: Image.network("https://icon2.cleanpng.com/lnd/20241123/fe/01a0c7a4bc31fd14d50f86a45d55c0.webp"),
              ),
              SizedBox(width: 15,),
              CircleAvatar(
                child: Image.network("https://freebiehive.com/wp-content/uploads/2023/08/X-Logo.jpg"),
              ),
              SizedBox(width: 15,),
              CircleAvatar(
                child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjB4taolHF56evtigpyIGGNBa3QU8HH_nQ0A&s"),
              ),
              SizedBox(width: 15,),
              CircleAvatar(
                child: Image.network("https://icon2.cleanpng.com/20180402/rae/kisspng-stripe-payment-gateway-e-commerce-payment-system-p-strips-5ac2055a0e2ff6.5263049815226647940581.jpg"),
              )
            ],
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(13.0),
            child: Text("Why Techies Love It", style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("*Sillicon Valley is right next door!", style: TextStyle(fontFamily: "Fredoka", color: Colors.deepOrangeAccent),),
              Text(" - home to:")
            ],
          ),
          Text("Apple, Google, Meta, Nvidia and OpenAI", style: TextStyle(fontFamily: "Fredoka")),
          SizedBox(height: 15,),
          Row(
            children: [
              SizedBox(width: 92,),
              Text("*Close to Stanford and UC Berkeley"),
            ],
          ),
          SizedBox(height: 45,),
          Text("Must-See Spots", style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),),
          SizedBox(height: 15,),
          Text("Golden Gate Bridge"),
          SizedBox(height: 15,),
          Text("Computer History Museum"),
          SizedBox(height: 15,),
          Text("Exploratorium"),
          SizedBox(height: 15,),
          Text("Tech company HQs"),
          SizedBox(height: 15,),
          Text("Alcatraz e Pier 39")
        ],
      ),
    );
  }
}
