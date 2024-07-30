import 'package:ai_friend/domain/entity/i_assistant/i_assistant.dart';
import 'package:ai_friend/domain/entity/i_script_day/i_script_day.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireDatabase {
  final _db = FirebaseFirestore.instance;

  Future<List<IAssistant>> getAssistants() async {
    List<IAssistant> assistants = [];
    final data = await _db.collection("assistants").get();

    for (var doc in data.docs) {
      final profile = IAssistant.fromMap(doc.data());
      assistants.add(profile);
    }

    return assistants;
  }

  // Future<List<IScriptDay>> getScript() async {
  //   List<IScriptDay> data = [];
  //   final collection = await _db.collection("script").get();
  //   print('collection: ${collection.docs.length}');
  //   // for (var doc in collection.docs) {
  //   //   final script = IScriptDay.fromMap(doc.data());
  //   //   print('script : ${script.toString()}');
  //   //   data.add(script);
  //   // }

  //   return data;
  // }

  Future<List<IScriptDay>> getScript(String assistantId) async {
    // FirebaseFirestore firestore = FirebaseFirestore.instance;

    final snapshot = await _db.collection('script').doc(assistantId).get();

    if (snapshot.exists) {
      List<dynamic> data = snapshot.get('data');
      return data.map((e) => IScriptDay.fromMap(e)).toList();
    } else {
      throw Exception("Document does not exist");
    }
  }
  // Future<void> uploadData() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   CollectionReference scriptsCollection = firestore.collection('script');
  //   CollectionReference aliceSubCollection =
  //       scriptsCollection.doc('alice').collection('data');

  //   for (var item in data) {
  //     await aliceSubCollection.add(item);
  //   }

  //   print('Data uploaded successfully!');
  // }

  Future<void> uploadData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference aliceDoc = firestore.collection('script').doc('emily');
    await aliceDoc.set({'data': data});
    print('Data uploaded successfully!');
  }
}

