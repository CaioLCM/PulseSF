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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text("San Francisco: The city where code Meets the Future", style: TextStyle(fontSize: 20, fontFamily: "Fredoka"), textAlign: TextAlign.center,),
            ),
            Text("Ever dreamed of living where tech legends are born?", style: TextStyle(fontFamily: "Fredoka"), textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 42,),
                CircleAvatar(
                  child: Image.network("https://static-00.iconduck.com/assets.00/openai-icon-2021x2048-4rpe5x7n.png"),
                ),
                SizedBox(width: 17,),
                CircleAvatar(
                  child: Image.network("https://toppng.com/uploads/preview/slack-new-logo-icon-11609376883z32jbkf8kg.png"),
                ),
                SizedBox(width: 17,),
                CircleAvatar(
                  child: Image.network("https://icon2.cleanpng.com/lnd/20241123/fe/01a0c7a4bc31fd14d50f86a45d55c0.webp"),
                ),
                SizedBox(width: 17,),
                CircleAvatar(
                  child: Image.network("https://freebiehive.com/wp-content/uploads/2023/08/X-Logo.jpg"),
                ),
                SizedBox(width: 17,),
                CircleAvatar(
                  child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjB4taolHF56evtigpyIGGNBa3QU8HH_nQ0A&s"),
                ),
                SizedBox(width: 17,),
                CircleAvatar(
                  child: Image.network("https://icon2.cleanpng.com/20180402/rae/kisspng-stripe-payment-gateway-e-commerce-payment-system-p-strips-5ac2055a0e2ff6.5263049815226647940581.jpg"),
                )
              ],
            ),
            SizedBox(height: 70,),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text("Why Techies Love It", style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("*Silicon Valley is right next door!", style: TextStyle(fontFamily: "Fredoka", color: Colors.deepOrangeAccent),),
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
            SizedBox(height: 70,),
            Text("Must-See Spots", style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),),
            SizedBox(height: 30,),
            Text("Golden Gate Bridge", style: TextStyle(fontFamily: "Fredoka", fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("A world-famous icon and perfect photo spot."),
            Text("Don't miss the view, especially at sunset!"),
            SizedBox(height: 20,),
            Container(
              height: 200,
              child: Image.network("https://upload.wikimedia.org/wikipedia/commons/b/bf/Golden_Gate_Bridge_as_seen_from_Battery_East.jpg"),
            ),
            SizedBox(height: 70,),
            Text("Computer History Museum", style: TextStyle(fontFamily: "Fredoka", fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("See how computers evolved - From ancient machines"),
            Text("to modern tech. Nerd heaven!"),
            SizedBox(height: 20,),
            Container(
              height: 200,
              child: Image.network("https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/eb/72/61/photo0jpg.jpg?w=1200&h=-1&s=1"),
            ),
            SizedBox(height: 70,),
            Text("Exploratorium", style: TextStyle(fontSize: 15, fontFamily: "Fredoka", fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("An interactive science museum where you can"),
            Text("touch, try, and experiment with everything"),
            SizedBox(height: 5,),
            Container(
              height: 200,
              child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxQh4AW_h8L317kUi-VdIHwjn35ucwtoWXUQ&s"),
            ),
            SizedBox(height: 70,),
            Text("Tech company HQs", style: TextStyle(fontFamily: "Fredoka", fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("Walk past offices of Google, OpenAI, and more."),
            Text("The future is literally being built here"),
            SizedBox(height: 20,),
            Container(height: 200, child: Image.network("https://www.shoparc.com/wp-content/uploads/2021/07/140924_12_UBER_Jason-ORear_N2_jpg.jpg"),),
            SizedBox(height: 70,),
            Text("Alcatraz and Pier 39", style: TextStyle(fontSize: 15, fontFamily: "Fredoka", fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("From prison island mysteries to sea lions and shops"),
            Text("- SF's mix of history and fun"),
            SizedBox(height: 20,),
            Container(
              height: 200,
              child: Image.network("https://upload.wikimedia.org/wikipedia/commons/f/f3/Alcatraz_Island_photo_Don_Ramey_Logan.jpg"),

            ),
            SizedBox(height: 70,),
            Text("Cool Tech Facts", style: TextStyle(fontSize: 20, fontFamily: "Fredoka"),),
            SizedBox(height: 30,), 
            Text("The first computer mouse was demoed here in 1968", style: TextStyle(fontFamily: "Fredoka", fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("It looked like a wooden block - But it changed how"),
            Text("we interact with computers forever!"),
            SizedBox(height: 30,),
            Text("OpenAI, the team behind ChatGPT, was founded in SF", style: TextStyle(fontFamily: "Fredoka", fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("Right here, AI started learning how"),
            Text("to chat like us. Wild, right?"),
            SizedBox(height: 30,),
            Text("It was one of the first cities to test self-driving cars", style: TextStyle(fontFamily: "Fredoka", fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("You might spot a car with no one driving. Seriously"),
            SizedBox(height: 30,),
            Text("Most apps you use daily? Born here", style: TextStyle(fontFamily: "Fredoka", fontSize: 15, fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Text("Instagram, Uber, Twitter, Discord... All SF babies"),
            SizedBox(height: 70,),
            Text("Culture of innovation", style: TextStyle(fontFamily: "Fredoka", fontSize: 20),),
            SizedBox(height: 15,),
            Text("Curious minds thrive here - ask questions,"),
            Text("break things, build better ones."),
            SizedBox(height: 5,), 
            Text("In SF, wild ideas turn into world-changing startups"),
            Text(""),
            Text("")
          ],
        ),
      ),
    );
  }
}




