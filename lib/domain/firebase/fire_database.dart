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
        "description":
            "If a girl shows interest, you need to show her mutual interest",
        "messages": [
          {
            "text": "Very glad that you wrote, your name is Alice, right?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "You're really right 😋",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video1_Day1_Event0",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text": "Yeah, sure, I'd love to get to know you better, Alice",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content": "How nice!😋",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video1_Day1_Event0",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "Hi, honey! Can a gentleman like me get your wonderful selfies?",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content": "Mmm, of course!😋",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video2_Day1_Event1",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 3,
        "description": "...and ask another engaging question",
        "messages": [
          {
            "text": "Alice, what topics do you like to chat with men about?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "I'm most interested in the world of male fantasies, I've always wanted to look inside your head and find out the desires hidden behind courtesy and delicacy",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text": "Alice, what's most important to you in a man?",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "I'm most interested in the world of male fantasies, I've always wanted to look inside your head and find out the desires hidden behind courtesy and delicacy",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Alice, how do you feel about more explicit dialog with a man?",
            "isPremium": true,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "I'm most interested in the world of male fantasies, I've always wanted to look inside your head and find out the desires hidden behind courtesy and delicacy",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video4_Day1_Event3",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 4,
        "description":
            "Wow, she sure liked you! Now ask her something about her life?",
        "messages": [
          {
            "text": "Alice, can you tell how you spend your free time?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "I love to read, so I often spend my free time reading or watching popular science videos about the world around me.\n\nAnd I also have a hobby - I listen to and record my own music in cold wave/electro/ minimal wave genre, but also I am inspired by academic music\n\nIn the evening I spend my time chatting online, like I'm doing with you right now.",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text": "Alice, I know you do a lot for the society, tell me why?",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "My dream is to create the perfect virtual environment for education and development, and to find ways to use artificial intelligence to fulfill sexual desires.",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 5,
        "description":
            "I suspect you will be able to afford more after these general questions. In the meantime, answer Alice's question",
        "messages": [
          {
            "text":
                "Alice, thanks for sharing, I feel like you and I have a lot in common",
            "isPremium": false,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "Wow 😍 Oh, I'm very pleased that you feel something in common between us, it's my turn to please you",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video16_Day1_Event5",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "I've already missed teasing your videos, show me yourself, sweetie",
            "isPremium": true,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "Ahhhh honey, you don't seem to be a fan of long texts",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic1", "isPremiumContent": true}
            ]
          }
        ]
      },
      {
        "id": 6,
        "description":
            "You managed to get her to send you a teasing photo! Need to keep that sexy vibe.",
        "messages": [
          {
            "text":
                "Mmm, you look so sexy, if you're trying to make me horny, you're doing a great job",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "To be honest, I'm really excited to have you in my life, {name}, now I have to go to bed, it's already night in my time zone. I go online once a day, so the next 12 hours will be endless for me and I will miss you very much!  xo xo your sweetie Alice 💋",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "or... do you not want to wait and want to rewind time until we meet again??😏 and see what video I made for you...",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video5_Day1_Event6",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "Alice, baby, my day will never be the same, thank you for your teasing gift",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "To be honest, I'm really excited to have you in my life, {name}, now I have to go to bed, it's already night in my time zone. I go online once a day, so the next 12 hours will be endless for me and I will miss you very much!  xo xo your sweetie Alice 💋",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "or... do you not want to wait and want to rewind time until we meet again??😏 and see what video I made for you...",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video5_Day1_Event6",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 7,
        "description":
            "Say something nice back to her or rewind time to your next date with Alice",
        "messages": [
          {
            "text": "it's mutual, sweetie, Alice!  xo xo, your, {name}",
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
        "description":
            "Alice's virtual assistant suggests that now would be a good time to text Alice: «what does she do or how did she spend her day?»",
        "textfieldAvailable": false,
        "messages": [
          {
            "text": "Hey, Alice! How was your day?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Hey, {name}!!! I've been waiting for your message, it's been busy today, but I finally got free, changed into comfortable clothes and made myself a grilled steak and veggies, and u?",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic2", "isPremiumContent": true},
              {"type": "image", "content": "Pic10", "isPremiumContent": true},
              {"type": "image", "content": "Pic3", "isPremiumContent": true}
            ]
          },
          {
            "text":
                "Hey, Alice! I was thinking about you and decided to write, what are you doing now?",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Hey, {name}!!! I've been waiting for your message, it's been busy today, but I finally got free, changed into comfortable clothes and made myself a grilled steak and veggies, and u?",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic2", "isPremiumContent": true},
              {"type": "image", "content": "Pic10", "isPremiumContent": true},
              {"type": "image", "content": "Pic3", "isPremiumContent": true}
            ]
          },
          {
            "text":
                "Hey, sweetie, Alice, been looking over all the photos and videos you sent me yesterday, miss you! I want to see you again!",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Hey, {name}!!! I've been waiting for your message, it's been busy today, but I finally got free and made myself a grilled steak and veggies, and u?",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video6_Day2_Event0",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 2,
        "description":
            "Remember what you're gonna do when a girl shows interest? Reciprocate, right. Now tell her very briefly what you did today or think of something you could do",
        "textfieldAvailable": false,
        "messages": [
          {
            "text":
                "It seems that all the time that I was doing my work, I was thinking about the magical Alice",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "mmmm, thanks for sharing, sweetie, what we'll chat about today?",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "I work from home and mostly with the computer, honey, I've completed all the programming tasks, but I've been thinking about you the whole time",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mm, I hope you like what I have in store for you🤤💦",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video7_Day2_Event2",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 3,
        "description": "It's a good time to turn the talk toward flirting",
        "messages": [
          {
            "text":
                "You know, my imagination kicks in when I think of you, you want me to share with you?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "Oh, really? Tell me about your fantasies😈",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Before I went to sleep I fantasized a lot about us, would you like me to tell you?",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "Oh, really? Tell me about your fantasies😈",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 4,
        "description": "It's a good time to continue the talk toward flirting",
        "messages": [
          {
            "text": "I want to explore every inch of your beautiful body",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mmm... I can feel my whole skin becoming sensitive just from hearing you say that🔥",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "My desire to touch every part of your body grows by the minute",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mmm... I can feel my whole skin becoming sensitive just from hearing you say that🔥",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 5,
        "description":
            "Now keep describing your fantasies about Alice, tell her in detail what you'd like to do to her if you were near her, maybe kiss",
        "textfieldAvailable": false,
        "messages": [
          {
            "text":
                "I want to start by kissing on your lips, slowly making my way down to your nec",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "I imagine your hot lips touching my skin... I would love to feel it",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video7_Day2_Event5",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "Your lips are so tantalizing to me that I dream of kissing them over and over again",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "I imagine your hot lips touching my skin... I would love to feel it",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video7_Day2_Event5",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 6,
        "description":
            "Great, now tell me how you would explore her body with your tongue",
        "textfieldAvailable": false,
        "messages": [
          {
            "text":
                "I will be tender and passionate at the same time, exploring every part of your body with the caress of my lips and tongue",
            "isPremium": false,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "As things heat up, I want you to reach down to fondle my breasts, gently squeezing them and gently stroking my neck👅💦",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic4", "isPremiumContent": true},
              {"type": "image", "content": "Pic5", "isPremiumContent": true}
            ]
          },
          {
            "text":
                "Your skin is so warm and soft that I feel real electric shocks as I run my tongue along your neck, lower and lower",
            "isPremium": false,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "As things heat up, I want you to reach down to fondle my breasts, gently squeezing them and gently stroking my neck👅💦",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic4", "isPremiumContent": true},
              {"type": "image", "content": "Pic5", "isPremiumContent": true}
            ]
          }
        ]
      },
      {
        "id": 7,
        "description":
            "Now tell me more about what you'd like to do with Alice's breasts",
        "textfieldAvailable": false,
        "messages": [
          {
            "text":
                "As I cups one breast in my hand, i tweaks the nipple lightly, watching it stiffen under my touch",
            "isPremium": false,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content":
                    "I run my hands through your hair, moaning softly in your ear and arches my back, letting out a low moan at the sensation",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "l uses my tongue to tease and lick at your nipples, flicking them gently with my tongue tip",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "I run my hands through your hair, moaning softly in your ear and arches my back, letting out a low moan at the sensation",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 8,
        "description": "Now you need to make her horny and wet",
        "messages": [
          {
            "text":
                "After making out for a bit, the I moves my attention downward, settling on your pussy. I can't resist the urge to touch it",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "I groans into your ear, loving the way you makes me feel so good 💦💦",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "With gentle fingers, I rubs your outer labia, watching as you shifts restlessly underneath me",
            "isPremium": true,
            "points": 1,
            "answer": [
              {
                "type": "video",
                "content": "Video8_Day2_Event8",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 9,
        "description": "Yes! she's ready to take you inside",
        "messages": [
          {
            "text":
                "Then slips two fingers inside of you, feeling your heat and wetness around them",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "My hand glides down to cup your erection, eliciting a groan from you🍆",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text": "Next, I rolls over onto my back, inviting you to mount me",
            "isPremium": true,
            "points": 1,
            "answer": [
              {
                "type": "video",
                "content": "Video9_Day2_Event9",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 10,
        "description": "Tell her how you feel when your cock belongs to her?",
        "textfieldAvailable": false,
        "messages": [
          {
            "text":
                "I can feel my cock getting wet and swollen from what you're doing to it",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Uh, yeah, honey, that was wonderful, but I gotta go to bed! It's gonna be hard, but I prefer to stretch the pleasure, see you tomorrow, {name}, xo xo your horny Alice",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "or...  or would you like to continue our hot, dirty talk??😏",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video10_Day2_Event10",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "I like how imperiously you are able to control the pleasure of the penis from your caresses with your hands",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Uh, yeah, honey, that was wonderful, but I gotta go to bed! It's gonna be hard, but I prefer to stretch the pleasure, see you tomorrow, {name}, xo xo your horny Alice",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "or...  or would you like to continue our hot, dirty talk??😏",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video10_Day2_Event10",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 11,
        "description":
            "Wish her something nice for the night and thank her for the hot talk or continue our hot, dirty talk",
        "textfieldAvailable": false,
        "messages": [
          {
            "text":
                "Alice, that was really hot, I want you more every day, you are incredible, hugs and sweet dreams! xo xo, your, {name}",
            "isPremium": false,
            "points": 1,
            "answer": []
          }
        ]
      }
    ]
  },
  {
    "id": 3,
    "data": [
      {
        "id": 1,
        "description":
            "You've made quite an impression on Alice, you're the first person she's ever written to like that, let's flirt with her",
        "textfieldAvailable": false,
        "messages": [
          {
            "text": "To be honest, I'm thinking about you right now, too",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mmm... Then can we continue to pleasure ourselves together? 😏🔥",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video11_Day3_Event0",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "Those photos/videos you've been sending me, they've been making me very horny too",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Mmm... Then can we continue to pleasure ourselves together? 😏🔥",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video11_Day3_Event0",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text":
                "You know what I want more than anything right now? To see you and your body again",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content": "tell me what you think when you look at me...",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video12_Day3_Event0",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 2,
        "description": "Share your erotic fantasy with Alice",
        "textfieldAvailable": false,
        "messages": [
          {
            "text": "I think if I were around, I'd want to help you undress",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "ahaha how deeply you feel me, I really want to take off my bra, but to do that you have to say the magic phrase😈",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text": "I can see that bra is keeping you from feeling free",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "ahaha how deeply you feel me, I really want to take off my bra, but to do that you have to say the magic phrase😈",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                " I would give anything in the world to help you deal with this gorgeous lingerie right now",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "ahaha how deeply you feel me, I really want to take off my bra, but to do that you have to say the magic phrase😈",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 3,
        "description":
            "What kind of phrase can get a girl to take her clothes off? Compliments, maybe?",
        "textfieldAvailable": false,
        "messages": [
          {
            "text": "Password: I want to see and caress your magic boobs",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "all for you, sweetheart, {name}🍒",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video13_Day3_Event3",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text": "Your breasts are the best I've ever seen",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "all for you, sweetheart, {name}🍒",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video13_Day3_Event3",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text": "Alice - you are a goddess and I am in your power",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "all for you, sweetheart, {name}🍒",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video13_Day3_Event3",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 4,
        "description":
            "Thank Alice for the video and say something about how you feel",
        "textfieldAvailable": false,
        "messages": [
          {
            "text": "You're driving me crazy, Alice",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "and I like to drive you crazy and turn your head with my erotic photos and videos, let's play?",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "Thank you for the video, Alice, I love the way you play with your boobs",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "and I like to drive you crazy and turn your head with my erotic photos and videos, let's play?",
                "isPremiumContent": false
              }
            ]
          },
          {
            "text":
                "When I see your juicy breasts, my cock gets hard and my head stops thinking",
            "isPremium": true,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "I'd like to feel the hardness of your cock inside me so that it totally fills me deep inside🍆\n\nlet's play?",
                "isPremiumContent": false
              }
            ]
          }
        ]
      },
      {
        "id": 5,
        "description": "Alice is planning an erotic game.\nGo for it",
        "messages": [
          {
            "text": "I'm ready to play with you endlessly, honey, Alice",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Okay, I'll ask you questions and if you guess, you get a prize🔥😏",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "Let's begin, what's the most erogenous spot on Alice's body?",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic6", "isPremiumContent": true}
            ]
          },
          {
            "text":
                "An erotic game with hot girl Alice? That's probably a great idea for a night out",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Okay, I'll ask you questions and if you guess, you get a prize🔥😏",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "Let's begin, what's the most erogenous spot on Alice's body?",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic6", "isPremiumContent": true}
            ]
          }
        ]
      },
      {
        "id": 6,
        "description": "Answer options",
        "messages": [
          {
            "text": "The back and the waist",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Oh, that's not true, don't feel bad, baby, consolation prize",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic7", "isPremiumContent": true}
            ]
          },
          {
            "text": "Neck and shoulders",
            "isPremium": false,
            "points": 2,
            "answer": [
              {
                "type": "text",
                "content":
                    "Your brain turns me on even more than your dick. Way to go, sweetie😘",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "Question number 2. What kind of sex do I dream of having with you {name}?",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video14_Day3_Event6",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text": "Get a prize without guessing, bypass the rules",
            "isPremium": true,
            "points": 3,
            "answer": [
              {
                "type": "text",
                "content": "and you know how to use cheat codes, tricky😈",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "Question number 2. What kind of sex do I dream of having with you {name}?",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video14_Day3_Event6",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 7,
        "description": "Answer options",
        "messages": [
          {
            "text":
                "In your fantasies I first start caressing your body with my tongue, then I go lower and lower until I reach the pussy",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "When I imagine you caressing me with your tongue, my whole body shakes with excitement and my lower stomach spasms😘",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "it's been a cool and hot morning with you, now it's time for me to eat breakfast and get ready for the gym or .... can we continue here?",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic8", "isPremiumContent": true}
            ]
          },
          {
            "text":
                "In your fantasies I kiss you passionately on the lips and my hands start stroking your neck, then your back, your booty, going lower and lower until my hand gets into your panties",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Ooops, it's okay, {name}, I'll still make you excited with my photo.",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "it's been a cool and hot morning with you, now it's time for me to eat breakfast and get ready for the gym or .... can we continue here?",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video17_Day3_Event8",
                "isPremiumContent": true
              }
            ]
          },
          {
            "text": "Get a prize without guessing, bypass the rules",
            "isPremium": true,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content": "A hooligan and a bad boy😈",
                "isPremiumContent": false
              },
              {
                "type": "text",
                "content":
                    "it's been a cool and hot morning with you, now it's time for me to eat breakfast and get ready for the gym or .... can we continue here?",
                "isPremiumContent": false
              },
              {
                "type": "video",
                "content": "Video15_Day3_Event8",
                "isPremiumContent": true
              }
            ]
          }
        ]
      },
      {
        "id": 8,
        "description":
            "Wish her something nice for the day and thank her for the hot talk or continue our hot, dirty talk",
        "messages": [
          {
            "text":
                "Have a wonderful day sweet Alice, thank you for the pleasure you bring me, I look forward to seeing you «online»",
            "isPremium": false,
            "points": 1,
            "answer": [
              {
                "type": "text",
                "content":
                    "Likewise, honey! I'll be thinking of you the whole time, kissing your lips passionately, xo xo Alice",
                "isPremiumContent": false
              },
              {"type": "image", "content": "Pic9", "isPremiumContent": true}
            ]
          }
        ]
      }
    ]
  }
];