final data = [
  {
    "id": 1,
    "data": [
      {
        "id": 1,
        "description": "New girl, new love story, get to know Emily better",
        "messages": [
          {
            "text":
                "Hey Emily, it's going great now that I'm talking to you. Did Max enjoy the hike as much as I would enjoy a walk with you?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "Definitely, I'd like to know that 😋",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Hi Emily! My day's been pretty good. I love hiking too. Do you have a favorite trail you recommend?",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Oh, Max loves any trail with a stream. He adores splashing around. What about you? Are you an outdoor enthusiast too?",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Hey! My day's been decent, but it's about to get much better. What's Max's favorite treat? Maybe I can bribe him to share you!",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Duck necks are Max's favorite, you'd love them. Ahah!",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 2,
        "description":
            "The attention for her favorite pet is great! Keep up the good work",
        "messages": [
          {
            "text":
                "I do love the outdoors, especially if I had a hiking buddy as charming as you",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Buddy's favorite thing to do is put together a nice look for a walk",
                "isPremiumContent": false
              },
              {
                "type": "image",
                "content": "EmilyParker_pic1",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "Absolutely! I often go hiking on weekends. What's the best part about hiking for you?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Buddy's favorite thing to do is put together a nice look for a walk",
                "isPremiumContent": false
              },
              {
                "type": "image",
                "content": "EmilyParker_pic1",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "I enjoy the outdoors, but I think I'd enjoy it even more if I had you and Max as company",
            "isPremium": true,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "Uh, boys, you're gonna have to compete for my attention😈",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "EmilyParker_Video1",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 3,
        "description":
            "Wow, you're being seduced,  recommend complimenting Emily",
        "messages": [
          {
            "text":
                "U look incredible, Emily 🥵That outfit leaves just enough to the imagination",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "ahaha this is just the beginning 🔞",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text": "That skirt suits you perfectly. My day's much better now",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content": "ahaha glad to lift your spirits and more 🥰",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "I can't imagine what would happen to me if I saw you without that beautiful skirt🤤",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content": "all for you ❤️‍🔥",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "EmilyParker_Video2",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 4,
        "description": "Emily is very brave and quick to approach, isn't she?",
        "messages": [
          {
            "text": "Emily, you pleasantly surprise me 💋",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Thank u so much for your complements, we're getting away from our introductions, so what's your taste in girls? ;)",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text": "Emily, you scare me with your candor ;)",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Thank u so much for your complements, we're getting away from our introductions, so what's your taste in girls? ;)",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "You know, I like to see more of your pics and videos, is there anything else you could share with me?",
            "isPremium": true,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "Okay, we're getting away from our introductions, so what's your taste in girls? ;)",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "EmilyParker_Video4",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 5,
        "description": "Let her know that she's your ideal",
        "messages": [
          {
            "text":
                "well, Emily, I have a thing for girls who r sweet, down-to-earth, and have a knack for making every moment feel special. Just like you 😉",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Aww, that's so sweet of you to say! I love reading that 😊",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "So, what would be your idea of a perfect day together?",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "I’m into girls who know how to mix a bit of sweetness with a touch of seduction. Someone who can keep things exciting and a little unpredictable. Think you fit the bill? 😈",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Aww, that's so sweet of you to say! I love reading that 😊",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "So, what would be your idea of a perfect day together?",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "I'm drawn to girls who r kind-hearted, love a good adventure, and have a captivating smile. And from what I’ve seen, you seem to tick all those boxes 😘",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Aww, that's so sweet of you to say! I love reading that 😊",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "So, what would be your idea of a perfect day together?",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 6,
        "description": "Choose your favorite time with Emily",
        "messages": [
          {
            "text":
                "Leisurely brunch, farmer's market, baking cookies, and relaxing in the garden with tea at sunset. Simple, but meaningful. 😊",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Perfect and cozy! 😌 Here’s a snapshot of my garden. Can't wait to relax there with you 🌸",
                "isPremiumContent": false
              },
              {
                "type": "image",
                "content": "EmilyParker_pic2",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "Morning hike, picnic lunch, then something exciting like paddleboarding or zip-lining. End the day with a bonfire under the stars. What do you think? 😏",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Absolutely thrilling! 💕 Here's a photo of my last hike. Imagine us there! 🌲🏞️",
                "isPremiumContent": false
              },
              {
                "type": "image",
                "content": "EmilyParker_pic3",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "Starting with breakfast at a cozy café, a walk with Max, hiking, then homemade dinner and a movie night at your place. Sounds perfect, right? 😘",
            "isPremium": true,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "That sounds dreamy! 😍 Here's a pic of me at my favorite café spot 📸☕",
                "isPremiumContent": false
              },
              {
                "type": "image",
                "content": "EmilyParker_pic4",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 7,
        "description":
            "Wow, she loves spoiling you with her pics, that should be encouraged",
        "messages": [
          {
            "text": "Emily, I've never met a prettier girl than you!",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mutually, so I have to go help out at the community center for a bit. I'll be back in a couple of hours! Don't miss me too much 😉💖 Talk soon!",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Those places were lucky to have you, and now I'm happy to be with you, if only in this chat.",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mutually, so I have to go help out at the community center for a bit. I'll be back in a couple of hours! Don't miss me too much 😉💖 Talk soon!",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "You are the best woman on earth, Emily! I'm excited to meet ya and want to get to know you more and more 😘",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mutually, so I have to go help out at the community center for a bit. I'll be back in a couple of hours! Don't miss me too much 😉💖 Talk soon!",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 8,
        "description":
            "So fast! It seems like you guys have a lot more to talk about, do you want to continue?",
        "messages": [
          {
            "text":
                "Always doing something sweet. Miss ya already 😉  xo xo, your, {name}",
            "isPremium": false,
            "points": 1,
            "isScriptBot": false
          }
        ]
      }
    ]
  },
  {
    "id": 2,
    "data": [
      {
        "id": 1,
        "description": "Say a nice hello to Emily, I think she missed you",
        "messages": [
          {
            "text": "Of course! What took ya so long? 😘",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "aww, you're too sweet! Let's make up for lost time 💋",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text": "Missed u tons. Can't wait to chat more 😉🔥",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "aww, you're too sweet! Let's make up for lost time 💋",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Every minute felt like forever. Glad you're back, beautiful ❤️",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "You always know how to make me smile. I'm all yours now 😘💖",
                "isPremiumContent": false
              },
              {
                "type": "image",
                "content": "EmilyParker_pic6",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 2,
        "description":
            "Take a caring interest in her affairs to make her feel at ease",
        "messages": [
          {
            "text":
                "How was your time at the community center? Hope it was fulfilling!",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "ugh, had to deal with a busted water pipe at the community center today. What a mess! 😩💦",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "How did it go at the community center, Emily? I bet you were amazing!",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "ugh, had to deal with a busted water pipe at the community center today. What a mess! 😩💦",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 3,
        "description":
            "It's a time for a sense of humor, which is very appealing",
        "messages": [
          {
            "text": "You're the hero fixing pipes now? So hot! 😘",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "ahaha, thanks! Just another day saving the day 😘  what's up with you?",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Aw, rough day, huh? You still look cute even covered in water! 😉",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content": "Oh, ahah, you still think so?",
                "isPremiumContent": false
              },
              {
                "type": "image",
                "content": "EmilyParker_pic7",
                "isPremiumContent": true
              },
              {
                "type": "text",
                "content": "What's up with you?",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 4,
        "description":
            "Share your day with Emily so she feels like you trust her",
        "messages": [
          {
            "text":
                "Just wrapped up a hectic day at work, but chatting with you makes it all better😊 Any plans for the evening?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "My plan tonight is just to lie in bed and talk to you 💋",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Busy day, but nothing exciting like your heroics! 😄 Now winding down with some music. What about you?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "My plan tonight is just to lie in bed and talk to you 💋",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Spent the day juggling work and errands. Now winding down and wishing you were here ❤️",
            "isPremium": true,
            "points": 3,
            "answer": [
              {
                "type": "image",
                "content": "EmilyParker_pic5",
                "isPremiumContent": true
              },
              {
                "type": "text",
                "content": "just like that, huh?",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 5,
        "description":
            "Something interesting is coming up, I like her flirty tone",
        "messages": [
          {
            "text":
                "Talking to you in bed sounds like the perfect way to end the day. Let's make it unforgettable 💖",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "How about we explore our secret turn-ons? I'm curious about yours😉",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "u r making my night sound way more interesting. Mind if I join you? 😏",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "How about we explore our secret turn-ons? I'm curious about yours😉",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 6,
        "description": "Flirt with Emily to keep the tantalizing talk going",
        "messages": [
          {
            "text":
                "I'm into whispers in my ear that send shivers down my spine. What about you? 😉",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "[Emily's answering service]:\nEmily's phone went to do not disturb mode and she started to fall asleep",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "I can't resist someone who knows how to tease and build anticipation. What gets you going? 😏",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "[Emily's answering service]:\nEmily's phone went to do not disturb mode and she started to fall asleep",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "For me, it's all about confident touches that leave me wanting more. What about you, Emily? 😘",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "[Emily's answering service]:\nEmily's phone went to do not disturb mode and she started to fall asleep",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 7,
        "description":
            "There's still an opportunity to wake her up and continue the conversation",
        "messages": [
          {
            "text": "Wake up Emily",
            "isPremium": false,
            "points": 1,
            "isScriptBot": false
          }
        ]
      }
    ]
  }
];
