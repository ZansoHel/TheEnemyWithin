
//////////////////////////////////////////////////
// Old Plough Innkeeper
//////////////////////////////////////////////////
BEGIN ~R#OLDPL~

IF ~True()
~ THEN BEGIN 0 // from:
  SAY @10001 /* ~Ya should do yerself a favor and stay indoors tonight. I've heard of all sorts of weird things happening at night.~ */
  IF ~~ THEN REPLY @10002 /* ~What can you give me today?~ */ DO ~StartStore("r#oldpl",LastTalkedToBy(Myself))
~ EXIT
  IF ~~ THEN REPLY @10003 /* ~I don't need anything at the moment.~ */ EXIT
END

IF ~False()
~ THEN BEGIN 1 // from:
  SAY @10004 /* ~Have you ever danced with the devil in the pale moonlight? Well, neither have I.~ */
  IF ~~ THEN EXIT
END



//////////////////////////////////////////////////
// Cragmyr Storekeeper Eric
//////////////////////////////////////////////////
BEGIN ~R#CRAGST~

IF ~True()
~ THEN BEGIN 0 // from:
  SAY @10005 /* ~Damn cart man is running late. I am running low on my inventory. Well couldn't afford half of the stuff anyway. What can I do for you?~ */
  IF ~~ THEN REPLY @10006 /* ~Can I see what you have for sale?~ */ DO ~StartStore("R#CRAGST",LastTalkedToBy(Myself))
~ EXIT
  IF ~~ THEN REPLY @10007 /* ~Nothing sorry. Maybe later.~ */ EXIT
END



//////////////////////////////////////////////////
// Cragmyr Guard
//////////////////////////////////////////////////
BEGIN ~R#CRAGG1~

IF WEIGHT #1 /* Triggers after states #: 3 even though they appear after this state */
~  NumberOfTimesTalkedTo(0)
~ THEN BEGIN 0 // from:
  SAY @10008 /* ~We represent Lord Kuldak Maurancz. You are accused of thievery and must surrender yourselves to the mercy of the law.~ */
  IF ~  PartyGoldGT(99)
~ THEN REPLY #7400 /* ~I bet you wouldn't feel the same if we were to guild your palm with these 100 gold pieces.~ */ GOTO 1
  IF ~  PartyGoldGT(199)
~ THEN REPLY #7401 /* ~We regret our actions sorely and are prepared to make amends by giving you 200 gold.~ */ GOTO 2
  IF ~~ THEN REPLY #7402 /* ~DIEEE! POND SCUM!~ */ DO ~Shout(99)
Enemy()
~ EXIT
END

IF ~~ THEN BEGIN 1 // from: 0.0
  SAY #7280 /* ~A bribe! This is an insult of the highest order. Defend yourselves!~ */
  IF ~~ THEN DO ~Shout(99)
Enemy()
~ EXIT
END

IF ~~ THEN BEGIN 2 // from: 0.1
  SAY #7399 /* ~200 gold? All right, you're free to go.~ */
  IF ~~ THEN DO ~TakePartyGold(200)
ActionOverride("R#CRAGG1",EscapeArea())
ActionOverride("R#CRAGG2",EscapeArea())
ActionOverride("R#CRAGG2",EscapeArea())
ActionOverride("R#CRAGG2",EscapeArea())
EscapeArea()
~ EXIT
END

IF WEIGHT #0 ~  StateCheck(Myself,STATE_CHARMED)
~ THEN BEGIN 3 // from:
  SAY #7403 /* ~I'm an enlisted soldier, and thus I'm not privy to many secrets.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 4 // from:
  SAY #8911 /* ~You have committed an assault against me! You'll pay with your life!~ */
  IF ~~ THEN EXIT
END



//////////////////////////////////////////////////
// Kuldak
//////////////////////////////////////////////////
BEGIN ~R#KULDAK~

IF WEIGHT #5 /* Triggers after states #: 3 18 19 20 39 even though they appear after this state */
~  Global("Know_Kuldak","GLOBAL",0)
Global("Kuldak_quest1","GLOBAL",0)
~ THEN BEGIN 0 // from:
  SAY @10009 /* ~What's this? New face in town, eh? Well met, stranger. The name is Lord Kuldak Maurancz, and I am the Lord of these lands and Cragmyr Keep. Who might you be?~ [R#KUL00] */
  IF ~~ THEN REPLY @10010 /* ~Greetings Lord Kuldak. My name is <GABBER>.~ */ DO ~EndCutSceneMode()
~ GOTO 1
  IF ~~ THEN REPLY @10011 /* ~Who I am is none of your concern.~ */ GOTO 22
END

IF ~~ THEN BEGIN 1 // from: 0.0
  SAY @10012 /* ~Well then, whatever your business in these parts might be, I would offer you this small piece of advice: while you're in my town, you'd do well to be on your best behavior.~ [R#KUL01] */
  IF ~~ THEN GOTO 2
END

IF ~~ THEN BEGIN 2 // from: 22.0 1.0
  SAY @10013 /* ~These folk are under my protection, and anyone who would seek to do harm to them in any way shall answer to me.~ [R#KUL02] */
  IF ~~ THEN GOTO 23
END

IF WEIGHT #0 ~  Global("Know_Kuldak","GLOBAL",1)
GlobalLT("Kuldak_quest1","GLOBAL",2)
~ THEN BEGIN 3 // from:
  SAY @10014 /* ~Well met, friend. And welcome to my home. Make yourselves comfortable, but try not to break anything. Many of these curiosities that you see lying about have... sentimental value.~ [R#KUL03] */
  IF ~~ THEN REPLY @10015 /* ~Where did you get all this stuff?~ */ GOTO 4
  IF ~~ THEN REPLY @10016 /* ~Sentimental value? You don't strike me as the sentimental type.~ */ GOTO 4
  IF ~~ THEN REPLY @10017 /* ~You have quite a collection here.~ */ GOTO 4
END

IF ~~ THEN BEGIN 4 // from: 3.2 3.1 3.0
  SAY @10018 /* ~Ah, they're all remembrances of my adventuring days, little trinkets and the like that I picked up here and there. More keepsakes than valuables really, leftovers from my days of fortune and glory.~ [R#KUL04] */
  IF ~~ THEN REPLY @10019 /* ~Adventuring days? So you are retired then?~ */ GOTO 5
  IF ~~ THEN REPLY @10020 /* ~Fortune and glory, eh? Looks to me like you've had more than your share of glory, if not fortune.~ */ GOTO 7
  IF ~~ THEN REPLY @10021 /* ~Impressive. I sincerely hope I have as much luck in my quest for fortune and glory.~ */ GOTO 9
END

IF ~~ THEN BEGIN 5 // from: 4.0
  SAY @10022 /* ~Semi-retired, actually. This region is still untamed and fraught with many dangers. Ogres are the biggest problem. My sons... the... they were killed fighting them not that long ago.~ [R#KUL05] */
  IF ~~ THEN GOTO 6
END

IF ~~ THEN BEGIN 6 // from: 5.0
  SAY @10023 /* ~That is what I wanted to speak to you about. The keep is in a very bad condition and we need to prepared against the ogres in case of an attack. For some reason they have become more organized lately and I have no clues why.~ [R#KUL06] */
  IF ~~ THEN REPLY @10024 /* ~How do you intend to accomplish this?~ */ GOTO 10
  IF ~~ THEN REPLY @10025 /* ~What do you need me for?~ */ GOTO 10
END

IF ~~ THEN BEGIN 7 // from: 4.1
  SAY @10026 /* ~Oh, I've seen my share of fortune as well, rest assured. I've beheld more treasure than most kings, I'd wager.~ [R#KUL07] */
  IF ~~ THEN GOTO 8
END

IF ~~ THEN BEGIN 8 // from: 7.0
  SAY @10027 /* ~But it wasn't for coins that I fought and bled all those years. It was for something grander, more powerful than mere riches. Adventuring is something that is in your blood, not in your purse.~ [R#KUL08] */
  IF ~~ THEN REPLY @10028 /* ~Well said. I too heed a similar call to adventure.~ */ GOTO 9
  IF ~~ THEN REPLY @10029 /* ~You're daft, I say. Why risk your neck when there is no coin to be made?~ */ GOTO 9
  IF ~~ THEN REPLY @10030 /* ~Hmm... interesting. I'm not sure I agree with you, though.~ */ GOTO 9
END

IF ~~ THEN BEGIN 9 // from: 8.2 8.1 8.0 4.2
  SAY @10031 /* ~Indeed? Well then, this might interest you. I am willing to offer a very reasonable reward for helping me to find a skilled engineer to repair the keep and its defenses into atleast partial operational capability.~ [R#KUL09] */
  IF ~~ THEN REPLY @10032 /* ~Really? What's wrong with the keep and its functionality?~ */ GOTO 10
  IF ~~ THEN REPLY @10033 /* ~Sorry, not interested. Farewell.~ */ GOTO 14
END

IF ~~ THEN BEGIN 10 // from: 14.1 14.0 9.0 6.1 6.0
  SAY @10034 /* ~The walls need to be repaired and I need to find someone to fix the Helmed Horrors in the keep. I myself however just cannot take off due to the constant ogre threat and the delegations of Flaming Fist and Amn breathing on my neck and preasuring me to pick a side in their spat.~ */
  IF ~~ THEN GOTO 11
END

IF ~~ THEN BEGIN 11 // from: 40.0 10.0
  SAY @10035 /* ~What say you? Interested in keeping the people of Cragmyr safe? In the mean time I will have to deal with these delegations and try to get rid of them.~ [R#KUL11] */
  IF ~~ THEN REPLY @10036 /* ~Why do the Flaming Fist and Amn want you to their side so badly?~ */ GOTO 12
  IF ~~ THEN REPLY @10037 /* ~Sounds exciting. Count me in.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",3)
AddJournalEntry(@100001,QUEST)
~ GOTO 16
  IF ~~ THEN REPLY @10038 /* ~If there's gold to be had, I'm in.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",3)
AddJournalEntry(@100001,QUEST)
~ GOTO 16
  IF ~~ THEN REPLY @10039 /* ~Sounds like a waste of time. Maybe some other time. Farewell.~ */ GOTO 15
END

IF ~~ THEN BEGIN 12 // from: 11.0
  SAY @10040 /* ~If this Iron Crisis develops into a war, this would a perfect position for either side as a fist line of defense. So they are very eager to make an alliance with me. However, I rather stay neutral in conflicts like these, since there is no clear good and evil here.~ */
  IF ~~ THEN GOTO 13
END

IF ~~ THEN BEGIN 13 // from: 12.0
  SAY @10041 /* ~So what's it going to be? Are you in or out?~ [R#KUL13] */
  IF ~~ THEN REPLY @10037 /* ~Sounds exciting. Count me in.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",3)
EraseJournalEntry(@100000)
AddJournalEntry(@100001,QUEST)
~ GOTO 16
  IF ~~ THEN REPLY @10038 /* ~If there's gold to be had, I'm in.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",3)
EraseJournalEntry(@100000)
AddJournalEntry(@100001,QUEST)
~ GOTO 16
  IF ~~ THEN REPLY @10039 /* ~Sounds like a waste of time. Maybe some other time. Farewell.~ */ GOTO 15
END

IF ~~ THEN BEGIN 14 // from: 9.1
  SAY @10042 /* ~Hold a moment just, just hear me out. I am willing to offer a very reasonable reward for helping me to find a skilled engineer to repair the keep into atleast partial operational capability.~ [R#KUL14] */
  IF ~~ THEN REPLY @10043 /* ~Really? What's wrong with the keep and its functionality?~ */ GOTO 10
  IF ~~ THEN REPLY @10044 /* ~Why don't you do it yourself?~ */ GOTO 10
  IF ~~ THEN REPLY @10045 /* ~Sorry, still not interested. Farewell.~ */ GOTO 15
END

IF ~~ THEN BEGIN 15 // from: 14.2 13.4 11.5
  SAY @10046 /* ~Well, as you wish. Can't say I'm not disappointed, though. I took you for the adventuring type. Oh well... Farewell.~ [R#KUL15] */
  IF ~~ THEN REPLY @10047 /* ~All right, all right. I'll do what you ask.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",3)
EraseJournalEntry(@100000)
AddJournalEntry(@100001,QUEST)
~ GOTO 16
  IF ~~ THEN REPLY @10048 /* ~Farewell.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",2)
~ EXIT
END

IF ~~ THEN BEGIN 16 // from: 41.1 41.0 18.1 18.0 15.1 15.0 13.3 13.2 13.1 13.0 11.4 11.3 11.2 11.1
  SAY @10049 /* ~Excellent! Glad to have you onboard. You should speak with the captain of Cragmyr militia, Eddard. He will give more details about the task in hand.~ [R#KUL16] */
  IF ~~ THEN GOTO 17
END

IF ~~ THEN BEGIN 17 // from: 16.0
  SAY @10050 /* ~In the mean time I sadly have to deal with the delegations and other matters at hand. But for now...~ */
  IF ~~ THEN GOTO 19
END

IF WEIGHT #1 ~  Global("Kuldak_quest1","GLOBAL",2)
~ THEN BEGIN 18 // from:
  SAY @10051 /* ~Back again I see. Have you reconsidered my offer to help me repair this keep and guarantee safety for the people of the village?~ [R#KUL18] */
  IF ~~ THEN REPLY @10052 /* ~All right, all right. I'll do what you ask.~ */ DO ~EraseJournalEntry(@100000)
AddJournalEntry(@100001,QUEST)
SetGlobal("Kuldak_quest1","GLOBAL",3)
~GOTO 16
  IF ~~ THEN REPLY @10053 /* ~No, just stopping by to say hello. Farewell.~ */ EXIT
END

IF ~~ THEN BEGIN 19 // from:
  SAY @10054 /* ~Good luck. Safe journey.~ [R#KUL33] */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 22 // from: 0.1
  SAY @10055 /* ~A spirited one, eh? I like that. Well, whatever your business in these parts might be, I would offer you this small piece of advice: while you're in my town, you'd do well to be on your best behavior.~ [R#KUL22] */
  IF ~~ THEN GOTO 2
END

IF ~~ THEN BEGIN 23 // from: 2.0
  SAY @10056 /* ~That said, I'll let you get back to your cups. I wish I could join you, but there are things that require my attention presently.~ [R#KUL23] */
  IF ~~ THEN GOTO 24
END

IF ~~ THEN BEGIN 24 // from: 23.0
  SAY @10057 /* ~Once you've had a chance to rest up and get your bearings, come by and see me at my house. There's some business I would discuss with you. Farewell.~ [R#KUL24] */
  IF ~~ THEN REPLY @10058 /* ~Farewell.~ */ DO ~SetGlobal("Know_Kuldak","GLOBAL",1)
ClearAllActions()
StartCutSceneMode()
StartCutScene("R#KULD01")
AddJournalEntry(@100000,QUEST)
~ EXIT
END

IF ~~ THEN BEGIN 27 // from:
  SAY @10059 /* ~Please. Stay here and relax awhile. I wish I could join you, but there are things that require my attention presently. Come by my house later and we shall talk. Farewell.~ [R#KUL27] */
  IF ~~ THEN REPLY @10067 /* ~Farewell.~ */ DO ~EscapeArea()
~ EXIT
END

IF WEIGHT #4 ~  Global("Kuldak_quest1","GLOBAL",3)
~ THEN BEGIN 39 // from:
  SAY @10060 /* ~Ah, good... you've returned. I hope you have good news.~ [R#KUL39] */
  IF ~ OR(2)
GlobalLT("Machine_repair","GLOBAL",5)
GlobalLT("Keep_repairs","GLOBAL",3)
~ THEN REPLY @10061 /* ~No news, I'm afraid. The repairs are still underway. Farewell for now.~ */ EXIT
  IF ~  Global("Mal_hired","GLOBAL",1)
Global("Mal_hired_inform","GLOBAL",0)
~ THEN REPLY @10063 /* ~I found a very capable inven... engineer called Mal Swarley. He said he would come speak to you about the matter.~ */ DO ~SetGlobal("Mal_hired_inform","GLOBAL",1)
EraseJournalEntry(@100008)
AddJournalEntry(@100009,QUEST)
GiveGoldForce(300)
~ GOTO 51
  IF ~  Global("Machine_repair","GLOBAL",5)
Global("Keep_repairs","GLOBAL",4)
~ THEN REPLY @10082 /* ~I helped Mal repair the Helmed Horrors. They are operitional now.~ */ DO ~SetGlobal("Machine_repair","GLOBAL",6)
~ GOTO 41
  IF ~  Global("Keep_repairs","GLOBAL",3)
~ THEN REPLY @10062 /* ~We found the supplies for wall reconstruction. Supplies are being recovered as we speak. Sadly, the people of the caravan however had been massacred.~ */ DO ~SetGlobal("Keep_repairs","GLOBAL",4)
EraseJournalEntry(@100005)
AddJournalEntry(@100006,QUEST_DONE)
~ GOTO 40
END

IF ~~ THEN BEGIN 40 // from: 39.0
  SAY @10064 /* ~In any case, at least we can still retrieve the supplies, thanks to you. You've proven yourself to be quite capable... well I hope I will be seeing you soon regarding the keeps reconstruction, but farewell for now.~ [R#KUL40] */ 
  IF ~~ THEN REPLY @10058 /* ~Farewell.~ */ DO ~SetGlobal("Keep_repairs","GLOBAL",4)
GiveGoldForce(300)
~ EXIT
END

IF ~~ THEN BEGIN 41 // from: 39.0
  SAY @10065 /* ~This is terrific news! The militia's number were starting to grow thin and I not under any circumstance want to surrender my people's lives in the hands of these heartless nations. Now with the Helmed Horrors repaired Cragmyr will once again have some kind of defense against the ogres... and... other threats lurking nearby...~  */ 
  IF ~~ THEN GOTO 42
END

IF ~~ THEN BEGIN 42 // from: 39.0
  SAY @10066 /* ~However, Cragmyr's problems doesn't end here.~ */ 
  IF ~~ THEN REPLY @10067 /* ~Problems? More problems? Maybe I could help?~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",4)
~ GOTO 43
END

IF ~~ THEN BEGIN 43 // from: 42.0
  SAY @10068 /* ~Actually, now that I think about it, maybe you *can* help.~ [R#KUL28] */ 
  IF ~~ THEN GOTO 44
END

IF ~~ THEN BEGIN 44 // from: 43.0
  SAY @10069 /* ~A delegation of the Amn, a Cowled Wizard called Iltar Tranth, arrived here yesterday and he, as does Elja Hjout, both feel a little bit... off. Like they had something to hide.~  */
  IF ~~ THEN GOTO 45
END

IF ~~ THEN BEGIN 45 // from: 39.0
  SAY @10070 /* ~At some point I will have to side with Amn or Baldur's Gate. Before I make my decision however, I want to find out what they are both hiding. As I can't leave Cragmyr to perform a task like this.~ */
  IF ~~ THEN GOTO 46
END

IF ~~ THEN BEGIN 46 // from: 39.0
  SAY @10071 /* ~You've proven yourself to be quite capable... And you are the only one I trust capable enough to do this... I am asking you to find out what they are hiding. What say you?~ [R#KUL40] */ 
  IF ~~ THEN REPLY @10072 /* ~Very well. I will help you.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",5)
AddJournalEntry(@100015,QUEST)
AddJournalEntry(@100013,QUEST_DONE)
EraseJournalEntry(@100012)
EraseJournalEntry(@100014)
EraseJournalEntry(@100001)
RevealAreaOnMap("RANTA8")
~ GOTO 47
  IF ~~ THEN REPLY @10073 /* ~I have done enough for Cragmyr. I'll think about it. Farewell.~ */ DO ~AddJournalEntry(@100014,QUEST)
AddJournalEntry(@100013,QUEST_DONE)
EraseJournalEntry(@100012)
EraseJournalEntry(@100001)
~EXIT
END

IF ~~ THEN BEGIN 47
  SAY @10074 /* ~Excellent! Glad to have you onboard. If I were you I would start speaking to both of them, Iltar and Elja. Since they are both most likely trying to undermine each other, they could actually prove helpful in finding out what the other side is hiding.~ [R#KUL16] */ 
  IF ~~ THEN GOTO 55
END

IF ~ Global("Kuldak_quest1","GLOBAL",4)
~ THEN BEGIN 48 // from:
  SAY @10076 /* ~Back again I see. Have you reconsidered to help me find out what these delegations are hiding?~ [R#KUL18] */
  IF ~~ THEN REPLY @10047 /* ~All right, all right. I'll do what you ask.~ */ DO ~SetGlobal("Kuldak_quest1","GLOBAL",5)
AddJournalEntry(@100015,QUEST)
EraseJournalEntry(@100014)
~GOTO 47
  IF ~~ THEN REPLY @10077 /* ~No, just stopping by to say hello. Farewell.~ */ EXIT
END

IF ~~ THEN BEGIN 49
  SAY @10078 /* ~Good luck. Safe journey.~ [R#KUL33] */ 
IF ~~ THEN EXIT
END

IF ~  Global("Kuldak_quest1","GLOBAL",5)
~ THEN BEGIN 50 // from:
  SAY @10079 /* ~Ah, good... you've returned. Have you found out what the delegations are hiding?~ [R#KUL39] */
  IF ~~ THEN REPLY @10081 /* ~No haven't found anything yet.~ */ EXIT
END

IF ~~ THEN BEGIN 51
  SAY @10083 /* ~Yes he visited me already and we talked about repairing the Helmed Horrors. After some inspection however, he said it's going to be harder than what we first thought.~ */
  IF ~~ THEN REPLY @10084 /* ~How so? Something wrong with the machine?~ */ GOTO 52
END

IF ~~ THEN BEGIN 52
  SAY @10085 /* ~Well he told me that he has actually never seen a Helmed Horror machine like that, and since the machine schematics were stolen along with some other stuff not so long ago, he is going to need someone to help him with the repairs.~ */
  IF ~~ GOTO 53
END

IF ~~ THEN BEGIN 53
  SAY @10086 /* ~What say you? You willing to help me out once more? I will of course pay you for your time.~ [R#KUL11] */
  IF ~~ THEN REPLY @10087 /* ~Sure. Sounds like a deal!~ */ GOTO 54
END

IF ~~ THEN BEGIN 54
  SAY @10088 /* ~Excellent! But for now I have to attend some other business. You can find Mal in the dungeon inspecting the machine.~ */
  IF ~~ THEN REPLY @10089 /* ~Very well. Farewell for now.~ */ GOTO 49
END

IF ~~ THEN BEGIN 55
  SAY @10092
  IF ~~ THEN REPLY @10075 /* ~Very well. I'll do that. Farewell for now.~ */ GOTO 49
END


//////////////////////////////////////////////////
// MAL SWARLEY
//////////////////////////////////////////////////
BEGIN ~R#SMITH~

IF WEIGHT #3
~NumTimesTalkedTo(0)
Global("Know_Mal","GLOBAL",0)
~ THEN BEGIN 0
  SAY @10300 /* ~Ohmmmmmmmm...~ [R#SMI00] */
  IF ~~ THEN REPLY @10301 /* ~Hey there! Wake up!~ */ DO ~SetGlobal("Mal_Awake","GLOBAL",1)
ClearAllActions()
StartCutSceneMode()
StartCutScene("R#SMICUT")
~EXIT
END

IF ~Global("Mal_Awake","GLOBAL",1)
~ THEN BEGIN 1 // from:
  SAY @10302 /* ~Huh?!  What?! Oh!  Pardon me... I must've fallen asleep again. Phew!~ [R#SMI01] */
  IF ~~ THEN REPLY @10303 /* ~You fell asleep? I think you were knocked out... or you feinted.~ */ GOTO 2
END

IF ~~ THEN BEGIN 2 
  SAY @10304 /* ~It was simply beautiful... I was a baby kraken, swimming through river clouds of soft, molten gemstone. Those episodes are rare, but have happened before...~ [R#SMI02] */
  IF ~~ GOTO 3
END

IF ~~ THEN BEGIN 3 
  SAY @10305 /* ~Oh! My apologies... What can I do for you? Or was there something I was supposed to do for you?~ [R#SMI03] */
  IF ~~ THEN REPLY @10306 /* ~Uh, I think this is the first time we've met... isn't it?~ */ DO ~SetGlobal("Know_Mal","GLOBAL",1)
~GOTO 4
  IF ~!Class(Protagonist,Paladin)~ THEN REPLY @10307 /* ~Actually, you owe me five gold pieces. Don't you remember?~ */ DO ~SetGlobal("Know_Mal","GLOBAL",1)
~GOTO 7
  IF ~~ THEN REPLY @10308 /* ~Who are you?~ */ DO ~SetGlobal("Know_Mal","GLOBAL",1)
~GOTO 5
END

IF ~~ THEN BEGIN 4 
  SAY @10309 /* ~Perhaps... yes, yes, I think I would have remembered you. I'm sure of it. I think.~ [R#SMI04] */
  IF ~~ THEN REPLY @10310 /* ~I see. I'm <CHARNAME>. Who are you?~ */ DO ~SetGlobal("Know_Mal","GLOBAL",1)
~ GOTO 5
  IF ~~ THEN REPLY @10311 /* ~Then perhaps introductions would be in order.~ */ DO ~SetGlobal("Know_Mal","GLOBAL",1)
~ GOTO 5
END

IF ~~ THEN BEGIN 5 
  SAY @10312 /* ~Introductions, of course, introductions. Sometimes the ideas will start rattling around in my head, and I'll wake up to find I'm somewhere else. Or talking to someone else.~ [R#SMI05] */
  IF ~~ THEN GOTO 6
END

IF ~~ THEN BEGIN 6 
  SAY @10313 /* ~A pleasure to meet you. My name's Mal. Swarley is the last name.~ [R#SMI06] */
  IF ~~ THEN REPLY @10314 /* ~So... What are you doing here? What happened here?~ */ GOTO 9
  IF ~~ THEN REPLY @10315 /* ~Pleasure to meet you, Mal. What happened here?~ */ GOTO 9
END

IF ~~ THEN BEGIN 7 
  SAY @10316 /* ~Oh, my! Did I borrow such a sum? I'm afraid you caught me a little short at the moment, not height-wise, mind you, but you know, light in the purse.~ [R#SMI07] */
  IF ~~ THEN REPLY @10317 /* ~Never mind, I was just kid-~ */ GOTO 8
  IF ~~ THEN REPLY @10318 /* ~Then you better *find* some g-~ */ GOTO 8
END

IF ~~ THEN BEGIN 8 
  SAY @10319 /* ~Oh, but wait! Would you settle for one of my concoctions instead? I just brewed it, and I'm almost completely certain it's quite potent... whatever it does.~ [R#SMI08] */
  IF ~~ THEN REPLY @10320 /* ~Uh, no thanks. I'm <CHARNAME> - who are you?~ */ GOTO 5
  IF ~~ THEN REPLY @10321 /* ~I'll take it, thanks. This should settle your debt to me... whoever you are.~ */ DO ~GiveItemCreate("R#POTN01",Player1,1,0,0)
~ GOTO 5
END

IF ~~ THEN BEGIN 9 
  SAY @10322 /* ~Well, you know, accidents happen, and the wind's awfully strong... but... by the looks of it I would have to say this was no accident.~ [R#SMI09] */
  IF ~~ THEN REPLY @10323 /* ~Ouh really? Accidents? To me it seems like bandits attacked you and the caravan.~ */ GOTO 10
END

IF ~~ THEN BEGIN 10 
  SAY @10324 /* ~Are you sure? Well, you know, you must be. Yes, YES! I am starting to remember!~ [R#SMI10] */
  IF ~~ THEN REPLY @10325 /* ~Did you see where they came from? Did they have a leader?~ */ GOTO 11
END

IF ~~ THEN BEGIN 11 
  SAY @10326 /* ~Well - everywhere. Quite a mob of them. 'N a lot of arrows, you know. I told them to stop it on many occasions, but they only seem to understand after I dumped several casks of flaming oil on them.~ [R#SMI11] */
  IF ~~ THEN REPLY @10327 /* ~And they didn't? Well what a bunch of as-~ */ GOTO 12
END

IF ~~ THEN BEGIN 12
  SAY @10328 /* ~Oh, didn't I tell you? But I must have.~ [R#SMI12] */
  IF ~~ THEN REPLY @10329 /* ~Tell me what?~ */ GOTO 13
  IF ~~ THEN REPLY @10330 /* ~Are you some kind of idiot?~ */ GOTO 13
END

IF ~~ THEN BEGIN 13
  SAY @10331 /* ~Why, I make potions! I mean, well, among other things. I'm an inventor. I make things. And potions. Did I say that?~ [R#SMI13] */
  IF ~~ THEN REPLY @10332 /* ~Do you have any potions to sell?~ */ GOTO 15
  IF ~~ THEN REPLY @10333 /* ~Do you test these potions on yourself after making them?~ */ GOTO 14
END

IF ~~ THEN BEGIN 14
  SAY @10334 /* ~Not often. Very dangerous, some of them. Others are volatile. Some are both.~ [R#SMI14] */
  IF ~~ THEN REPLY @10332 /* ~Do you have any potions to sell?~ */ GOTO 15
  IF ~~ THEN REPLY @10335 /* ~Did some of those... dangerous... potions cause all this damage here?~ */ GOTO 22
END

IF ~~ THEN BEGIN 15
  SAY @10336 /* ~Most certainly. I'd be more than happy to supply you with whatever potions you might need... at a fair price, of course.~ [R#SMI15] */
  IF ~~ THEN REPLY @10337 /* ~Well can I take a look then?~ */ GOTO 16
END

IF ~~ THEN BEGIN 16
  SAY @10338 /* ~Oh, you'll have to wait - my stock is quite empty now. Since, the bandits... and well... my potions... destroyed 'em all.~ [R#SMI16] */
  IF ~~ THEN REPLY @10339 /* ~So you have no potions left? Is it that bad?~ */ GOTO 17
END

IF ~~ THEN BEGIN 17
SAY @10340 /* ~Yes - worse than ever before. Well, I just have to cook up some more potions when I arrive to Cragmyr village. But you can always find me there, if you need some... well... potions or inventions.~ [R#SMI17] */
  IF ~~ THEN REPLY @10341 /* ~Why Cragmyr village? What reasons could you have to go to Cragmyr?~ */ GOTO 18
END

IF ~~ THEN BEGIN 18
  SAY @10342 /* ~Well, a lot of things. It is a quiet little hamlet with little distractions to my studies... and experiments. And Candlekeep, if I ever need to lend some books, is very close!~ [R#SMI18] */
  IF ~~ THEN REPLY @10343 /* ~Well this is a coincidence! Lord Kuldak of Cragmyr is searching for an eng... an inventor to fix his Helmed Horrors. As an inventor you might be familiar with such constructs?~ */ GOTO 19
  IF ~~ THEN REPLY @10344 /* ~I must take my leave, Mal. Farewell.~ */ DO ~AddJournalEntry(@100007,QUEST)
~ EXIT
END

IF ~~ THEN BEGIN 19
  SAY @10345 /* ~Of course! I was actually able to fix and even enhance Lord Pembridge's Horrors in Waterdeep with spell of my own creation! Such a spell! I.. what were we talking about?~ [R#SMI19] */
  IF ~~ THEN REPLY @10346 /* ~About Helmed Horrors and how you know how to fix them.~ */  GOTO 20
END

IF ~~ THEN BEGIN 20
  SAY @10352 /* ~Yes, Yes! I do know how to fix Helmed Horrors! Of course it's going to take time and gold, but I have the first and I guess he has the second!~ [R#SMI20]  */
  IF ~~ THEN REPLY @10353 /* ~Yes, I guess so. So what say you? You willing to talk this over with Lord Kuldak and forge a deal to fix his Helmed Horrors?~ */ GOTO 21
END

IF ~~ THEN BEGIN 21
  SAY @10354 /* ~Absolutely! I'll head to the keep right away and have a business discussion with him. But ta ta for now! Come see me if you are ever there!~ [R#SMI21]  */
  IF ~~ THEN REPLY @10355 /* ~Farewell Mal.~ */ DO ~SetGlobal("Mal_Hired","GLOBAL",1)
EraseJournalEntry(@100007)
AddJournalEntry(@100008,QUEST)
~ EXIT
END

/////////

IF ~~ THEN BEGIN 22
  SAY @10347 /* ~Oh, yes, the damage there - well... it took some time to put out the flames. But my fire extinguishing potions came to rescue.~ [R#SMI22] */
  IF ~~ GOTO 23
END

IF ~~ THEN BEGIN 23
  SAY @10348 /* ~So it was only a matter of time before the flames died down. Quite a mess, but we got it all sorted out.~ [R#SMI23] */
  IF ~~ THEN REPLY @10349 /* ~We? But you are alone here? Was there someone else here too?~ */ GOTO 24
END

IF ~~ THEN BEGIN 24
  SAY @10350 /* ~Oh, well... yes. But, I have no idea where they are now. That's strange. Well nevermind them.~ [R#SMI24] */
  IF ~~ THEN REPLY @10351 /* ~So do you sell these fire extinguishing potions of yours?~ */ GOTO 15
END

/////////

IF WEIGHT #3 ~Global("Know_Mal","GLOBAL",1)
Global("Mal_hired","GLOBAL",0)
~ THEN BEGIN 25
  SAY @10356 /* ~Why, hello again! Can I help you with anything else?~ [R#SMI26] */
  IF ~~ THEN REPLY @10357 /* ~Help you? I saved you? Remember?~ */ GOTO 26
END

IF ~~ THEN BEGIN 26
  SAY @10358 /* ~Oh, be quiet, you! The ladies of the house doesn't need to know that, you know. Ladies love a hero.~ [R#SMI27] */
  IF ~~ THEN REPLY @10359 /* ~Ummm.... What ladies?~ */ GOTO 27
END

IF ~~ THEN BEGIN 27
  SAY @10360 /* ~Well there aren't any now, but rumors fly in small hamlets like these! So how can I help you today?~ */
  IF ~~ THEN REPLY @10361 /* ~You know, Lord Kuldak is searching for an eng... an inventor to fix his Helmed Horrors. As an inventor might you be familiar with such constructs?~ */ GOTO 19
  IF ~~ THEN REPLY @10362 /* ~Just stopped by to say hello. I'll be off. Farewell.~ */ EXIT
END

////////////////

IF WEIGHT #4 ~Global("Mal_hired","GLOBAL",1)
Global("Mal_hired_inform","GLOBAL",0)
~ THEN BEGIN 28
  SAY @10364 /* ~Oh! Hello. I am quite busy right now, but I think you should go speak to Lord Kuldak about our problem here. Have to get back to work now! Bye!~ [R#SMI99] */
  IF ~~ EXIT
END

IF WEIGHT #4 ~Global("Mal_hired","GLOBAL",1)
Global("Mal_hired_inform","GLOBAL",1)
Global("Machine_repair","GLOBAL",0)
~ THEN BEGIN 29
  SAY @10365 /* ~Oh! My apologies... I didn't see you standing there. What can I do for you? Or was there something I was supposed to do for you?~ [R#SMI29] */
  IF ~~ THEN REPLY @10366 /* ~Lord Kuldak said that you needed some help. So is your mending spells working on the Helmed Horrors?~ */ GOTO 30
END

IF ~~ THEN BEGIN 30
  SAY @10367 /* ~My mending spell takes a stretch of time to complete, so you won't see any changes immediately. I can already feel it working, however - I can feel it in my toes!~ [R#SMI30] */
  IF ~~ THEN REPLY @10368 /* ~So, you are saying you can fix the Helmed Horrors?~ */ GOTO 31
END

IF ~~ THEN BEGIN 31
  SAY @10369 /* ~Of course I can! I'll need to find more components though...~ [R#SMI31] */
  IF ~~ THEN REPLY @10370 /* ~What components do you still need?~ */ GOTO 32
END

IF ~~ THEN BEGIN 32
  SAY @10371 /* ~Hmmm... let's see... there's spider silk - fresh spider silk, mind you, not old - belladonna paste, crushed diamonds, a little bit of iron ore, some wood, of course... and um, well, can't remember the last bits, but I have it all written down.~ [R#SMI32] */
  IF ~~ THEN GOTO 33
END

IF ~~ THEN BEGIN 33
  SAY @10372 /* ~I have belladonna paste from my own storage already and Lord Kuldak promised to supply me with wood. But what I am missing are the rest. The iron ore in the area is so tainted that I need to get my hands on a lesser magical weapon or a weapon that is certainly not tainted, like a katana.~ */
  IF ~~ THEN  GOTO 34
END

IF ~~ THEN BEGIN 34
  SAY @10373 /* ~So that is what I need help with... for now at least. Gathering the rest of the ingredients.~ */
  IF ~~ THEN  GOTO 35
END

IF ~~ THEN BEGIN 35
  SAY @10374 /* ~I wrote them all down in that book over there. Interested?.~ [R#SMI35] */
  IF ~~ THEN REPLY @10375 /* ~Alright. I'll keep my eyes open when travelling.~ */ GOTO 36
END

IF ~~ THEN BEGIN 36
  SAY @10376 /* ~Most excellent! When you find the ingredients just place them on the table over there. I'll take care of the rest. But farewell for now!~ [R#SMI36] */
  IF ~~ THEN REPLY @10377 /* ~Farewell.~ */ DO ~SetGlobal("Machine_repair","GLOBAL",1)
EraseJournalEntry(@100009)
AddJournalEntry(@100010,QUEST)
~ EXIT
END

////////////////

IF WEIGHT #4 ~Global("Mal_hired","GLOBAL",1)
Global("Mal_hired_inform","GLOBAL",1)
OR(4)
Global("Machine_repair","GLOBAL",1)
Global("Machine_repair","GLOBAL",3)
Global("Machine_repair","GLOBAL",5)
Global("Machine_repair","GLOBAL",6)
~ THEN BEGIN 37
  SAY @10378 /* ~Ah, welcome back! Something I can help you with? A potion to put some color in your cheeks, perhaps?~ [R#SMI37] */
  IF ~~ THEN REPLY @10379 /* ~Have you had a chance to restock your storage? Can I have a look what you have?~ */ DO ~StartStore("r#smith",LastTalkedToBy(Myself))
~ EXIT
  IF ~OR(4)
Global("Mal_SSILK","GLOBAL",0)
Global("Mal_BASILE","GLOBAL",0)
Global("Mal_SUCCU","GLOBAL",0)
Global("Mal_MAGNE","GLOBAL",0)
~ THEN REPLY @10380 /* ~So you are an inventor? I wonder if you could make me some equipment perhaps?~ */ GOTO 38
  IF ~!GlobalTimerExpired("Mal_SSILKT","LOCALS")
Global("Mal_SSILK","GLOBAL",1)
~ THEN REPLY @10381 /* ~Is the cloak ready already?~ */ GOTO 54
  IF ~GlobalTimerExpired("Mal_SSILKT","LOCALS")
Global("Mal_SSILK","GLOBAL",1)
~ THEN REPLY @10381 /* ~Is the cloak ready already?~ */ GOTO 55
  IF ~!GlobalTimerExpired("Mal_BASILET","LOCALS")
Global("Mal_BASILE","GLOBAL",1)
~ THEN REPLY @10382 /* ~Are the ioun stones ready already?~ */ GOTO 54
  IF ~GlobalTimerExpired("Mal_BASILET","LOCALS")
Global("Mal_BASILE","GLOBAL",1)
~ THEN REPLY @10382 /* ~Are the ioun stones ready already?~ */ GOTO 56
  IF ~!GlobalTimerExpired("Mal_Mal_SUCCUT","LOCALS")
Global("Mal_SUCCU","GLOBAL",1)
~ THEN REPLY @10383 /* ~Are the goggles ready already?~ */ GOTO 54
  IF ~GlobalTimerExpired("Mal_SUCCUT","LOCALS")
Global("Mal_SUCCU","GLOBAL",1)
~ THEN REPLY @10383 /* ~Are the goggles ready already?~ */ GOTO 57
  IF ~!GlobalTimerExpired("Mal_Mal_Mal_MAGNET","LOCALS")
Global("Mal_Mal_MAGNE","GLOBAL",1)
~ THEN REPLY @10384 /* ~Are the gloves ready already?~ */ GOTO 54
  IF ~GlobalTimerExpired("Mal_Mal_MAGNET","LOCALS")
Global("Mal_Mal_MAGNE","GLOBAL",1)
~ THEN REPLY @10384 /* ~Are the gloves ready already?~ */ GOTO 58
  IF ~~ THEN REPLY @10385 /* ~Just stopped by to say hello. Bye!~ */ EXIT
END

IF ~~ THEN BEGIN 38
  SAY @10386 /* ~Absolutely!  I can make *beautiful* clothing thick enough to ward off this winter chill.  What would you like?  Boots?  A cloak?  Perhaps a scarf or hat?  Are gloves more to your liking?  It'll take some time, though - a half-day at least... and a few hundred gold?~ [R#SMI38] */
  IF ~~ THEN REPLY @10387 /* ~Do I have anything you could make into something, then?~ */ GOTO 39
END

IF ~~ THEN BEGIN 39 // from: 58.3 11.0 9.0
  SAY @10388 /* ~Hmmm... I couldn't say. I am not a diviner you see. Let me have a look into your goods.~ */
  IF ~!PartyHasItem("R#SSILK")
!PartyHasItem("R#BASILE")
!PartyHasItem("misc2O")
!PartyHasItem("R#MTRAP2")~ THEN GOTO 40
  IF ~PartyHasItem("R#SSILK")
!Global("Mal_SSILK","GLOBAL",0)
!PartyHasItem("R#BASILE")
!PartyHasItem("misc2O")
!PartyHasItem("R#MTRAP2")~ THEN GOTO 40
  IF ~!PartyHasItem("R#SSILK")
!Global("Mal_BASILE","GLOBAL",0)
PartyHasItem("R#BASILE")
!PartyHasItem("misc2O")
!PartyHasItem("R#MTRAP2")~ THEN GOTO 40
  IF ~PartyHasItem("R#SSILK")
NumItemsPartyLT("R#SSILK",15)
Global("Mal_SSILK","GLOBAL",0)~ THEN GOTO 41
  IF ~NumItemsPartyGT("R#SSILK",14)
Global("Mal_SSILK","GLOBAL",0)~ THEN GOTO 42
  IF ~PartyHasItem("R#BASILE")
NumItemsPartyLT("R#BASILE",2)
Global("Mal_BASILE","GLOBAL",0)~ THEN GOTO 44
  IF ~NumItemsPartyGT("R#BASILE",1)
NumItemsPartyGT("misc39",1)
Global("Mal_BASILE","GLOBAL",0)~ THEN GOTO 45
  IF ~PartyHasItem("misc2O")
Global("Mal_SUCCU","GLOBAL",0)~ THEN GOTO 47
  IF ~PartyHasItem("misc2O")
PartyHasItem("leat04")
NumItemsPartyGT("misc36",1)
Global("Mal_SUCCU","GLOBAL",0)~ THEN GOTO 48
  IF ~PartyHasItem("R#MTRAP2")
!PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 50
  IF ~PartyHasItem("R#MTRAP2")
PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 51
END

IF ~~ THEN BEGIN 40
  SAY @10389 /* ~Hmm. Nope. You've nothing amongst your goods that I could work with. If you come across anything interesting later, you know where to come. Yes?~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 41
  SAY @10390 /* ~It seems you have some fresh spider silk. However there is not enough, but if you get more... I would say 15 batches should be enough to make a Cloak of Arachnida.~ */
  IF ~~ THEN GOTO 43
END

IF ~~ THEN BEGIN 42
  SAY @10391 /* ~It seems you have a lot of spider silk. I could make a Cloak of Arachnida for you if you want? The payment would be... let's say 5000 gold coins. What say you?~ */
  IF ~~ THEN REPLY @10392 /* ~Sure let's do it.~ */ DO ~SetGlobal("Mal_SSILK","GLOBAL",1)
TakePartyItemNum("R#SSILK",15)
DestroyItem("R#SSILK")
DestroyAllDestructableEquipment()
SetGlobalTimer("Mal_SSILKT","LOCALS",3600)
~ GOTO 53
  IF ~~ THEN REPLY @10393 /* ~No thanks. Do I have anything else you could use?~ */ GOTO 43
END

IF ~~ THEN BEGIN 43
  SAY @10394 /* ~Let's have another look.~ */
  IF ~!PartyHasItem("R#BASILE")
!PartyHasItem("misc2O")
!PartyHasItem("R#MTRAP2")~ THEN GOTO 52
  IF ~PartyHasItem("R#BASILE")
!Global("Mal_BASILE","GLOBAL",0)
!PartyHasItem("misc2O")
!PartyHasItem("R#MTRAP2")~ THEN GOTO 52
  IF ~PartyHasItem("R#BASILE")
NumItemsPartyLT("R#BASILE",2)
Global("Mal_BASILE","GLOBAL",0)~ THEN GOTO 44
  IF ~NumItemsPartyGT("R#BASILE",1)
NumItemsPartyGT("misc39",1)
Global("Mal_BASILE","GLOBAL",0)~ THEN GOTO 45
  IF ~PartyHasItem("misc2O")
Global("Mal_SUCCU","GLOBAL",0)~ THEN GOTO 47
  IF ~PartyHasItem("misc2O")
PartyHasItem("leat04")
NumItemsPartyGT("misc36",1)
Global("Mal_SUCCU","GLOBAL",0)~ THEN GOTO 48
  IF ~PartyHasItem("R#MTRAP2")
!PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 50
  IF ~PartyHasItem("R#MTRAP2")
PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 51
END

IF ~~ THEN BEGIN 44
  SAY @10395 /* ~It seems you have a basilisk eye. With one more eye and couple of water opal gems I could make you a great pair ioun stones for you.~ */
  IF ~~ THEN GOTO 46
END

IF ~~ THEN BEGIN 45
  SAY @10396 /* ~It seems you have two basilisk eyes and couple of water opal gems. I could make a great pair of ioun stones for you? The payment would be... let's say 5000 gold coins. What say you?~ */
  IF ~~ THEN REPLY @10392 /* ~Sure let's do it.~ */ DO ~SetGlobal("Mal_BASILE","GLOBAL",1)
TakePartyItemNum("R#BASILE",2)
DestroyItem("R#BASILE")
TakePartyItemNum("misc39",2)
DestroyItem("misc39")
DestroyAllDestructableEquipment()
SetGlobalTimer("Mal_BASILET","LOCALS",3600)
~ GOTO 53
  IF ~~ THEN REPLY @10393 /* ~No thanks. Do I have anything else you could use?~ */ GOTO 46
END

IF ~~ THEN BEGIN 46
  SAY @10394 /* ~Let's have another look.~ */
  IF ~!PartyHasItem("misc2O")
!PartyHasItem("R#MTRAP2")~ THEN GOTO 52
  IF ~PartyHasItem("misc2O")
Global("Mal_SUCCU","GLOBAL",0)~ THEN GOTO 47
  IF ~PartyHasItem("misc2O")
PartyHasItem("leat04")
NumItemsPartyGT("misc36",1)
Global("Mal_SUCCU","GLOBAL",0)~ THEN GOTO 48
  IF ~PartyHasItem("R#MTRAP2")
!PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 50
  IF ~PartyHasItem("R#MTRAP2")
PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 51
END

IF ~~ THEN BEGIN 47
  SAY @10397 /* ~It seems you have some succubus hair! That is a rare sight indeed. It holds the powers of alteration. With couple of pearls and studded leather armor for materials I could make some great goggles to see in any kind of darkness. Come back with the materials and the money, so I can make them for you.~ */
  IF ~~ THEN GOTO 49
END

IF ~~ THEN BEGIN 48
  SAY @10398 /* ~It seems you have some succubus hair! That is a rare sight indeed. It holds the powers of alteration. With couple of pearls and studded leather armor for materials I could make some great goggles to see in any kind of darkness. The payment would be... let's say 5000 gold coins. What say you?~ */
  IF ~~ THEN REPLY @10392 /* ~Sure let's do it.~ */ DO ~SetGlobal("Mal_SUCCU","GLOBAL",1)
TakePartyItemNum("misc2O",1)
DestroyItem("misc2O")
TakePartyItemNum("leat04",1)
DestroyItem("leat04")
TakePartyItemNum("misc36",2)
DestroyItem("misc36")
DestroyAllDestructableEquipment()
SetGlobalTimer("Mal_SUCCUT","LOCALS",3600)
~ GOTO 53
  IF ~~ THEN REPLY @10393 /* ~No thanks. Do I have anything else you could use?~ */ GOTO 49
END

IF ~~ THEN BEGIN 49
  SAY @10394 /* ~Let's have another look.~ */
  IF ~!PartyHasItem("R#MTRAP2")~ THEN GOTO 52
  IF ~PartyHasItem("R#MTRAP2")
!PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 50
  IF ~PartyHasItem("R#MTRAP2")
PartyHasItem("HELM06")
Global("Mal_MAGNE","GLOBAL",0)~ THEN GOTO 51
END

IF ~~ THEN BEGIN 50
  SAY @10399 /* ~It seems you have a Resonance Stone! If you bring me a Helmet of Charm Protection and that stone I can make a Magneto Helmet. It would be a beautiful work of art!~ */
  IF ~~ THEN GOTO 52
END

IF ~~ THEN BEGIN 51
  SAY @10400 /* ~It seems you have the required items to make a Magneto Helmet if you wish. It takes a Resonance Stone and Helmet of Charm Protection. The payment would be... let's say 5000 gold coins. What say you?~ */
  IF ~~ THEN REPLY @10392 /* ~Sure let's do it.~ */ DO ~SetGlobal("Mal_MAGNE","GLOBAL",1)
TakePartyItem("HELM06")
DestroyItem("HELM06")
TakePartyItem("R#MTRAP2")
DestroyItem("R#MTRAP2")
DestroyAllDestructableEquipment()
SetGlobalTimer("Mal_MAGNET","LOCALS",3600)
~ GOTO 53
  IF ~~ THEN REPLY @10393 /* ~No thanks. Do I have anything else you could use?~ */ GOTO 52
END

IF ~~ THEN BEGIN 52
  SAY @10401 /* ~Well it seems that is all I could work with. Come back if you find something else interesting.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 53
  SAY @10402 /* ~Most excellent! It shouldn't take long at all to make. Check back with me later... oh, and don't forget to bring enough gold with you.~ [R#SMI53] */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 54
  SAY @10403 /* ~No, no, it's not ready yet. Give me a little more time.~ [R#SMI54] */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 55
  SAY @10404 /* ~Yes, yes! Here it is. Mighty fine craftsmanship too, if I do say so myself.~ [R#SMI55] */
  IF ~PartyGoldGT(4999)~ THEN REPLY @10405 /* ~Oh great! Here is the gold. Thank you!~ */ DO ~TakePartyGold(5000)
DestroyGold(5000)
SetGlobal("Mal_SSILK","GLOBAL",2)
GiveItemCreate("R#SPIDE1",[PC],0,0,0)
~ EXIT
  IF ~~ THEN REPLY @10406 /* ~I am sorry. I don't have the gold to use for it yet. I'll be back.~ */ EXIT
END

IF ~~ THEN BEGIN 56
  SAY @10404 /* ~Yes, yes! Here it is. Mighty fine craftsmanship too, if I do say so myself.~ [R#SMI55] */
  IF ~PartyGoldGT(4999)~ THEN REPLY @10405 /* ~Oh great! Here is the gold. Thank you!~ */ DO ~TakePartyGold(5000)
DestroyGold(5000)
SetGlobal("Mal_BASILE","GLOBAL",2)
GiveItemCreate("R#BASILI",[PC],0,0,0)
~ EXIT
  IF ~~ THEN REPLY @10406 /* ~I am sorry. I don't have the gold to use for it yet. I'll be back.~ */ EXIT
END

IF ~~ THEN BEGIN 57
  SAY @10404 /* ~Yes, yes! Here it is. Mighty fine craftsmanship too, if I do say so myself.~ [R#SMI55] */
  IF ~PartyGoldGT(4999)~ THEN REPLY @10405 /* ~Oh great! Here is the gold. Thank you!~ */ DO ~TakePartyGold(5000)
DestroyGold(5000)
SetGlobal("Mal_SUCCU","GLOBAL",2)
GiveItemCreate("R#SMITH",[PC],0,0,0)
~ EXIT
  IF ~~ THEN REPLY @10406 /* ~I am sorry. I don't have the gold to use for it yet. I'll be back.~ */ EXIT
END

IF ~~ THEN BEGIN 58
  SAY @10404 /* ~Yes, yes! Here it is. Mighty fine craftsmanship too, if I do say so myself.~ [R#SMI55] */
  IF ~PartyGoldGT(4999)~ THEN REPLY @10405 /* ~Oh great! Here is the gold. Thank you!~ */ DO ~TakePartyGold(5000)
DestroyGold(5000)
SetGlobal("Mal_MAGNE","GLOBAL",2)
GiveItemCreate("R#MAGNE",[PC],0,0,0)
~ EXIT
  IF ~~ THEN REPLY @10406 /* ~I am sorry. I don't have the gold to use for it yet. I'll be back.~ */ EXIT
END

/////////////

IF WEIGHT #4 ~Global("Mal_hired","GLOBAL",1)
Global("Mal_hired_inform","GLOBAL",1)
Global("Machine_repair","GLOBAL",2)~ THEN BEGIN 59
  SAY @10407 /* ~You did it! But it is not functional yet I am afraid. We still need a huge jolt of electricity to turn it on. I might know where to get something like that... but... it will be very dangerous!~ [R#SMI59] */
  IF ~~ THEN REPLY @10408 /* ~What is it? What would I need to do?~ */ GOTO 60
END

IF ~~ THEN BEGIN 60
  SAY @10409 /* ~Well I have... for some time now tried to find a way to produce such a huge jolt of electricity that is needed and I only found one way. In certain areas on the Sword Coast the barrier between the elemental planes and Material Planes are much more... thin... so to say, than elsewhere.~ */
  IF ~~ THEN GOTO 61
END

IF ~~ THEN BEGIN 61
  SAY @10410 /* ~I think... if we release this magical liquid near such a "breach", my own creation if I may say so, the liquid should attract a lightning elemental to come forth from the Quasi-Elemental Plane of Lightning to our own Material Plane!~ */
  IF ~~ THEN GOTO 62
END

IF ~~ THEN BEGIN 62
  SAY @10411 /* ~ After you destroy the elemental, the liquid will... or at least should... absorb its essence without letting it escape! Ingenious isn't it?~ */
  IF ~~ THEN REPLY @10412 /* ~So what you need me for is... hunting a lighting elemental? Sure, I'll keep my eyes open when travelling. Where should I look for these "breaches"?~ */ GOTO 63
END

IF ~~ THEN BEGIN 63
  SAY @10413 /* ~Well.. what I have been able to find out is that there are atleast three such "breaches" here on Sword Coast. I think one was near a village... a halfling village. Can't rightly remember the name. One was on the coast in Cloakwood and one was in some abandoned castle to the south-west. Well at least I think it is abandoned.~ */
  IF ~~ THEN REPLY @10414 /* ~Very well. I shall try to obtain the essence for you.~ */ GOTO 64
END

IF ~~ THEN BEGIN 64
  SAY @10415 /* ~Most excellent! You can just place it on the table when you have it. I will do the rest! And almost forgot! Here is the elemental liquid you will need. Ta ta for now!~ [R#SMI64] */
  IF ~~ THEN DO ~SetGlobal("Machine_repair","GLOBAL",3)
GiveItemCreate("R#PORTAL",[PC],1,1,0)
EraseJournalEntry(@100010)
AddJournalEntry(@100011,QUEST)
~ EXIT
END

/////////

IF WEIGHT #4 ~Global("Mal_hired","GLOBAL",1)
Global("Mal_hired_inform","GLOBAL",1)
Global("Machine_repair","GLOBAL",4)~ THEN BEGIN 65
  SAY @10416 /* ~You did it! I bet it wasn't easy defeating such a creature. But nonetheless the machine and the helmed horrors are now fully operational! I think you should be the one to inform Lord Kuldak these happy news.~ [R#SMI59] */
  IF ~~ THEN REPLY @10417 /* ~Sure thing. I will inform him.~ */ GOTO 66
END

IF ~~ THEN BEGIN 66
  SAY @10418 /* ~And if you are ever in a need concoctions, elixirs or potions, come back and browse! I would be delighted.~ */
  IF ~~ THEN DO ~SetGlobal("Machine_repair","GLOBAL",5)
~ EXIT
END

//////////////////////////////////////////////////
// Captain Eddard
//////////////////////////////////////////////////
BEGIN ~R#CRAGG3~

IF WEIGHT #0 ~ GlobalLT("Kuldak_quest1","GLOBAL",3)
Global("Know_Kuldak","GLOBAL",0)
Global("Keep_repairs","GLOBAL",0)
~ THEN BEGIN 0
  SAY @10500 /* ~Hello there. You have no business here in Cragmyr Keep. I think you should leave or speak to Lord Kuldak in the Old Plough tavern.~ */
  IF ~~ EXIT
END

IF WEIGHT #0 ~ GlobalLT("Kuldak_quest1","GLOBAL",3)
Global("Know_Kuldak","GLOBAL",1)
Global("Keep_repairs","GLOBAL",0)
~ THEN BEGIN 1 // from:
  SAY @10501 /* ~Hello there. I think you should speak to Lord Kuldak. If you accept his offer, come to me afterwards.~ */
  IF ~~ EXIT
END

IF WEIGHT #0 ~ Global("Kuldak_quest1","GLOBAL",3)
Global("Know_Kuldak","GLOBAL",1)
Global("Keep_repairs","GLOBAL",0)
~ THEN BEGIN 2 // from:
  SAY @10502 /* ~Hello there. So Lord Kuldak sent you to me to do some tasks to repair the keep and its defenses. Good. You seem capable enough.~ */
  IF ~~ GOTO 3
END

IF ~~ THEN BEGIN 3 // from: 9.0 1.0 0.0
  SAY @10503 /* ~But first things first. Introductions that is. I am Captain Eddard and I'm second in charge here. Anyone causing trouble in Cragmyr shall answer to me.~ */
  IF ~~ THEN REPLY @10504 /* ~Well met Ed... Captain Eddard. My name is <CHARNAME>.~ */ GOTO 4
  IF ~~ THEN REPLY @10505 /* ~I am not here to chitchat. Let's get into business.~ */ GOTO 4
END

IF ~~ THEN BEGIN 4 // from: 2.2 2.1 2.0
  SAY @10506 /* ~Yes, well... I suspect Kuldak explained our situation here. The keep is in even more bad condition than Kuldak knows. He is a Lord of the surrounding lands so his feet are not always on the ground.~ */
  IF ~~ THEN REPLY @10507 /* ~So what is the problem?~ */ GOTO 5
END

IF ~~ THEN BEGIN 5 // from: 3.1 3.0
  SAY @10508 /* ~Well, first of all we have of a problem of multiplying ochre jellys in the dungeon and we don't seem to get rid of them no matter how many we kill. I cannot lose anymore my militia's morale or limbs to these things so I need 'em gone.~ */
  IF ~~ GOTO 6
END

IF ~~ THEN BEGIN 6 // from: 4.1 4.0
  SAY @10509 /* ~I would bet my month's pay that the big one is hiding in the old Helmed Horror machinery room. But no one knows where it is and the militia doesn't have time to search for secret hidden rooms. So you task is to find that room and get rid of them all.~ */
  IF ~  GlobalGT("ochre_dead","GLOBAL",5)
~ THEN REPLY @10510 /* ~We've already been down into the dungeon and killed all the ochre jellys we found down there.~ */ DO ~SetGlobal("Keep_repairs","GLOBAL",2)
~ GOTO 9
  IF ~  GlobalLT("ochre_dead","GLOBAL",6)
~ THEN REPLY @10511 /* ~I will kill those for you... for a price.~ */ DO ~SetGlobal("Keep_repairs","GLOBAL",1)
~ GOTO 7
  IF ~  GlobalLT("ochre_dead","GLOBAL",6)
~ THEN REPLY @10512 /* ~I see what I can do.~ */ DO ~AddJournalEntry(@100002,QUEST)
SetGlobal("Keep_repairs","GLOBAL",1)
~ EXIT
END

IF ~~ THEN BEGIN 7 // from: 8.2
  SAY @10513 /* ~Well now! Aren't we the greedy one? Very well, I will give you 50 gold coins from my own pay to get rid of them.~ */
  IF ~~ THEN REPLY @10514 /* ~All right, all right. I'll see what I can do.~ */ DO ~AddJournalEntry(@100002,QUEST)
SetGlobal("Keep_repairs","GLOBAL",1)
SetGlobal("ochre_money","GLOBAL",1)
~ EXIT
END

IF WEIGHT #1 ~  Global("Keep_repairs","GLOBAL",1)
~ THEN BEGIN 8 // from:
  SAY @10515 /* ~Any luck getting rid of those nasty jellys? We have equipment there we could use, so make haste.~ */
  IF ~  GlobalLT("ochre_dead","GLOBAL",6)
~ THEN REPLY @10516 /* ~Not just yet. I'm working on it, though.~ */ EXIT
  IF ~  GlobalGT("ochre_dead","GLOBAL",5)
GlobalLT("ochre_money","GLOBAL",1)
~ THEN REPLY @10517 /* ~It is done. I found a big ugly one hiding where you said it would be hiding. Those ochre jellys won't be troubling you anymore.~ */ DO ~SetGlobal("Keep_repairs","GLOBAL",2)
~ GOTO 9
  IF ~  GlobalGT("ochre_dead","GLOBAL",5)
GlobalGT("ochre_money","GLOBAL",0)
~ THEN REPLY @10517 /* ~It is done. I found a big ugly one hiding where you said it would be hiding. Those ochre jellys won't be troubling you anymore.~ */ DO ~SetGlobal("Keep_repairs","GLOBAL",2)
~ GOTO 9
END

IF ~~ THEN BEGIN 9 // from: 12.4 12.3 12.2 5.0
  SAY @10518 /* ~You're a lifesaver. Just do me one more favor... keep this little jelly problem between you and me. I don't want folks thinking Cragmyr Keep has problems like these.~ */ 
  IF ~~ THEN DO ~GiveGoldForce(50)
~ GOTO 10
END

IF ~~ THEN BEGIN 10 // from: 12.4 12.3 12.2 5.0
  SAY @10519 /* ~But then to the second matter at hand. We had a lot of new construction equipment and such coming from Baldur's Gate. But it seems the caravan has failed to deliver.~ */
  IF ~~ THEN GOTO 11
END

IF ~~ THEN BEGIN 11 // from: 12.4 12.3 12.2 5.0
  SAY @10520 /* ~My worst fear is it was attacked by bandits. However, we cannot be sure, so maybe you can find out what happened. It could be anywhere between here and Baldur's Gate. Lord Kuldak promised to pay the value of the equipment to anyone who finds them.~ */
  IF ~~ THEN REPLY @10521 /* ~Very well. I keep my eyes open when travelling.~ */ DO ~EraseJournalEntry(@100002)
AddJournalEntry(@100003,QUEST)
~ EXIT
END

IF WEIGHT #2 ~ Global("Keep_repairs","GLOBAL",2) 
~ THEN BEGIN 12 // from: 12.4 12.3 12.2 5.0
  SAY @10522 /* ~Back again I see. Do you have any new information about the caravan? Do you know what happened?~ */
  IF ~Global("Mal_Ambush_Solved","GLOBAL",1)
~ THEN REPLY @10523 /* ~I found the caravan just north of Friendly Arm Inn. It had been attacked by bandits, but it seems they only took everything made out of iron. So you could send your people to gather the construction equipment.~ */ DO ~SetGlobal("Keep_repairs","GLOBAL",3)
EraseJournalEntry(@100004)
AddJournalEntry(@100005,QUEST)
~ GOTO 13
  IF ~~ THEN REPLY @10524 /* ~No news yet, sorry.~ */ EXIT
END

IF ~~ THEN BEGIN 13
  SAY @10525 /* ~This is dire and good news at the same time. Very well. I shall send my men to gather the equipment so we can atleast fix some of the walls. You should inform Kuldak about our progress here and he will also give you your reward.~ */
  IF ~~ GOTO 14
END

IF ~~ THEN BEGIN 14
  SAY @10526 /* ~Good job! And farewell for now.~ */
  IF ~~ EXIT
END

IF WEIGHT #3 ~Global("Keep_repairs","GLOBAL",3)
~ THEN BEGIN 15
  SAY @10527 /* ~My men are fetching the supplies as we speak. You should speak to Kuldak.~ */
  IF ~~ THEN EXIT
END

IF WEIGHT #3 ~Global("Keep_repairs","GLOBAL",4)
~ THEN BEGIN 15
  SAY @10528 /* ~We are fixing the walls as we speak. Thanks to you! Keep up the good work soldier!~ */
  IF ~~ THEN EXIT
END



//////////////////////////////////////////////////
// NOBLE DJINNI
//////////////////////////////////////////////////
BEGIN ~R#DJINNI~

IF ~True()
~ THEN BEGIN 0
  SAY @10600 /* ~I am free! Finally I am free! Thanks to you noble creature I am free! Who is this who has freed me?~ */
  IF ~~ THEN REPLY @10601 /* ~I'm <CHARNAME>. Who... or what are you?~ */ GOTO 1
  IF ~~ THEN REPLY @10602 /* ~None of your business. What are you?~ */ GOTO 1
END

IF ~~ THEN BEGIN 1 // from:
  SAY @10603 /* ~I am a noble djinni trapped here eons ago and thanks to you I am finally free. And to show my thanks, I will grant you a wish. Choose wisely!~ */
  IF ~~ THEN REPLY @10604 /* ~I wish for a powerful magical item.~ */ GOTO 2
  IF ~~ THEN REPLY @10605 /* ~I wish to be physically more strong.~ */ GOTO 3
  IF ~~ THEN REPLY @10606 /* ~I wish for more endurance.~ */ GOTO 4
  IF ~~ THEN REPLY @10607 /* ~I wish for more agility.~ */ GOTO 5
  IF ~~ THEN REPLY @10608 /* ~I wish for more wisdom to make my decisions.~ */ GOTO 6
  IF ~~ THEN REPLY @10609 /* ~I wish to be smarter more.~ */ GOTO 7
  IF ~~ THEN REPLY @10610 /* ~I wish I could dazzle my enemies with my words.~ */ GOTO 8
END

IF ~~ THEN BEGIN 2 // from:
  SAY @10611 /* ~Then you shall have it.~ */ 
IF ~~ THEN DO ~GiveItemCreate("R#DJINNI",LastTalkedToBy,0,0,0)
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 3 // from:
  SAY @10612 /* ~Study this book and you shall receive what you ask.~ */ 
IF ~~ THEN DO ~GiveItemCreate("book04",LastTalkedToBy,0,0,0)
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 4 // from:
  SAY @10612 /* ~Study this book and you shall receive what you ask.~ */ 
IF ~~ THEN DO ~GiveItemCreate("book03",LastTalkedToBy,0,0,0)
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 5 // from:
  SAY @10612 /* ~Study this book and you shall receive what you ask.~ */ 
IF ~~ THEN DO ~GiveItemCreate("book05",LastTalkedToBy,0,0,0)
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 6 // from:
  SAY @10612 /* ~Study this book and you shall receive what you ask.~ */ 
IF ~~ THEN DO ~GiveItemCreate("book08",LastTalkedToBy,0,0,0)
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 7 // from:
  SAY @10612 /* ~Study this book and you shall receive what you ask.~ */ 
IF ~~ THEN DO ~GiveItemCreate("book06",LastTalkedToBy,0,0,0)
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END

IF ~~ THEN BEGIN 8 // from:
  SAY @10612 /* ~Study this book and you shall receive what you ask.~ */ 
IF ~~ THEN DO ~GiveItemCreate("book07",LastTalkedToBy,0,0,0)
SetInterrupt(FALSE)
ForceSpell(Myself,DRYAD_TELEPORT)~ EXIT
END



//////////////////////////////////////////////////
// RUMORS
//////////////////////////////////////////////////
APPEND ~RBEREG~
  IF ~ True()
~ THEN BEGIN CRAGRUM0
    SAY @150000
  IF ~~ THEN UNSOLVED_JOURNAL @160000 /* ~Troubles in the Region
Rumors say that Cragmyr Keep is being harrashed by a horde of ogres. Nobody knows why this is happening now, since the ogre tribes have always been on the area.~ */ EXIT
END 

  IF ~ True()
~ THEN BEGIN CRAGRUM1
    SAY @150001
  IF ~~ THEN UNSOLVED_JOURNAL @160001 /* ~Troubles in the Region
Amn and Flaming Fist are both trying to get Lord Kuldak to favor their side in case of a war.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM2
    SAY @150002
  IF ~~ THEN UNSOLVED_JOURNAL @160002 /* ~Troubles in the Region
Lord Kuldak is trying to fix the keep for immediate attacks from ogres.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM3
    SAY @150003
  IF ~~ THEN UNSOLVED_JOURNAL @160003 /* ~Troubles in the Region
For some reason caravans seem to be avoiding Cragmyr Keep. They seem to have trouble getting supplies.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM4
    SAY @150004
  IF ~~ THEN UNSOLVED_JOURNAL @160004 /* ~Troubles in the Region
Cragmyr Keep seems to have had troubles with thieves. Although, obody seems to know what they were after.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM5
    SAY @150005
  IF ~~ THEN UNSOLVED_JOURNAL @160005 /* ~Troubles in the Region
Cragmyr Keep seems to have had troubles with thieves. Although, obody seems to know what they were after.~ */ EXIT
END
END



APPEND ~RNASHK~
  IF ~ True()
~ THEN BEGIN CRAGRUM0
    SAY @150000
  IF ~~ THEN UNSOLVED_JOURNAL @160000 /* ~Troubles in the Region
Rumors say that Cragmyr Keep is being harrashed by a horde of ogres. Nobody knows why this is happening now, since the ogre tribes have always been on the area.~ */ EXIT
END 

  IF ~ True()
~ THEN BEGIN CRAGRUM1
    SAY @150001
  IF ~~ THEN UNSOLVED_JOURNAL @160001 /* ~Troubles in the Region
Amn and Flaming Fist are both trying to get Lord Kuldak to favor their side in case of a war.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM2
    SAY @150002
  IF ~~ THEN UNSOLVED_JOURNAL @160002 /* ~Troubles in the Region
Lord Kuldak is trying to fix the keep for immediate attacks from ogres.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM3
    SAY @150003
  IF ~~ THEN UNSOLVED_JOURNAL @160003 /* ~Troubles in the Region
For some reason caravans seem to be avoiding Cragmyr Keep. They seem to have trouble getting supplies.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM4
    SAY @150004
  IF ~~ THEN UNSOLVED_JOURNAL @160004 /* ~Troubles in the Region
Cragmyr Keep seems to have had troubles with thieves. Although, obody seems to know what they were after.~ */ EXIT
END

  IF ~ True()
~ THEN BEGIN CRAGRUM5
    SAY @150005
  IF ~~ THEN UNSOLVED_JOURNAL @160005 /* ~Troubles in the Region
Cragmyr Keep seems to have had troubles with thieves. Although, obody seems to know what they were after.~ */ EXIT
END
END


//////////////////////////////////////////////////
// Talessyr Tranth
//////////////////////////////////////////////////
BEGIN ~R#TALESS~

IF WEIGHT #1
~NumTimesTalkedTo(0)
AreaCheck("RANI46")
~ THEN BEGIN 0
  SAY @12000 /* ~Welcome, my little friends! Please, relax, and keep your weapons at your sides. So, how may I help you? Would you like to change your appearance perhaps? Or just to scare your neighbours?~ */
IF ~~ THEN REPLY @12001 /* ~What do you actually sell? Cosmetics?~ */ GOTO 1
END

IF ~~ THEN BEGIN 1
  SAY @12002 /* ~Adornments, concoctions, elixirs and potions of transmutation in nature. But the best way to understand is try them yourself. Care to browse?~ */
  IF ~~ THEN REPLY @12003 /* ~Sure. Let me see what you have.~ */ DO ~StartStore("R#TALESS",LastTalkedToBy(Myself))
~ EXIT
  IF ~~ THEN REPLY @12004 /* ~Not today. Maybe some other time. Bye.~ */ EXIT
  IF ~Global("TEW_caravanquest","GLOBAL",3)~ THEN REPLY @12006 /* ~I heard a rumor that you might be dealing with some strange magical resonance stones. Is this true?~ */ GOTO 3
END

IF WEIGHT #1
~NumTimesTalkedToGT(0)
AreaCheck("RANI46")
~ THEN BEGIN 2
  SAY @12000 /* ~Welcome, my little friends! Please, relax, and keep your weapons at your sides. So, how may I help you? Would you like to change your appearance perhaps? Or just to scare your neighbours?~ */
  IF ~~ THEN REPLY @12005 /* ~Sure. Let me see what you have.~ */ DO ~StartStore("R#TALESS",LastTalkedToBy(Myself))
~ EXIT
  IF ~~ THEN REPLY @12004 /* ~Not today. Maybe some other time. Bye.~ */ EXIT
  IF ~Global("TEW_caravanquest","GLOBAL",3)~ THEN REPLY @12006 /* ~I heard a rumor that you might be dealing and tampering with some strange magical resonance stones. Is this true?~ */ GOTO 3
END

IF ~~ THEN BEGIN 3
  SAY @12007 /* ~What? Where did you hear such a nonsense? I am a simple merchant of transmutation potions. Nothing illegal or sinister happening here! Now, if you are not buying anything I will have to ask you to leave.~ */ 
  IF ~~ THEN REPLY @12003 /* ~Sure. Let me see what you have.~ */ DO ~AddJournalEntry(@100109,QUEST)
EraseJournalEntry(@100106)
EraseJournalEntry(@100107)
EraseJournalEntry(@100108)
SetGlobal("TEW_caravanquest","GLOBAL",4)
StartStore("R#TALESS",LastTalkedToBy(Myself))
~ EXIT
  IF ~~ THEN REPLY @12004 /* ~Not today. Maybe some other time. Bye.~ */ DO ~SetGlobal("TEW_caravanquest","GLOBAL",4)
AddJournalEntry(@100109,QUEST)
EraseJournalEntry(@100106)
EraseJournalEntry(@100107)
EraseJournalEntry(@100108)
~ EXIT
END

IF WEIGHT #1
~AreaCheck("RANI54")
Global("TEW_BEGGARGOLD","GLOBAL",1)
~ THEN BEGIN 4
  SAY @12008 /* ~Burglars? How the hell did you obtain the password? But... You are the meddlesome adventurers who have been following me! That beggar could have specified a little bit more.~ */
  IF ~~ THEN REPLY @12009 /* ~The beggar told you we would be following you?~ */ GOTO 5
END

IF ~~ THEN BEGIN 5
  SAY @12010 /* ~Yes. A little bit too late, but still. I should have listened to my brother. He warmed me about you.~ */
  IF ~~ THEN REPLY @12012 /* ~You're a woman? How come?~ */ GOTO 7
  IF ~~ THEN REPLY @12015 /* ~I guess Iltar never bothered to mention that you are his sister.~ */ GOTO 8
END

IF ~~ THEN BEGIN 7
  SAY @12014 /* ~Haha! How observant of you. I guess you never heard about transmutation magic. I hope my brother won't be too sad when I get rid of you. Let's dance!~ */
  IF ~~ THEN DO ~Enemy()
SetGlobal("TDOOR_BREAKIN","GLOBAL",1)
~ EXIT
END

IF ~~ THEN BEGIN 8
  SAY @12016 /* ~Of course not. And why should he. Not that many even know that I am a woman. But enough chit chat. You have obviously come to kill me, so let's give it a go, shall we?~ */
  IF ~~ THEN DO ~Enemy()
SetGlobal("TDOOR_BREAKIN","GLOBAL",1)
~ EXIT
END

IF WEIGHT #1
~AreaCheck("RANI54")
Global("TEW_BEGGARGOLD","GLOBAL",0)
~ THEN BEGIN 9
  SAY @12017 /* ~Burglars? How the hell did you obtain the password? Hmmm. I guess you must have been following me. It did feel like I was being followed the other night.~ */
  IF ~~ THEN REPLY @12018 /* ~I guess you should have listened to your feeling.~ */ GOTO 10
END

IF ~~ THEN BEGIN 10
  SAY @12019 /* ~Yes. I guess I should have. I also should have listened to my brother. He warmed me about you.~ */
  IF ~~ THEN REPLY @12012 /* ~You're a woman? How come?~ */ GOTO 7
  IF ~~ THEN REPLY @12015 /* ~I guess Iltar never bothered to mention that you are his sister.~ */ GOTO 8
END


//////////////////////////////////////////////////
// Hans Olo the Smuggler
//////////////////////////////////////////////////
BEGIN ~R#HANS~

IF ~  NumberOfTimesTalkedTo(0)
~ THEN BEGIN 0 // from:
  SAY @13000 /* ~Good business, my <LADYLORD>. I don't think I've seen you before... perhaps you might be interested in looking at some well-priced goods that have fallen into my hands?~ */
  IF ~~ THEN REPLY @13001 /* ~Are you trying to tell me that these goods are stolen?~ */ GOTO 1
  IF ~~ THEN REPLY @13002 /* ~Sure, let me see what you have.~ */ GOTO 2
  IF ~~ THEN REPLY @13003 /* ~No, I'm not interested in anything.~ */ GOTO 3
END

IF ~~ THEN BEGIN 1 // from: 4.0 0.0
  SAY @13004 /* ~I don't think of them as stolen, my <PRO_LADYLORD>. Since I am merely a messenger of these fine goods. I take these goods from Amn to the Sword Coast and I ask no questions where they came from.~ */
  IF ~~ THEN REPLY @13005 /* ~Well, I'll have no qualms about it. Let me see what you have to offer.~ */ GOTO 2
  IF ~~ THEN REPLY @13006 /* ~Not interested.~ */ GOTO 3
END

IF ~~ THEN BEGIN 2 // from: 4.1 1.0 0.1
  SAY @13007 /* ~A most prudent choice, and one you'll quickly see is worth your while.~ */
  IF ~~ THEN DO ~StartStore("R#HANS",LastTalkedToBy(Myself))
~ EXIT
END

IF ~~ THEN BEGIN 3 // from: 5.1 4.2 1.1 0.2
  SAY @13008 /* ~That is too bad, my <LADYLORD>. Perhaps you are in need of a few coppers? Or shall I find you some swaddling clothes?~ */
END

IF ~  True()
~ THEN BEGIN 4 // from:
  SAY @13009 /* ~Ah! It is good to see you again, my <LADYLORD>. Might you be interested in perusing some goods that have fallen into my hands?~ */
  IF ~~ THEN REPLY @13010 /* ~You are selling stolen goods?~ */ GOTO 1
  IF ~~ THEN REPLY @13011 /* ~Yes, let me see what you have.~ */ GOTO 2
  IF ~~ THEN REPLY @13012 /* ~No, thanks.~ */ GOTO 3
END



//////////////////////////////////////////////////
// Elijah Hjout
//////////////////////////////////////////////////
BEGIN ~R#ELJA~

IF WEIGHT #1
~ Global("TEW_caravanquest","GLOBAL",0)
Global("TEW_Smugglers","GLOBAL",0)
~ THEN BEGIN 0 // from:
  SAY @14000 /* ~Who are you?~ [R#ELJ00] */
  IF ~~ THEN REPLY @14001 /* ~We are adventurers and I suggest you adopt a more civil tone.~ */ GOTO 1
  IF ~~ THEN REPLY @14047 /* ~We are adventurers. May I ask a few questions?~ */ GOTO 30
  IF ~Global("Kuldak_quest1","GLOBAL",5)
~ THEN REPLY @14002 /* ~We are adventurers. I heard that you might be having a problem here with the Amnian delegation.~ */ GOTO 2
END

IF ~~ THEN BEGIN 1 // from:
  SAY @14003 /* ~I don't have time to trade words with sell-swords that think too highly of themselves. Begone!~ [R#ELJ01] */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 2 // from:
  SAY @14004 /* ~What? Where did you hear this?~ */
  IF ~~ THEN REPLY @14005 /* ~Well everyone in Cragmyr Village knows about it. You really can't miss it. Yes?~ */ GOTO 3
END

IF ~~ THEN BEGIN 3 // from:
  SAY @14006 /* ~Yes. What do you want?~ [R#ELJ03] */
  IF ~~ THEN REPLY @14007 /* ~Nothing. Sorry to bother you.~ */ EXIT
  IF ~GlobalLT("ScarMission","GLOBAL",5)
~ THEN REPLY @14008 /* ~Well I was thinking maybe you needed some help with this Amnian ambassador? If you catch my meaning.~ */ GOTO 4
  IF ~GlobalGT("ScarMission","GLOBAL",4)
~ THEN REPLY @14008 /* ~Well I was thinking maybe you needed some help with this Amnian ambassador? If you catch my meaning.~ */ GOTO 5
END

IF ~~ THEN BEGIN 4 // from:
  SAY @14009 /* ~What? You suggest dirty play? I don't even know you. Begone!~ */
  IF ~~ THEN DO ~AddJournalEntry(@100100,QUEST)
~ EXIT
END

IF ~~ THEN BEGIN 5 // from:
  SAY @14010 /* ~Hmmm. Well I did hear good and trustworthy things about you from Scar. I guess you have the best interest of this region in mind. Maybe you can be of help.~ */ 
  IF ~~ THEN GOTO 20
END

IF ~~ THEN BEGIN 6 // from:
  SAY @14011 /* ~We have a problem here in our hands with this Amnian delegation. For sometime now, almost every single trade caravan, which is not many due to the bandit problems, is passing Cragmyr Keep and not stopping here.~ */ 
  IF ~~ THEN GOTO 7
END

IF ~~ THEN BEGIN 7 // from:
  SAY @14012 /* ~I would bet my year's pay that the Amnian ambassador, Iltar, has had his dirty hands in this somehow. The caravans pass the village and the caravaners themselves will tell us nothing.~ */
  IF ~~ THEN GOTO 8
END

IF ~~ THEN BEGIN 8 // from:
  SAY @14013 /* ~As you no doubt already know, after the arrival Iltar, he revealed that the Flaming Fist, by issuing a trade block on Cragmyr, is responsible for Cragmyr's supply problems. Lord Kuldak believed Iltar and all the evidence does point to us, so he now blames the Flaming Fist for this a trade block.~ [R#ELJ08] */
  IF ~~ THEN GOTO 9
END

IF ~~ THEN BEGIN 9 // from:
  SAY @14014 /* ~The Flaming Fist is the only one in the Sword Coast who could actually issue such a sanction. However, the Flaming Fist has not issued a trade block. In the mean time, Iltar has promised Lord Kuldak with infinite supply of provisions, if he decides to make an alliance with Amn.~ */
  IF ~~ THEN REPLY @14015 /* ~Couldn't the Flaming Fist provide Cragmyr with supplies?~ */ GOTO 10
END

IF ~~ THEN BEGIN 10 // from:
  SAY @14016 /* ~Don't think that hadn't crossed my mind. In a way we could, even if our resources are already stretched thin. But I have strict orders not to provide Cragmyr with supplies or militaristic aid if Lord Kuldak doesn't make an alliance with us since the supplies could end up in the hands of a enemy. Until then, the Flaming Fist or Baldur's Gate won't help Cragmyr militarily or otherwise.~ [R#ELJ10] */
  IF ~~ THEN REPLY @14017 /* ~So, how can I help the Flaming Fist with this matter at hand?~ */ GOTO 11
END

IF ~~ THEN BEGIN 11 // from:
  SAY @14018 /* ~I need you to find out proof that Iltar and Amn is behind this caravan block on Cragmyr Keep and tries to discredit the Flaming Fist. The caravaners won't co-operate with the Flaming Fist, but maybe they will with you.~ */
  IF ~~ THEN GOTO 12
END

IF ~~ THEN BEGIN 12 // from:
  SAY @14019 /* ~A small caravan just passed Cragmyr not so long ago heading south. I would suggest that you start your investigation from there. I bet if you hurry you can still catch it. Best of luck!~ */
  IF ~~ THEN REPLY @14020 /* ~Alright, I see what I can find out. Farewell.~ */ DO ~SetGlobal("TEW_caravanquest","GLOBAL",1)
AddJournalEntry(@100101,QUEST)
EraseJournalEntry(@100100)
~ EXIT
END

IF WEIGHT #1 ~Global("TEW_caravanquest","GLOBAL",1)~ THEN BEGIN 13
  SAY @14021 /* ~You've returned. Did you manage to find out anything from the caravaners?~ [R#ELJ13] */
  IF ~~ THEN REPLY @14022 /* ~Nothing yet.~ */ EXIT
  IF ~~ THEN REPLY @14050 /* ~I have a few questions, if I may.~ */ GOTO 29
  IF ~Global("reso_stone_ob","GLOBAL",1)
PartyHasItem("R#MTRAP")
~ THEN REPLY @14023 /* ~We found this strange stone in the tent of a gem merchant. It has a... strange resonance in it. It feels like I should avoid Cragmyr when in its proximity. And it feels like the Flaming Fist has done so. None of the caravaners seemed to be aware of its existence or its influence.~ */ GOTO 14
END

IF ~~ THEN BEGIN 14
  SAY @14024 /* ~Ah, a curious tale that - and not even other Flaming Fist officers were able to change their mind to stop here. Very curious indeed. I sadly don't know much about this kind of magical items or their origin, and all the Flaming Fist wizards are otherwise engaged.~ [R#ELJ14] */
  IF ~~ THEN GOTO 15
END

IF ~~ THEN BEGIN 15
  SAY @14025 /* ~But there are a couple of powerful wizards on the Sword Coast who certainly are familiar with such items. I suggest you consult either of them: Thalantyr at High Hedge or Halbazzer Drin in Baldur's Gate. The one behind this must be caught and brought to justice.~ */
  IF ~~ THEN GOTO 16
END

IF ~~ THEN BEGIN 16
  SAY @14026 /* ~Go from building to building, warehouse to warehouse, if need be. Find this deviant before he causes more harm. Good luck!~ [R#ELJ16] */
  IF ~~ THEN DO ~SetGlobal("TEW_caravanquest","GLOBAL",2)
AddJournalEntry(@100105,QUEST)
EraseJournalEntry(@100104)
~ EXIT
END

IF WEIGHT #1 
~ OR(2)
GlobalGT("TEW_caravanquest","GLOBAL",0)
GlobalGT("TEW_SMUGGLERS","GLOBAL",0)
OR(2)
Global("TEW_ogrequest","GLOBAL",0)
GlobalGT("TEW_ogrequest","GLOBAL",1)
~ THEN BEGIN 17
  SAY @14027 /* ~Now, I want a full report.~ [R#ELJ17] */
  IF ~~ THEN REPLY @14028 /* ~Nothing to report yet.~ */ EXIT
  IF ~~ THEN REPLY @14050 /* ~I have a few questions, if I may.~ */ GOTO 29
  IF ~Global("TEW_caravanquest","GLOBAL",8)
PartyHasItem("R#TALESB")~ THEN REPLY @14029 /* ~I found something very interesting in Baldur's Gate about the trade block. [Give Talessyr's Potion Log]~ */ DO ~TakePartyItem("R#TALESB")
DestroyItem("R#TALESB")
SetGlobal("TEW_caravanquest","GLOBAL",9)
~ GOTO 18
  IF ~Global("TEW_caravanquest","GLOBAL",8)~ THEN REPLY @14030 /* ~Sadly I didn't find any hard evidence about the trade block. You should however send men to search a house near the east gates. It will be the end of the trade block.~ */ DO ~SetGlobal("TEW_caravanquest","GLOBAL",9)
~ GOTO 19
END

IF ~~ THEN BEGIN 18
  SAY @14031 /* ~This evidence will surely turn the tide to our favor and make Lord Kuldak believe the Flaming Fist was not behind the trade block after all.~ */
  IF ~~ THEN DO ~AddJournalEntry(@100116,QUEST_DONE)
EraseJournalEntry(@100113)
EraseJournalEntry(@100114)
EraseJournalEntry(@100115)
~ GOTO 21
END

IF ~~ THEN BEGIN 19
  SAY @14032 /* ~Well, at least we can break the trade block even if we can't make Lord Kuldak believe that we didn't set it up in the first place.~ */
  IF ~~ THEN DO ~AddJournalEntry(@100117,QUEST_DONE)
EraseJournalEntry(@100113)
EraseJournalEntry(@100114)
EraseJournalEntry(@100115)
~ GOTO 21
END

IF ~~ THEN BEGIN 20
  SAY @14033 /* ~I would ask you to excuse my rudeness when you first arrived. These negotiations with Lord Kuldak have been chipping away my patience, and now delegation from Amn has arrived.~ [R#ELJ20] */ 
  IF ~~ THEN GOTO 6
END

IF ~~ THEN BEGIN 21
  SAY @14034 /* ~Thanks again for all you have done. I however do have more I need from you, if you are interested.~ [R#ELJ21] */
  IF ~~ THEN REPLY @14035 /* ~I am not interested being affiliated with the Flaming Fist more than this.~ */ GOTO 22
  IF ~~ THEN REPLY @14036 /* ~Sure. I am interested.~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",2)
~ GOTO 24
  IF ~~ THEN REPLY @14050 /* ~I have a few questions, if I may.~ */ GOTO 29
END

IF ~~ THEN BEGIN 22
  SAY @14037 /* ~You may think you can take your services elsewhere, mercenary. But I guarantee, no other company but the Flaming Fist will hire you on the Sword Coast. We, in the end, are the law.~ [R#ELJ22] */ 
  IF ~~ THEN DO ~SetGlobal("TEW_ogrequest","GLOBAL",1)
AddJournalEntry(@100118,QUEST)
~ EXIT
END

IF WEIGHT #1
~ Global("TEW_ogrequest","GLOBAL",1)
~ THEN BEGIN 23
  SAY @14038 /* ~You've returned. Have you changed your mind about helping the Flaming Fist once more?~ [R#ELJ13] */ 
  IF ~~ THEN REPLY @14035 /* ~I am not interested being affiliated with the Flaming Fist more than this.~ */ GOTO 22
  IF ~~ THEN REPLY @14039 /* ~Yes I have. What do you need of me?~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",2)
~ GOTO 24
  IF ~~ THEN REPLY @14050 /* ~I have a few questions, if I may.~ */ GOTO 29
END

IF ~~ THEN BEGIN 24
  SAY @14040 /* ~As you no doubt already know, the Flaming Fist set up a camp north of Cragmyr to keep an eye on the increasing ogre threat over Cragmyr. However, now they have turned their attention to us and at the moment, we have no reinforcements to send. There already has been an attack with some casualties.~ [R#ELJ08] */ 
  IF ~~ THEN GOTO 25
END

IF ~~ THEN BEGIN 25
  SAY @14041 /* ~They are well-armed and well-organized - their attack is proof of this. They are led by an ogre magi called Kohark. There used to be three of them fighting amongst each other, but som... something happened to the two of them. I do not know what.~ [R#ELJ25] */ 
  IF ~~ THEN GOTO 26
END

IF ~~ THEN BEGIN 26
  SAY @14042 /* ~Now all the hobgoblins, ogres and ogrillons are led by only one ogre magi, which makes them a huge threat to Cragmyr Keep. If something is not done now, the Flaming Fist camp will be overrun.~ */ 
  IF ~~ THEN GOTO 27
END

IF ~~ THEN BEGIN 27
  SAY @14043 /* ~I need you to rendezvous with them and assist them in any way you can. The camp must not be lost. It is imperative that we hold that position.~ [R#ELJ27] */ 
  IF ~~ THEN GOTO 28
END

IF ~~ THEN BEGIN 28
  SAY @14044 /* ~I will mark the location on your map. You also better take this letter with you. The Good luck. And make haste, time is of the essence.~ [R#ELJ28] */
  IF ~~ THEN REPLY @14045 /* ~Very well, but I do have some questions before I go.~ */ DO ~RevealAreaOnMap("RANTA8")
AddJournalEntry(@100119,QUEST)
EraseJournalEntry(@100118)
GiveItemCreate("R#LETTE1",[PC],1,1,0)
~ GOTO 29 
  IF ~~ THEN REPLY @14046 /* ~Very well. I'll do my best.~ */ DO ~RevealAreaOnMap("RANTA8")
AddJournalEntry(@100119,QUEST)
EraseJournalEntry(@100118)
GiveItemCreate("R#LETTE1",[PC],1,1,0)
~ EXIT 
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 29
  SAY @14048 /* ~Very well, but time is short.~ [R#ELJ29] */
  IF ~~ THEN REPLY @14051 /* ~So, what is that you want with the Cragmyr Keep? Why is the Flaming Fist here?~ */ GOTO 31
  IF ~~ THEN REPLY @14052 /* ~I heard you had a problem with deserters? Maybe I can help?~ */ GOTO 33
  IF ~Global("TEW_SMUGGLERS","GLOBAL",0)~ THEN REPLY @14059 /* ~I heard you there are troublesome smugglers somewhere near Cragmyr Keep and you want them gone. Maybe I could help you?~ */ GOTO 34
  IF ~~ THEN REPLY @14058 /* ~Nevermind. I changed my mind. Bye.~ */ EXIT
END

IF ~~ THEN BEGIN 30
  SAY @14049 /* ~Of course. What is on your mind?~ [R#ELJ30] */ 
  IF ~~ THEN REPLY @14051 /* ~So, what is that you want with the Cragmyr Keep? Why is the Flaming Fist here?~ */ GOTO 31
  IF ~~ THEN REPLY @14052 /* ~I heard you had a problem with deserters? May I help you catch them?~ */ GOTO 33
  IF ~Global("TEW_SMUGGLERS","GLOBAL",0)~ THEN REPLY @14059 /* ~I heard you there are troublesome smugglers somewhere near Cragmyr Keep and you want them gone. Maybe I could help you?~ */ GOTO 34
  IF ~~ THEN REPLY @14058 /* ~Nevermind. I changed my mind. Bye.~ */ EXIT
END

IF ~~ THEN BEGIN 31
  SAY @14053 /* ~We want to keep the area safe, is it bandits or another nation such as Amn, we will do anything to defend it.~ */ 
  IF ~~ THEN GOTO 32
END

IF ~~ THEN BEGIN 32
  SAY @14054 /* ~The Flaming Fist wants the Cragmyr Keep as its ally to defend Beregost. The area is otherwise very vulnerable to an attack. Amn only wants it to use the Helmed Horros to attack us, nothing more. They want war.~ */ 
  IF ~~ THEN REPLY @14055 /* ~Good to know. Thanks for the answer. Bye. */ EXIT
  IF ~~ THEN REPLY @14056 /* ~That is interesting. May ask something else?~ */ GOTO 30
END

IF ~~ THEN BEGIN 33
  SAY @14057 /* ~Yes we do have an occasional deserter in our regiment, but nothing we can't handle by ourselves. For now, we do manage.~ */ 
  IF ~~ THEN REPLY @14055 /* ~Good to know. Thanks for the answer. Bye. */ EXIT
  IF ~~ THEN REPLY @14056 /* ~That is interesting. May ask something else?~ */ GOTO 30
END

IF ~~ THEN BEGIN 34
  SAY @14060 /* ~Yes we do. I am quite certain that I even know where they are holed up. The old smuggler tunnels west of Cragmyr Keep.~ */ 
  IF ~~ THEN GOTO 35
END

IF ~~ THEN BEGIN 35
  SAY @14061 /* ~I ordered those caves sealed. But it seems they have managed to reopen them. And what I have heard, is that their fortifying the tunnels as we speak.~ [R#ELJ35] */ 
  IF ~~ THEN GOTO 36
END

IF ~~ THEN BEGIN 36
  SAY @14062 /* ~What concerns me is that sapping takes time, even if they were able to break into the old smuggler tunnels.~ [R#ELJ36] */ 
  IF ~GlobalLT("Kuldak_quest1","GLOBAL",4)~ THEN GOTO 37
  IF ~GlobalGT("Kuldak_quest1","GLOBAL",3)~ THEN GOTO 41
END

IF ~~ THEN BEGIN 37
  SAY @14063 /* ~As you no doubt already know, Lord Kuldak is reluctant to help us and we ourselves don't have the men power to catch them. He is most likely getting resources from them. The caravans are avoiding Cragmyr, so Lord Kuldak must get resources for his people some other way. He won't admit anything of course.~ [R#ELJ37] */ 
  IF ~~ THEN REPLY @14064 /* ~Why are the caravans avoiding Cragmyr?~ */ GOTO 38
END

IF ~~ THEN BEGIN 38
  SAY @14065 /* ~I do not know. However, the tunnels were, and propably are, used as a storage facility away from the long hand of the law. Most likely now they are piling up all kind of resources that might be scarce during a war time. They can then sell them with for a huge profit.~ */ 
  IF ~~ THEN GOTO 39
END

IF ~~ THEN BEGIN 39
  SAY @14066 /* ~That kind of effort takes planning. So I doubt a small band of independent smugglers could or would be doing this alone. I suspect Alatos and the Shadow Thieves both being involved somehow. But I cannot prove anything. Yet.~ [R#ELJ39] */ 
  IF ~~ THEN GOTO 40
END

IF ~~ THEN BEGIN 40
  SAY @14067 /* ~I will mark the location on your map. Your job is to get rid of them. If they surrender, good. But if not, then you know what must be done.~ [R#ELJ28] */ 
  IF ~~ THEN REPLY @14068 /* ~Very well. I'll see what I can do.~ */ DO ~SetGlobal("TEW_SMUGGLERS","GLOBAL",1)
AddJournalEntry(@100300,QUEST)
RevealAreaOnMap("RANTA6")
~ EXIT
END

IF ~~ THEN BEGIN 41
  SAY @14070 /* ~As you no doubt already know, Lord Kuldak is reluctant to help us and we ourselves don't have the men power to catch them. He is most likely getting resources from them. The caravans are still avoiding Cragmyr, so Lord Kuldak must get resources for his people some other way. He won't admit anything of course.~ [R#ELJ37] */ 
  IF ~~ THEN REPLY @14071 /* ~What do the smugglers need the tunnels for?~ */ GOTO 42
END

IF ~~ THEN BEGIN 42
  SAY @14072 /* ~The tunnels were, and propably are, used as a storage facility away from the long hand of the law. Most likely now they are piling up all kind of resources that might be scarce during a war time. They can then sell them with for a huge profit.~ */ 
  IF ~~ THEN GOTO 39
END


//////////////////////////////////////////////////
// Lendali Firehair
//////////////////////////////////////////////////
BEGIN ~R#LENDAL~

IF WEIGHT #1
~GlobalLT("TEW_ogrequest","GLOBAL",2)
~ THEN BEGIN 0
  SAY @14500 /* ~Who are you? What are you doing here? This is a Flaming Fist military compound. You have no business here.~ */
  IF ~~ THEN REPLY @14501 /* ~My name is <CHARNAME>. Out of curiosity, what is the Flaming Fist doing in the wild?~ */ GOTO 1
END

IF ~~ THEN BEGIN 1
  SAY @14502 /* ~We have our orders and I am not about to share them with you. Now begone! Do not approach this compound any further or we will be forced to shoot you.~ */ 
  IF ~~ THEN REPLY @14503 /* ~Thanks for the warning.~ */ EXIT
END

IF WEIGHT #1
~Global("TEW_ogrequest","GLOBAL",2)
PartyHasItem("R#LETTE1")
NumTimesTalkedTo(0)
~ THEN BEGIN 2
  SAY @14500 /* ~Who are you? What are you doing here? This is a Flaming Fist military compound. You have no business here.~ */
  IF ~~ THEN REPLY @14504 /* ~My name is <CHARNAME>. I have orders from lieutenant Elijah Hjout to come to your aid.~ */ GOTO 4
END

IF WEIGHT #1
~Global("TEW_ogrequest","GLOBAL",2)
PartyHasItem("R#LETTE1")
NumTimesTalkedToGT(0)
~ THEN BEGIN 3
  SAY @14505 /* ~You again. What do you want now? I told you already, you are not allowed here. Move along!~ */
  IF ~~ THEN REPLY @14504 /* ~We have orders from lieutenant Elijah Hjout to come to your aid.~ */ GOTO 4
END

IF ~~ THEN BEGIN 4
  SAY @14506 /* ~Really? From Elijah Hjout? That's... strange. Well, come up and let me see those orders. Chop-chop! I don't have all day.~ */ 
  IF ~~ THEN DO ~SetGlobal("TEW_ogrequest","GLOBAL",3)
SetGlobal("RANTA3TR_DEACTIVE","GLOBAL",1)
~ EXIT
END

IF WEIGHT #1
~Global("TEW_ogrequest","GLOBAL",3)
PartyHasItem("R#LETTE1")
NumTimesTalkedToGT(0)
~ THEN BEGIN 5
  SAY @14507 /* ~Hmmm. Very strange indeed, that Elijah would send adventurers above all else here as reinforcements. Not that I am not pleased, but... it's just strange. can I see the letter?~ */
  IF ~~ THEN REPLY @14508 /* ~Sure. Here you go.~ */ DO ~TakePartyItem("R#LETTE1")
DestroyItem("R#LETTE1")
~ GOTO 6
END

IF ~~ THEN BEGIN 6
  SAY @14509 /* ~Very strange indeed. He works mostly as a diplomat or negotiator and this clearly oversteps his jurisdiction. I know he has close dear friend here, Horben, but still he should know better. Horben has clearly been feeding Elijah with information. How else would he know we are in a need of reinforcements? I should have a word with him.~ */ 
  IF ~~ THEN REPLY @14510 /* ~Horben is close friend of Elijah's? He never mentioned that.~ */ GOTO 7
END

IF ~~ THEN BEGIN 7
  SAY @14511 /* ~Well, yes. They joined the Flaming Fist together not so long ago. As a mage, Horben became a battle wizard. Elijah, as an ambitious and charismatic man, was very quick to obtain the rank of a lieutenant, after which he was assigned as a negotiator and diplomat. He has been quite successful in that field too, I have to admit.~ */ 
  IF ~~ THEN GOTO 8
END

IF ~~ THEN BEGIN 8
  SAY @14512 /* ~I have to report all this to my superiors when I get the chance, but for now, I'll accept all help I can get.~ */ 
  IF ~~ THEN REPLY @14513 /* ~So, how is your situation here? I saw some graves outside the camp.~ */ GOTO 9
END

IF ~~ THEN BEGIN 9
  SAY @14514 /* ~Yes. We were attacked by a band of ogres and hobgoblins, led by a big one they called Bombur. I think he is kind of a renegade and doesn't take commands from the remaining ogre magi, Kohark. We lost three men in that attack and our horse. So we cannot move the camp as easily now.~ */ 
  IF ~~ THEN GOTO 10
END

IF ~~ THEN BEGIN 10
  SAY @14515 /* ~The ogre however isn't our biggest problem. We have had our time to fortify ourselves here so we should be able to hold our position. Of course, if you want to use your time chasing after that big one, be my quest. I will even give you a reward for that one.~ */ 
  IF ~~ THEN REPLY @14516 /* ~What about the remaining ogre magi, Kohark? Isn't his lair close by?~ */ GOTO 11
END

IF ~~ THEN BEGIN 11
  SAY @14517 /* ~Yes, it is. But for now he and his ogres has mostly been avoiding us and we him. I do not know why, but that's what he has done and I do not complain. We are here only to observe. In any case, I wouldn't even have the resources or the men power to take the fight to him. We are a scouting unit after all.~ */ 
  IF ~~ THEN REPLY @14526 GOTO 17
END

IF ~~ THEN BEGIN 12
  SAY @14518 /* ~The biggest issue, which I cannot do anything about now, has been Kohark's assaults against Cragmyr's people. Lord Kuldak's both sons died in an ambush orchestrated by Kohark. By the looks of it, it seemed that Kohark wanted them dead. The ogre magis have always had an grudge against Maurancz family, but none of the ogre magis would have dared to do something like that when they were fighting amongst each other.~ */ 
  IF ~~ THEN REPLY @14519 /* ~Why don't you help Cragmyr with this?~ */ GOTO 13
END

IF ~~ THEN BEGIN 13
  SAY @14520 /* ~All Flaming Fist mercenaries have orders not to help Cragmyr, if Lord Kuldak doesn't ally himself with us. And even if we did take the fight to him, we have no proof that the two other ogre magis are actually dead and gone. At least this one is the youngest and the least powerful of the three. I believe the other two were called Kahrk and Dohrark.~ */ 
  IF ~~ THEN GOTO 14
END

IF ~~ THEN BEGIN 14
  SAY @14521 /* ~However, our main problem at the moment I need your help with, is the deserters whom must be caught. One, called Alarik, was already hanged at Cragmyr Keep by Lord Kuldak. I bet Elijah had his hands in that business. He or Lord Kuldak neither had jurisdiction for such an action.~ */ 
  IF ~~ THEN REPLY @14522 /* ~Why not? Aren't deserters always hanged?~ */ GOTO 15
END

IF ~~ THEN BEGIN 15
  SAY @14523 /* ~Usually yes, but after a proper offical hearing and by the ruling of our Commanders. Not by someone who isn't even part of the Flaming Fist or a lieutenant.~ */ 
  IF ~~ THEN GOTO 16
END

IF ~~ THEN BEGIN 16
  SAY @14524 /* ~But back to the matter at hand. My unit is lost too many men already. And the deserters aren't helping the matter. I need them brought back to justice. Horben actually has all the specifics, so I guess you should talk to him.~ */ 
  IF ~~ THEN REPLY @14525 /* ~Very well. I shall speak to him and find out the specifics.~ */ DO ~AddJournalEntry(@100120,QUEST)
EraseJournalEntry(@100119)
SetGlobal("TEW_ogrequest","GLOBAL",4)
~ EXIT
END

IF ~~ THEN BEGIN 17
  SAY @14527 
  IF ~~ THEN REPLY @14528 GOTO 12
END

//////////////////////////////////////////////////
// Horben
//////////////////////////////////////////////////
BEGIN ~R#HORBEN~

IF WEIGHT #1
~GlobalLT("TEW_ogrequest","GLOBAL",4)
~ THEN BEGIN 0
  SAY @14700 /* ~Talk you Officer Firehair if you want something. She is in command here.~ */
  IF ~~ THEN EXIT
END

IF WEIGHT #1
~Global("TEW_ogrequest","GLOBAL",4)
~ THEN BEGIN 1
  SAY @14701 /* ~What? What do you want? I am busy can't you see.~ */
  IF ~~ THEN REPLY @14702 /* ~Officer Firehair told me to talk to you about the deserters. She said you know the specifics.~ */ GOTO 2
END

IF ~~ THEN BEGIN 2
  SAY @14703 /* ~Aa yes, I do know the specifics of this matter. The specifics are somewhat complicated. There have been a total of three deserters. One was from this scouting unit, and the other two worked independently and were not permanently part of any unit. Although they were assigned to Officer Firehair's unit for the time being due to the casulties.~ */ 
  IF ~~ THEN GOTO 3
END

IF ~~ THEN BEGIN 3
  SAY @14704 /* ~The one from this unit was called Alarik... ummm... can't seem to remember the last name. Well nonetheless, he was already caught at the Cragmyr Keep and was hanged by Lord Kuldak at the request of Officer Hjout.~ */ 
  IF ~~ THEN REPLY @14705 /* ~I heard you are good friends with Officer Hjout. Is that correct?~ */ GOTO 4
END

IF ~~ THEN BEGIN 4
  SAY @14706 /* ~Yes we have been friends longer than I care to admit. But let's not get off the topic, since we are all busy here. The two remaining deserters, Quinn and Luci Galan, were a married couple and one of the Flaming Fist's best scouts, or assassins if want to put it that way. Nobody knows for sure why they decided to desert the Flaming Fist. I myself think they hope to get a good price for the magical documents they stole from the Cowled Wizards and plan to retire somewhere out of reach.~ */ 
  IF ~~ THEN REPLY @14707 /* ~Magical documents? What was in these documents?~ */ GOTO 5
END

IF ~~ THEN BEGIN 5
  SAY @14708 /* ~I do not know, but I think something important since they actually took the time to steal them. They were only supposed to observe the actions of Cowled Wizards in Nashkel. I didn't really get a chance to take a look at them before they had already taken off, but Luci at least has rudimentary knowledge of the Art.~ */ 
  IF ~~ THEN REPLY @14709 /* ~Who saw them actually taking off?~ */ GOTO 6
END

IF ~~ THEN BEGIN 6
  SAY @14709 /* ~I did. I tried to stop and catch them in the act, but I wasn't prepared to fight two very accomplished and skilled assassins. I warn you, if you come across them, don't hesitate or stop to talk to them. The other one will talk to you while the other one will propably flank and backstab you to death before you can "Turnips".~ */ 
  IF ~~ THEN REPLY @14710 /* ~You have any idea where should I start looking for them?~ */ GOTO 7
END

IF ~~ THEN BEGIN 7
  SAY @14711 /* ~Well, I wish Alarik was alive. He knew those two better than anyone. But he got hanged at Cragmyr Keep so there is no talking to him no more. I guess this is a bit of a dead end. I didn't know them that well and neither did anyone else here in the camp. They were, as I said before, independent scouts and assassins so I guess only few knew them at all. You can bring them back dead or alive. I recommend dead since they are too dangerous to be kept alive. I wish you good luck in the search, although I doubt you can catch them anymore. Farewell.~ */ 
  IF ~~ THEN REPLY @14712 /* ~Well, thanks. Farewell.~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",5)
AddJournalEntry(@100121,QUEST)
EraseJournalEntry(@100120)
~ GOTO 7
END

IF ~GlobalGT("TEW_ogrequest","GLOBAL",4)
~ THEN BEGIN 8
  SAY @14713 /* ~I am sorry I couldn't help you more than that. I hope you catch those bastards.~ */ 
  IF ~~ THEN EXIT
END


//////////////////////////////////////////////////
// ALarik
//////////////////////////////////////////////////
BEGIN ~R#GHOST2~

IF WEIGHT #1
~Global("TEW_ogrequest","GLOBAL",5)
~ THEN BEGIN 0
  SAY @14725 /* ~Hmph. Who are you? I have already twice been called upon and I don't like it.~ */
  IF ~~ THEN REPLY @14726 /* ~You already been called upon? Twice? By whom?~ */ GOTO 1
END

IF ~~ THEN BEGIN 1
  SAY @14727 /* ~Well how the hell should I know. He was a Flaming Fist Battle Wizard and kept asking me about Quinn and where he might be hiding.~ */ 
  IF ~~ THEN REPLY @14728 /* ~Only Quinn? Not Luci?~ */ GOTO 2
END

IF ~~ THEN BEGIN 2
  SAY @14729 /* ~Yeah, only Quinn. It seemed like he knew already where Luci was. I guess they at least got seperated, if nothing worse has happened to Luci.~ */ 
  IF ~~ THEN REPLY @14730 /* ~Why did the Battle Wizard come back for a second time?~ */ GOTO 3
END

IF ~~ THEN BEGIN 3
  SAY @14731 /* ~He came back since he didn't find Quinn in the meeting place Quinn and Luci had set up if they ever got seperated. I told him, once again, that it was the only place I knew about. After that he left.~ */ 
  IF ~~ THEN REPLY @14732 /* ~So where is this secret meeting place?~ */ GOTO 4
END

IF ~~ THEN BEGIN 4
  SAY @14733 /* ~Just south of Beregost there is a small cave. That's the place.~ */ 
  IF ~~ THEN REPLY @14734 /* ~They, or he, propably won't be there. Like with the Battle Wizard. Is there something else I should know? Like a signal I have to make so he or she knows I am the right person?~ */ GOTO 5
END

IF ~~ THEN BEGIN 5
  SAY @14735 /* ~Ooouuhh! You are smart! Much smarter than the Battle Wizard. He didn't realize to ask such a thing. And if you don't ask, I don't have and won't tell anything.~ */ 
  IF ~~ THEN GOTO 6
END

IF ~~ THEN BEGIN 6
  SAY @14736 /* ~Yeah there is a signal you have to make to make Quinn or Luci to realize that it's you, and with you I mean the other half of the married couple, and not someone else. You need to drop a dagger and either a silver nccklace or a silver ring into the barrel next to Jovial Juggler. Give it a day or two and he, or she, should show up at the cave. Is that all? Can I go?~ */ 
  IF ~~ THEN REPLY @14737 /* ~Yeah, you can go.~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",6)
SetGlobal("R#GHOST2_SUMA","GLOBAL",1)
AddJournalEntry(@100122,QUEST)
EraseJournalEntry(@100121)
~ EXIT
END

//////////////////////////////////////////////////
// Quinn Galan
//////////////////////////////////////////////////
BEGIN ~R#QUINN~

IF WEIGHT #1
~NumTimesTalkedTo(0)
!AreaCheck("RANTA3")
~ THEN BEGIN 0
  SAY @14800 /* ~Luci... How did y... What? You are not Luci. Who are you? Was it you who placed the signal?~ */
  IF ~~ THEN REPLY @14801 /* ~Fool! You fell into my trap and now it is time to die!~ */ DO ~Enemy()
~ EXIT
  IF ~~ THEN REPLY @14802 /* ~Yes, I placed the signal. I came here to capture you for desertion from the Flaming Fist.~ */ GOTO 1
END

IF ~~ THEN BEGIN 1
  SAY @14803 /* ~Aaaa. That's what Horben is acusing me of then. I knew he would come up with some kind of lie to make me a target for all Flaming Fist mercenaries. Although, I never thought they would send an outsider.~ */ 
  IF ~~ THEN REPLY @14804 /* ~What do you mean come up with a lie? You didn't desert the Flaming Fist?~ */ GOTO 2
  IF ~~ THEN REPLY @14805 /* ~Enough chit chat! Time to die, you deserter!~ */ DO ~Enemy()
~ EXIT
END

IF ~~ THEN BEGIN 2
  SAY @14806 /* ~No, I am not. Me and Luci had been with Officer Firehair's unit for a week or so, after which Luci told me that she had found out something very serious and discriminating about Horben and Officer Hjout. However, she didn't want to tell me anything specific before she was sure.~ */ 
  IF ~~ THEN GOTO 3
END

IF ~~ THEN BEGIN 3
  SAY @14807 /* ~Next night she guided me to a quiet place outside the camp and started telling me about the schemes of Horben and Hjout. I couldn't really keep on with her. She was so excited and abhored. Only two things I remember is that she had proof and they were trapping souls into gems. I do not know who's. However, before she could finish, she was shot by some kind of spell. I regocnized the spell. It was Trap the Soul spell. It traps person's soul into a gem. However, I did not see who shot the spell, but I suspect Horben.~ */ 
  IF ~~ THEN GOTO 4
END

IF ~~ THEN BEGIN 4
  SAY @14808 /* ~I knew if I stayed I would soon end up the same way. So, I ran for it and planned to go back later on to look for the gem she had been trapped in. However, when I went back a few nights later, I couldn't find the stone anywhere. He only had normal gems. So, there are two options left: either Horben took the gem some place else, or something more sinister has happened. I think it must be the second one, since Horben didn't leave the camp at any point. I was watching.~ */ 
  IF ~~ THEN GOTO 6
END

IF ~~ THEN BEGIN 6
  SAY @14809 /* ~Either way there is no possible way to find Luci or the evidence she had without huge magical resources in divination and such. I myself really can't go asking people since I am wanted for desertion now, so I must just wait for them to forget me. After that, I can begin my search.~ */ 
  IF ~~ THEN REPLY @14810 /* ~Who do you mean when you say huge magical resources?~ */ GOTO 7
END

IF ~~ THEN BEGIN 7
  SAY @14811 /* ~Well someone like the Harpers, or maybe Candlekeep. Or the Cowled Wizards of Amn. Anyone with wizards to search for a missing person.~ */ 
  IF ~~ THEN REPLY @14812 /* ~Why not the Flaming Fist?~ */ GOTO 8
END

IF ~~ THEN BEGIN 8
  SAY @14813 /* ~Hah! We, or I guess it's "they" now, may be a powerful mercenary organization, but they have no real magical resources. Yes, Moruene is notably resourceful, but she is just a single wizard and a busy one at that.~ */ 
  IF ~~ THEN REPLY @14814 /* ~What if I searched for Luci? I need the evidence she might have.~ */ GOTO 9
  IF ~~ THEN REPLY @14815 /* ~Even if what you say is true, you are still a deserter. So, I guess it's time for you to die!~ */ DO ~Enemy()
SetGlobal("TEW_ogrequest","GLOBAL",8)
AddJournalEntry(@100124,QUEST)
EraseJournalEntry(@100122)
~ EXIT
END

IF ~~ THEN BEGIN 9
  SAY @14816 /* ~Well, you can if you want. But I can't help you for now. But if I were you, I would start looking for someone who can locate my wife. If you need me, I'll be staying on a lookout for Horben near Officer Firehair's. I need to know what has happened to my wife.~ */ 
  IF ~~ THEN REPLY @14817 /* ~Alright. I'll try to figure out who can help me, or us. You keep your eyes on Horben.~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",8)
SetGlobal("QUINN_ALIVE","GLOBAL",1)
AddJournalEntry(@100123,QUEST)
EraseJournalEntry(@100122)
EscapeArea()
~ EXIT
  IF ~~ THEN REPLY @14818 /* ~It is a good plan, but I think I still have to take you back. You are, nonetheless, a deserter.~ */ DO ~Enemy()
SetGlobal("TEW_ogrequest","GLOBAL",8)
AddJournalEntry(@100124,QUEST)
EraseJournalEntry(@100122)
~ EXIT
END

IF WEIGHT #1
~AreaCheck("RANTA3")
~ THEN BEGIN 10
  SAY @14819 /* ~Ouh, it is you again. Can I help you with something?~ */
  IF ~~ THEN REPLY @14820 /* ~With nothing for now. Bye.~ */ EXIT
  IF ~Global("ILTAR_QUEST2","GLOBAL",2)~ THEN REPLY @14821 /* ~I heard you have some magical documents. I need them in order to find Luci.~ */ GOTO 11
END

IF ~~ THEN BEGIN 11
  SAY @14822 /* ~You need the documents to find Luci? You mean you are going to hand them over to Iltar?~ */ 
  IF ~~ THEN REPLY @14823 /* ~Yes, that's the idea.~ */ GOTO 12
END

IF ~~ THEN BEGIN 12
  SAY @14824 /* ~So he said he was going to help? I doubt that. No, I am not giving up my only bargaining chip so that you can give the documents to him and he can betray you.~ */ 
  IF ~CheckStatGT([PC],20,CHR)~ THEN REPLY @14825 /* ~But think about it. This is our only chance to find Luci and he has promised to help. I trust him.~ */ GOTO 14
  IF ~CheckStatLT([PC],21,CHR)~ THEN REPLY @14825 /* ~But think about it. This is our only chance to find Luci and he has promised to help. I trust him.~ */ GOTO 13
  IF ~~ THEN REPLY @14826 /* ~Well, as you are not going to give the documents to me, I'll have to take them.~ */ DO ~Enemy()
~ EXIT
END

IF ~~ THEN BEGIN 13
  SAY @14827 /* ~Trust him? You are in the same boat as he is, aren't you? You bastards!~ */ 
  IF ~~ THEN REPLY @14828 /* ~Wait a min...~ */ DO ~Enemy()
~ EXIT
END

IF ~~ THEN BEGIN 14
  SAY @14829 /* ~You do sound sincere. Very well. I shall give you the documents. I am trusting you now. I hope you know what you are doing.~ */ 
  IF ~~ THEN REPLY @14830 /* ~So do I.~ */ GOTO 15
END

IF ~~ THEN BEGIN 15
  SAY @14831 /* ~Here are the documents. By the way, as I cannot go back to the Flaming Fist headquarters I might as well tell you about this. There is a chest in the downstairs of Flaming Fist headquarters in Baldur's Gate. You should go and open it up. I have the key right here. Maybe that stuff will help you in the future. Farewell.~ */ 
  IF ~~ THEN REPLY @14832 /* ~Alright. Thank you and farewell.~ */ DO ~GiveItem("R#SCHEMA",[PC])
GiveItemCreate("R#QUIN4",[PC],1,1,0)
EscapeArea()
~ EXIT
END

//////////////////////////////////////////////////
// Iltar (Tranth)
//////////////////////////////////////////////////
BEGIN ~R#ILTAR~

IF WEIGHT #1
~ NumTimesTalkedTo(0)
~ THEN BEGIN 0 // from:
  SAY @15000 /* ~Interesting. You are the one who has been helping Lord Kuldak with the keeps reconstruction and the reactivation of the Helmed Horrors. Yes?~ [R#ILT00] */
  IF ~~ THEN REPLY @15001 /* ~Yes we are. How do you know that?~ */ GOTO 1
END

IF ~~ THEN BEGIN 1 // from:
  SAY @15002 /* ~I... just... know.~ [R#ILT01] */
  IF ~~ THEN GOTO 2
END

IF ~~ THEN BEGIN 2 // from:
  SAY @15003 /* ~Please, accept my hospitality. But first let me introduce myself, I am Iltar of the Cowled Wizards of Amn here on a political mission. And you are <CHARNAME>, yes?.~ [R#ILT02] */
  IF ~~ THEN REPLY @15004 /* ~Yes I am. How did yo..~ */ GOTO 3
  IF ~~ THEN REPLY @15005 /* ~None of your business.~ */ GOTO 4
END

IF ~~ THEN BEGIN 3 // from:
  SAY @15006 /* ~That was a rhetorical question. But...~ [R#ILT03] */
  IF ~~ THEN GOTO 5
END

IF ~~ THEN BEGIN 4 // from:
  SAY @15007 /* ~I agree. It is not my concern because I am already aware of the matter's truth. However...~ [R#ILT04] */
  IF ~~ THEN GOTO 5
END

IF ~~ THEN BEGIN 5 // from:
  SAY @15008 /* ~Now that introductions are all out of the way, let me tell you of our plight. As a friend of Lord Kuldak you might also want to hear our side of the story. The innocent side.~ [R#ILT05] */
  IF ~~ THEN GOTO 6
END

IF ~~ THEN BEGIN 6 // from:
  SAY @15009 /* ~As you may know, the Flaming Fist intends to use Cragmyr Keep to attack Nashkel and Amn. Don't ask how I know, I just do.~ */
  IF ~~ THEN GOTO 7
END

IF ~~ THEN BEGIN 7 // from:
  SAY @15010 /* ~However, as you also know, Amn is totally and completely innocent of anything Baldur's Gate is blaming us for. The Flaming Fist is only trying get the Helmed Horrors and the keep on their side to use it to attack Nashkel.~ */
  IF ~~ THEN GOTO 8
END

IF ~~ THEN BEGIN 8 // from:
  SAY @15011 /* ~We on the other hand only wish that Cragmyr would be there to aid and defend our helpless town of Nashkel from the vile and cruel fate these northern... barbarians wish for it. In this particular case, Amn has nothing to hide.~ */
  IF ~~ THEN REPLY @15012 /* ~Can you *promise* that?~ */ GOTO 9
END

IF ~~ THEN BEGIN 9 // from:
  SAY @15013 /* ~Ha, ha, ha! You must have power over the words. Do not let the words take power over you. A promise is not truth.~ [R#ILT09] */
  IF ~~ THEN GOTO 10
END

IF ~~ THEN BEGIN 10 // from:
  SAY @15014 /* ~I do promise that Amn wishes no ill will to Cragmyr or its people. I am only trying to look after my nation. Let Lord Kuldak know this next time you speak to him.~ */
  IF ~~ THEN EXIT
END

IF WEIGHT #1
~ !NumTimesTalkedTo(0)
~ THEN BEGIN 11 // from:
  SAY @15015 /* ~Greetings again. With what can I help you?~ [R#ILT11] */
  IF ~~ THEN REPLY @15016 /* ~With nothing for now. Bye.~ */ EXIT
  IF ~GlobalGT("TEW_caravanquest","GLOBAL",7)
Global("ILTAR_GLOAT1","GLOBAL",0)~ THEN REPLY @15017 /* ~There is something interesting I came across in Baldur's Gate. Your sister was doing some very sinister things there.~ */ GOTO 12
  IF ~Global("TEW_ogrequest","GLOBAL",8)
Global("TALESS_DEAD","GLOBAL",1)~ THEN REPLY @15032 /* ~You are part of the Cowled Wizards of Amn, correct? I have something I could need from you and your organization. A missing person of a sort.~ */ GOTO 21
  IF ~Global("TEW_ogrequest","GLOBAL",8)
Global("TALESS_DEAD","GLOBAL",0)~ THEN REPLY @15032 /* ~You are part of the Cowled Wizards of Amn, correct? I have something I could need from you and your organization. A missing person of a sort.~ */ GOTO 28
  IF ~Global("ILTAR_QUEST2","GLOBAL",2)
Global("ILTAR_QUEST1","GLOBAL",2)
PartyHasItem("R#SCHEMA")
Global("TEW_ogrequest","GLOBAL",9)~ THEN REPLY @15046 /* ~I have these magical documents you asked for.~ */ DO ~SetGlobal("ILTAR_QUEST2","GLOBAL",3)
TakePartyItem("R#SCHEMA")
~ GOTO 30
  IF ~Global("ILTAR_QUEST2","GLOBAL",2)
OR(2)
Global("ILTAR_QUEST1","GLOBAL",0)
Global("ILTAR_QUEST1","GLOBAL",3)
PartyHasItem("R#SCHEMA")
Global("TEW_ogrequest","GLOBAL",9)~ THEN REPLY @15046 /* ~I have these magical documents you asked for.~ */ DO ~SetGlobal("ILTAR_QUEST2","GLOBAL",3)
TakePartyItem("R#SCHEMA")
~ GOTO 34
  IF ~GlobalGT("ILTAR_QUEST1","GLOBAL",1)
GlobalLT("ILTAR_QUEST1","GLOBAL",4)
Global("ILTAR_QUEST2","GLOBAL",2)
PartyHasItem("R#TALES1")
Global("TEW_ogrequest","GLOBAL",9)~ THEN REPLY @15047 /* ~I have your sisters body here.~ */ DO ~SetGlobal("ILTAR_QUEST1","GLOBAL",4)
TakePartyItem("R#TALES1")
~ GOTO 30
  IF ~GlobalGT("ILTAR_QUEST1","GLOBAL",1)
GlobalLT("ILTAR_QUEST1","GLOBAL",4)
Global("ILTAR_QUEST2","GLOBAL",3)
PartyHasItem("R#TALES1")
Global("TEW_ogrequest","GLOBAL",9)~ THEN REPLY @15047 /* ~I have your sisters body here.~ */ DO ~SetGlobal("ILTAR_QUEST1","GLOBAL",4)
TakePartyItem("R#TALES1")
~ GOTO 34
  IF ~Global("ILTAR_QUEST2","GLOBAL",1)
Global("ILTAR_QUEST1","GLOBAL",0)
Global("TEW_ogrequest","GLOBAL",9)~ THEN REPLY @15045 /* ~I changed my mind. I will do as you asked in exchange for you help.~ */ DO ~SetGlobal("ILTAR_QUEST2","GLOBAL",2)
AddJournalEntry(@100126,QUEST)
EraseJournalEntry(@100128)
~ GOTO 29
  IF ~Global("ILTAR_QUEST2","GLOBAL",1)
Global("ILTAR_QUEST1","GLOBAL",1)
Global("TEW_ogrequest","GLOBAL",9)~ THEN REPLY @15045 /* ~I changed my mind. I will do as you asked in exchange for you help.~ */ DO ~SetGlobal("ILTAR_QUEST2","GLOBAL",2)
SetGlobal("ILTAR_QUEST1","GLOBAL",2)
AddJournalEntry(@100127,QUEST)
EraseJournalEntry(@100128)
~ GOTO 29
  IF ~Global("TEW_ogrequest","GLOBAL",11)~ THEN REPLY @15058 /* ~So you have returned. Did you find out where Luci is?~ */ GOTO 35
END

IF ~~ THEN BEGIN 12
  SAY @15018 /* ~Thank you for sharing that fascinating revelation. However, as you have come to me and told me what you know, my guess is you after something else than the "truth". Yes?~ */
  IF ~PartyHasItem("R#TALESB")
Global("TALESS_DEAD","GLOBAL",0)~ THEN REPLY @15019 /* ~I do possess some evidence that would discredit you and your sister. A offer good enough might make me lose it, so to say.~ */GOTO 13
  IF ~PartyHasItem("R#TALESB")
Global("TALESS_DEAD","GLOBAL",0)~ THEN REPLY @15020 /* ~I do possess some evidence that would discredit you and your sister. But there is nothing you can offer me to give it up.~ */GOTO 16
  IF ~PartyHasItem("R#TALESB")
Global("TALESS_DEAD","GLOBAL",1)~ THEN REPLY @15019 /* ~I do possess some evidence that would discredit you and your sister. A offer good enough might make me lose it, so to say.~ */GOTO 17
  IF ~PartyHasItem("R#TALESB")
Global("TALESS_DEAD","GLOBAL",1)~ THEN REPLY @15020 /* ~I do possess some evidence that would discredit you and your sister. But there is nothing you can offer me to give it up.~ */GOTO 17
  IF ~!PartyHasItem("R#TALESB")
Global("TALESS_DEAD","GLOBAL",0)~ THEN REPLY @15021 /* ~I already gave the evidence away. This will put into a bad position regarding your stay here at Cragmyr.~ */GOTO 19
  IF ~!PartyHasItem("R#TALESB")
Global("TALESS_DEAD","GLOBAL",1)~ THEN REPLY @15021 /* ~I already gave the evidence away. This will put into a bad position regarding your stay here at Cragmyr.~ */GOTO 34
END

IF ~~ THEN BEGIN 13
  SAY @15022 /* ~Very well. I possess this powerful magical robe, a gift meant for my sister. I shall give it to you in exchange for the evidence you possess. Is this acceptable?~ */
  IF ~~ THEN REPLY @15023 /* ~That is acceptable. We have a deal.~ */ GOTO 14
  IF ~~ THEN REPLY @15024 /* ~No, I don't need a robe. Sorry.~ */ GOTO 15
END

IF ~~ THEN BEGIN 14
  SAY @15025 /* ~Excellent. Here you go. Nice doing business with you.~ [R#ILT13] */
  IF ~~ THEN DO ~SetGlobal("ILTAR_GLOAT1","GLOBAL",1)
AddJournalEntry(@100114,QUEST)
EraseJournalEntry(@100113)
~ EXIT
END

IF ~~ THEN BEGIN 15
  SAY @15026 /* ~That is unfortunate, but understandable. Well you must do what you think is right. Now, please, leave me be.~ [R#ILT15] */
  IF ~~ THEN DO ~SetGlobal("ILTAR_GLOAT1","GLOBAL",1)
~ EXIT
END

IF ~~ THEN BEGIN 16
  SAY @15027 /* ~That is unfortunate, but understandable. So, what are you waiting for? Me to attack you? Go. Do what you must and leave me be.~ [R#ILT15] */
  IF ~~ THEN DO ~SetGlobal("ILTAR_GLOAT1","GLOBAL",1)
~EXIT
END

IF ~~ THEN BEGIN 17
  SAY @15028 /* ~So you come here trying to blackmail me with your wild accusations in your search for your "the truth". After you killed my sister!? Yes, I know it must have been you. You zealous adventurers in search for glory and fame like it was a way to godhood!~ */
  IF ~~ THEN DO ~AddJournalEntry(@100115,QUEST)
EraseJournalEntry(@100113)
~ GOTO 18
END

IF ~~ THEN BEGIN 18
  SAY @15029 /* ~I destroyed an entire city of blind zealots just like you. I will not lower myself to your level of barbarism and I will not have my sister died in vain. Now, begone!~ [R#ILT18] */
  IF ~~ THEN DO ~SetGlobal("ILTAR_GLOAT1","GLOBAL",1)
~EXIT
END

IF ~~ THEN BEGIN 19
  SAY @15030 /* ~That is unfortunate, but understandable. So, what are you doing here then? Come to gloat? You have already done what you had to do. Now leave me be.~ [R#ILT15] */
  IF ~~ THEN DO ~SetGlobal("ILTAR_GLOAT1","GLOBAL",1)
~EXIT
END

IF ~~ THEN BEGIN 20
  SAY @15031 /* ~So you come here to gloat and say that my negotiations are doomed to fail? I do not care! You killed my sister! Yes, I know it must have been you. You zealous adventurers in search for glory and fame like it was a way to godhood!~ */
  IF ~~ THEN GOTO 18
END

IF ~~ THEN BEGIN 21
  SAY @15033 /* ~It is as I suspected. I have something you need, and you have something I need. Actually I have somethings, in plural if you missed that, I need from you. As we both know, you killed my sister. But I cannot retrieve her body from Baldur's Gate due to the political climate in the air.~ [R#ILT21] */
  IF ~~ THEN GOTO 22
END

IF ~~ THEN BEGIN 22
  SAY @15034 /* ~I somehow suspect she has been thrown into a gutter or the sewers. You northerners give so little value or thought to your dead. You don't even have a graveyard in Baldur's Gate city.~ */
  IF ~~ THEN REPLY @15035 /* ~You do understand that those graveyards attract necromancers, undead and other monsters to them?~ */ GOTO 23
END

IF ~~ THEN BEGIN 23
  SAY @15036 /* ~True, true. But, back to the matter at hand. I want you to retrieve her body where ever it may lay. I am not about to leave her rotting in a gutter. Ironically, you as her murderer, might as well return her to me. I suspect you could start asking beggars where her body may lay. And then to the other "something" I need from you. Due to this frustrating political tension in the air, I cannot actually do this another task on my own either, without provoking Baldur's Gate and the Flaming Fist.~ [R#ILT23] */
  IF ~~ THEN GOTO 24
END

IF ~~ THEN BEGIN 24
  SAY @15037 /* ~A while ago, someone stole some magical documents from me and I want them back. It was those infamous half-elven, or maybe they were elven, Flaming Fist assassins. I believe they were called Quinn and Luci Galan.~ */
  IF ~~ THEN GOTO 25
END

IF ~~ THEN BEGIN 25
  SAY @15038 /* ~I do not know, if they were there to actually kill me and my colleague or just to observe, but they somehow managed to steal the documents. I thought their fate would be sealed if they approached us due to our magical traps and protections. But it seems not. The male even set off one of our magical traps, which would normally mean death.~ */
  IF ~~ THEN GOTO 26
END

IF ~~ THEN BEGIN 26
  SAY @15039 /* ~How he escaped from his fate, I do not know. It seems I underestimated them. Ever since I have tried to track them, but for some reason, they keep eluding me. If I actually wanted to catch them I would have to return to Athkatla, where I have my divination tools. For some reason however, I get the feeling you know where my documents are. I want those documents back. I do not care if you kill them both, or how you obtain them back, but if you wish my help locating this missing person, you get those documents back for me.~ [R#ILT26] */
  IF ~Global("TALESS_DEAD","GLOBAL",0)
~ THEN REPLY @15040 /* ~Very well. I'll do what you ask in exchange for your help.~ */ DO ~SetGlobal("ILTAR_QUEST2","GLOBAL",2)
SetGlobal("ILTAR_QUEST1","GLOBAL",0)
AddJournalEntry(@100126,QUEST)
EraseJournalEntry(@100123)
EraseJournalEntry(@100124)
EraseJournalEntry(@100125)
SetGlobal("TEW_ogrequest","GLOBAL",9)
~ EXIT
  IF ~Global("TALESS_DEAD","GLOBAL",1)
~ THEN REPLY @15040 /* ~Very well. I'll do what you ask in exchange for your help.~ */ DO ~SetGlobal("ILTAR_QUEST1","GLOBAL",2) 
SetGlobal("ILTAR_QUEST2","GLOBAL",2)
SetGlobal("TEW_ogrequest","GLOBAL",9)
AddJournalEntry(@100127,QUEST)
EraseJournalEntry(@100123)
EraseJournalEntry(@100124)
EraseJournalEntry(@100125)
~ EXIT
  IF ~Global("TALESS_DEAD","GLOBAL",0)~ THEN REPLY @15041 /* ~I will not be your errand boy. I will find help somewhere else.~ */ DO ~SetGlobal("ILTAR_QUEST2","GLOBAL",1)
SetGlobal("TEW_ogrequest","GLOBAL",9)
AddJournalEntry(@100128,QUEST)
SetGlobal("ILTAR_QUEST1","GLOBAL",0)
EraseJournalEntry(@100123)
EraseJournalEntry(@100124)
EraseJournalEntry(@100125)
~ GOTO 27
  IF ~Global("TALESS_DEAD","GLOBAL",1)~ THEN REPLY @15041 /* ~I will not be your errand boy. I will find help somewhere else.~ */ DO ~SetGlobal("ILTAR_QUEST2","GLOBAL",1)
SetGlobal("TEW_ogrequest","GLOBAL",9)
SetGlobal("ILTAR_QUEST1","GLOBAL",1)
AddJournalEntry(@100128,QUEST)
EraseJournalEntry(@100123)
EraseJournalEntry(@100124)
EraseJournalEntry(@100125)
~ GOTO 27
END

IF ~~ THEN BEGIN 27
  SAY @15042 /* ~Well, then, your journey is going to be truncated dramatically. As I already know, and maybe so do you, there are none other in the vicinity of your current location who had the resources or the willingness to help you in your current predicament. So, come back when you come to your senses.~ [R#ILT27] */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 28
  SAY @15043 /* ~It is as I suspected. I have something you need, and you have something I need. Due to this frustrating political tension in the air, I cannot actually do this on my own, without provoking Baldur's Gate and the Flaming Fist.~ [R#ILT21] */
  IF ~~ THEN GOTO 24
END

IF ~~ THEN BEGIN 29
  SAY @15044 /* ~Excellent! You already know what to do. Get back to me when you are done and then we will see what I can do about your missing person.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 30
  SAY @15048 /* ~Good. Very good. This is a good start to our business arrangement. Please, do finish the other task too and then we will talk more.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 31
  SAY @15052 /* ~Now that our business here has concluded, I will have to know who am I supposed to be looking for?~ [R#ILT31] */
  IF ~~ THEN REPLY @15053 /* ~I want you to find Luci Galan. She was supposedly trapped by a mage into a gem.~ */ GOTO 32
END

IF ~~ THEN BEGIN 32
  SAY @15054 /* ~Ha ha ha! I should have guessed. You are looking for the very same person I wanted you to find. Well, at least the other one. So, I guess you found Quinn, but not Luci? If I had known this I had gone back to Amn to find them myself. However, deal is a deal.~ [R#ILT32] */
  IF ~~ THEN REPLY @15055 /* ~Yes, that's correct.~ */ GOTO 33
END

IF ~~ THEN BEGIN 33
  SAY @15056 /* ~Very well. I shall go back to Amn and contact a friend of mine, Tolgerias, who is very good at things like these. We will find Luci for you, but it's going to take some time. I'll be back in a week or so. I will meet you here then.~ */
  IF ~~ THEN REPLY @15057 /* ~Very well. One week and I'll meet you here.~ */ DO ~AddJournalEntry(@100129,QUEST)
EraseJournalEntry(@100126)
EraseJournalEntry(@100127)
~ EXIT
END

IF ~~ THEN BEGIN 34
  SAY @15049 /* ~Good. Very good. Now that your end of the deal is done, it is time for me to fulfill my promise.~ */
  IF ~~ THEN REPLY @15051 /* ~So, what can you do about the missing person?~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",10)
~ GOTO 31
END

IF ~~ THEN BEGIN 35
  SAY @15059 /* ~Yes, indeed I did. However, you are not going to like this. She has been captured by a infamous scoundrel and bounty hunter called Dhan "Untouchable" Menhvor. The Cowled Wizards have had encounters with him in the past, but he has always managed to elude us.~ */
  IF ~~ THEN REPLY @15060 /* ~How did this Dhan manage to capture her? Didn't Horben cast Trap the Soul spell on her?~ */ GOTO 36
END

IF ~~ THEN BEGIN 36
  SAY @15061 /* ~It took a lot of effort and many favors to get this information, so I suggest that you appreciate it. Tolgerias even had to contact a planar ally of ours to find out where Luci is. However, back to the matter at hand. It seems that the Flaming Fist raided one of the storages in Baldur's Gate. One that belonged to Dhan Menhvor. The storage held mostly mundane items, but unbeknowst to anyone in the mercenary company, the beholder statues they took were actually magical.~ */
  IF ~~ THEN GOTO 37
END

IF ~~ THEN BEGIN 37
  SAY @15062 /* ~I was able to track one of them to Nashkel Carnival. These items are actually ingenious magical traps. Anyone in the vicinity of the statue getting trapped by a spell such as Trap the Soul, is actually trapped inside the statue, not the gem. But that is not the best part. If a creature's soul is captured inside any of these statues, you can collect it from a different identical statue elsewhere. Meaning if someone is captured in Amn, they could collect the soul in Baldur's Gate. Ingenious!~ */
  IF ~~ THEN GOTO 38
END

IF ~~ THEN BEGIN 38
  SAY @15063 /* ~The statue is an infinite storage for souls and instant transportation to anywhere in Faerun, without fearing the prisoners fighting back. It seems Horben has one of these statues and actually doesn't know anything about its function. The fool.~ */
    IF ~~ THEN REPLY @15064 /* ~This doesn't however tell me where Luci might be?~ */ GOTO 39
END

IF ~~ THEN BEGIN 39
  SAY @15065 /* ~Well of course I cannot be sure, but all the evidence does point to Dhan. He is the one you should contact.~ */
    IF ~~ THEN REPLY @15066 /* ~And how the hell am I supposed to find him?~ */ GOTO 40
END

IF ~~ THEN BEGIN 40
  SAY @15067 /* ~Well you are in luck. I think he wants the statues back as I was informed by my spies that he is actually staying in Elfsong Tavern in Baldur's Gate. There seems to be no other reason for him being in Baldur's Gate. As you already know, I cannot contact him there due to the political climate, so the rest is up to you. So, for now I say: farewell.~ */
    IF ~~ THEN REPLY @15068 /* ~Well, thanks and farewell.~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",12)
SetGlobal("TEW_KNOW_PORTAL","GLOBAL",1)
AddJournalEntry(@100130,QUEST)
EraseJournalEntry(@100129)
~ EXIT
END


//////////////////////////////////////////////////
// Wallace
//////////////////////////////////////////////////
BEGIN ~R#MERC01~

IF WEIGHT #1
~!StateCheck(Myself,STATE_CHARMED)
Global("Wallace_charmed","GLOBAL",0)
~ THEN BEGIN 0 // from:
  SAY @13100 /* ~Hello, friend. Would you care to see my wares?~ */
  IF ~~ THEN REPLY @13101 /* ~I would like to see what you have for sale.~ */ DO ~StartStore("R#Merc01",LastTalkedToBy)
~ EXIT
  IF ~Global("Wallace_inquire","GLOBAL",0)
Global("reso_stone_ob","GLOBAL",0)~ THEN REPLY @13102 /* ~If I may inquire, what are you doing here in the middle of nowhere with all the bandits around? Wouldn't it have been safer to stop at Cragmyr for example?~ */ GOTO 2
  IF ~~ THEN REPLY @13103 /* ~No, thanks.~ */ GOTO 1
END

IF ~~ THEN BEGIN 1
  SAY @13104 /* ~As you will. Farewell.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 2
  SAY @13105 /* ~Yes it propably would have been. But we cannot stop there. We just... cannot.~ */
  IF ~~ THEN REPLY @13106 /* ~Why not?~ */ DO ~SetGlobal("Wallace_inquire","GLOBAL",1)
AddJournalEntry(@100102,QUEST)
~ GOTO 3
END

IF ~~ THEN BEGIN 3
  SAY @13107 /* ~Stop with your silly questions. We just cannot! Now! Do you want to see what I have for sale or not?~ */
  IF ~~ THEN REPLY @13101 /* ~I would like to see what you have for sale.~ */ DO ~StartStore("R#Merc01",LastTalkedToBy)
~ EXIT
  IF ~~ THEN REPLY @13103 /* ~No, thanks.~ */ GOTO 1
END

IF WEIGHT #1
~StateCheck(Myself,STATE_CHARMED)
Global("Wallace_charmed","GLOBAL",0)
Global("reso_stone_ob","GLOBAL",0)
~ THEN BEGIN 4
  SAY @13108 /* ~Hello, friend. I think you might be my bestest of friends! How can I help you?~ */
  IF ~~ THEN REPLY @13109 /* ~Could you maybe tell your best friend why the caravan didn't stop at Cragmyr Keep?~ */ GOTO 5
END

IF ~~ THEN BEGIN 5
  SAY @13110 /* ~I wish I could! Everyone just felt we couldn't stop there. We felt an unexplainable urge to avoid the whole place! But I do know something: there is something fishy going on in the next tent, my bestest of friends. I bet you could find some answers there!~ */
  IF ~~ THEN GOTO 6
END

IF ~~ THEN BEGIN 6
  SAY @13111 /* ~The obnoxious gem merchant there however doesn't like anyone entering his tent and he will call guards if anyone does. Be warned!~ */
  IF ~~ THEN REPLY @13112 /* ~Alright. Thanks for the tip, friend.~ */ DO ~SetGlobal("Wallace_charmed","GLOBAL",1)
AddJournalEntry(@100103,QUEST)
EraseJournalEntry(@100102)
~ EXIT
END


//////////////////////////////////////////////////
// Bob the Merchant
//////////////////////////////////////////////////
BEGIN ~R#MERC02~

IF WEIGHT #1 
~True()
~ THEN BEGIN 0
  SAY @13200 /* ~What are you doing here! You have no business in my tent. Get out of here or I call get guards!~ */
  IF ~~ THEN DO ~RealSetGlobalTimer("alarm","RANI52",6)
~ EXIT 
END


//////////////////////////////////////////////////
// Thalantyr
//////////////////////////////////////////////////
EXTEND_BOTTOM THALAN 1
IF ~PartyHasItem("R#MTRAP")
Global("TEW_caravanquest","GLOBAL",2)~ THEN REPLY @13300 /* ~I heard that you might be someone who knows quite a lot about magical items. Care to take a look at this? Or should I take it to someone else? Maybe Halbazzer Drin?~ */ GOTO R#THALANSTATE1 
END

APPEND THALAN
IF ~~ THEN R#THALANSTATE1
SAY @13301 /* ~What!? Nonsense! I know these things better than he does. What is the item? Let me see.~ */
IF ~~ THEN DO ~TakePartyItem("R#MTRAP")
DestroyItem("R#MTRAP")
~GOTO R#THALANSTATE2
END

IF ~~ THEN R#THALANSTATE2
SAY @13302 /* ~Hmmm. Most interesting. This is a resonance stone. Sometimes used by enchanters and psionic races, such as mind flayers, to deliver suggestions to anyone within short distance from it.~ */
IF ~~ THEN GOTO R#THALANSTATE3
END

IF ~~ THEN R#THALANSTATE3
SAY @13303 /* ~This particular stone obviously tries to keep anyone away from Cragmyr Keep. The stone however seems to be a minor and nonpermanent of its type, and will eventually run out of its power.~ */
  IF ~~ THEN REPLY @13304 /* ~Do you have any idea where this stone came from?~ */ GOTO R#THALANSTATE4
END

IF ~~ THEN R#THALANSTATE4
SAY @13305 /* ~The stone does have a weird resonance in it. Something I have never come across. But I do recognize these markings here. Although the stone obviously wasn't made by him. I am talkig about Talessyr Tranth. He is a peddlar of transmutation potions and such at the Wide.~ */
  IF ~~ THEN REPLY @13306 /* ~The Wide? What's that?~ */ GOTO R#THALANSTATE5
END

IF ~~ THEN R#THALANSTATE5
SAY @13307 /* ~*Sigh* Where have you lived all your life? In a barrel? It is the central marketplace in Baldur's Gate city.~ */
  IF ~~ THEN REPLY @13308 /* ~Aaa. Thank you for help. I'll be going now~ */ GOTO R#THALANSTATE6
END

IF ~~ THEN R#THALANSTATE6
SAY @13309 /* ~Wait! Before you go. I have a proposition for you. The stone intrigues me, so I am offering to buy it from you. Let's say 500 gold coins. What say you?~ */
  IF ~~ THEN REPLY @13310 /* ~It's a deal. You keep the stone. I have no need for it.~ */ GOTO R#THALANSTATE8
  IF ~~ THEN REPLY @13311 /* ~No thanks. I think I hold on to the stone for now.~ */ GOTO R#THALANSTATE7
END

IF ~~ THEN R#THALANSTATE7
SAY @13312 /* ~Well, it is your loss. Here is the stone. Farewell.~ */
IF ~~ THEN DO ~GiveItemCreate("R#MTRAP2",[PC],1,1,0)
SetGlobal("TEW_caravanquest","GLOBAL",3)
AddJournalEntry(@100106,QUEST)
EraseJournalEntry(@100105)
~EXIT
END

IF ~~ THEN R#THALANSTATE8
SAY @13313 /* ~Most wise choice! Here is your gold. Farewell and good luck!~ */
IF ~~ THEN DO ~GiveGoldForce(500)
SetGlobal("TEW_caravanquest","GLOBAL",3)
AddJournalEntry(@100106,QUEST)
EraseJournalEntry(@100105)
~EXIT
END
END


//////////////////////////////////////////////////
// Halbazzer Drin
//////////////////////////////////////////////////
EXTEND_BOTTOM HALBAZ 0
IF ~PartyHasItem("R#MTRAP")
Global("TEW_caravanquest","GLOBAL",2)~ THEN REPLY @13314 /* ~I heard that you might be someone who could help me identify this item. Care to take a look at this?~ */ GOTO R#HALBAZSTATE1 
END

APPEND HALBAZ
IF ~~ THEN R#HALBAZSTATE1
SAY @13315 /* ~Of course. For a price. Let's say 100 gold coins.~ */
  IF ~~ THEN REPLY @13316 /* ~The price is too steep. I'll find someone else.~ */ EXIT
  IF ~PartyGoldGT(99)~ THEN REPLY @13317 /* ~Alright. Tell me what you can find out.~ */ DO ~TakePartyItem("R#MTRAP")
TakePartyGold(100)
DestroyGold(100)
DestroyItem("R#MTRAP")
~ GOTO R#HALBAZSTATE2
END

IF ~~ THEN R#HALBAZSTATE2
SAY @13302 /* ~Hmmm. Most interesting. This is a resonance stone. Sometimes used by enchanters and psionic races, such as mind flayers, to deliver suggestions to anyone within short distance from it.~ */
IF ~~ THEN GOTO R#HALBAZSTATE3
END

IF ~~ THEN R#HALBAZSTATE3
SAY @13303 /* ~This particular stone obviously tries to keep anyone away from Cragmyr Keep. The stone however seems to be a minor and nonpermanent of its type, and will eventually run out of its power.~ */
  IF ~~ THEN REPLY @13304 /* ~Do you have any idea where this stone came from?~ */ GOTO R#HALBAZSTATE4
END

IF ~~ THEN R#HALBAZSTATE4
SAY @13305 /* ~The stone does have a weird resonance in it. Something I have never come across. But I do recognize these markings here. Although the stone obviously wasn't made by him. I am talkig about Talessyr Tranth. He is a peddlar of transmutation potions and such at the Wide.~ */
  IF ~~ THEN REPLY @13306 /* ~The Wide? What's that?~ */ GOTO R#HALBAZSTATE5
END

IF ~~ THEN R#HALBAZSTATE5
SAY @13307 /* ~*Sigh* Where have you lived all your life? In a barrel? It is the central marketplace in Baldur's Gate city.~ */
  IF ~~ THEN REPLY @13308 /* ~Aaa. Thank you for help. I'll be going now~ */ GOTO R#HALBAZSTATE6
END

IF ~~ THEN R#HALBAZSTATE6
SAY @13309 /* ~Wait! Before you go. I have a proposition for you. The stone intrigues me, so I am offering to buy it from you. Let's say 500 gold coins. What say you?~ */
  IF ~~ THEN REPLY @13310 /* ~It's a deal. You keep the stone. I have no need for it.~ */ GOTO R#HALBAZSTATE8
  IF ~~ THEN REPLY @13311 /* ~No thanks. I think I hold on to the stone for now.~ */ GOTO R#HALBAZSTATE7
END

IF ~~ THEN R#HALBAZSTATE7
SAY @13318 /* ~Well, it is your loss. Here is the stone. If you want to use the stone for another purpose before it loses its magic, I would recommend speaking to this rather peculiar inventor who passed here not so long ago. His name escapes me, but he was heading for Cragmyr Keep.~ */
IF ~~ THEN DO ~GiveItemCreate("R#MTRAP2",[PC],1,1,0)
SetGlobal("TEW_caravanquest","GLOBAL",3)
AddJournalEntry(@100107,QUEST)
EraseJournalEntry(@100105)
~EXIT
END

IF ~~ THEN R#HALBAZSTATE8
SAY @13313 /* ~Most wise choice! Here is your gold. Farewell and good luck!~ */
IF ~~ THEN DO ~GiveGoldForce(500)
SetGlobal("TEW_caravanquest","GLOBAL",3)
AddJournalEntry(@100108,QUEST)
EraseJournalEntry(@100105)
~EXIT
END
END


//////////////////////////////////////////////////
// Beggar
//////////////////////////////////////////////////
BEGIN ~R#BEGGAR~

IF ~ReactionLT(LastTalkedToBy,FRIENDLY_LOWER)
Gender(LastTalkedToBy,FEMALE)
!Global("TEW_caravanquest","GLOBAL",4)
~ THEN BEGIN 0 // from:
  SAY #8500 /* ~Please, if you will, milady. Spare a coin?~ */
  IF ~  PartyGoldGT(0)
~ THEN REPLY #8513 /* ~Take this gold coin.~ */ DO ~TakePartyGold(1)
~ GOTO 9
  IF ~  PartyGoldGT(0)
~ THEN REPLY #8512 /* ~Here's a gold coin, you lousy bum!~ */ DO ~TakePartyGold(1)
~ GOTO 11
  IF ~~ THEN REPLY #8514 /* ~Get out of my way, bum!~ */ EXIT
END

IF ~  ReactionLT(LastTalkedToBy,FRIENDLY_LOWER)
Gender(LastTalkedToBy,MALE)
!Global("TEW_caravanquest","GLOBAL",4)
~ THEN BEGIN 1 // from:
  SAY #8501 /* ~Please, if you will, milord. Spare a coin?~ */
  IF ~~ THEN REPLY #8515 /* ~Shut up, street trash!~ */ EXIT
  IF ~  PartyGoldGT(0)
~ THEN REPLY #8516 /* ~Here's a gold coin; take it and get out of my way. Lousy beggar.~ */ DO ~TakePartyGold(1)
~ GOTO 10
  IF ~  PartyGoldGT(0)
~ THEN REPLY #8517 /* ~Take this gold coin.~ */ DO ~TakePartyGold(1)
~ GOTO 8
END

IF ~  ReactionGT(LastTalkedToBy,NEUTRAL_UPPER)
Gender(LastTalkedToBy,MALE)
!Global("TEW_caravanquest","GLOBAL",4)
~ THEN BEGIN 2 // from:
  SAY #8502 /* ~Pardon thy lordship, but I've not eaten in nigh unto three days. Spare a coin?~ */
  IF ~  PartyGoldGT(0)
~ THEN REPLY #8519 /* ~Take this gold coin and use it well.~ */ DO ~TakePartyGold(1)
~ GOTO 7
  IF ~~ THEN REPLY #8518 /* ~Get a job!~ */ EXIT
END

IF ~  ReactionGT(LastTalkedToBy,NEUTRAL_UPPER)
Gender(LastTalkedToBy,FEMALE)
!Global("TEW_caravanquest","GLOBAL",4)
~ THEN BEGIN 3 // from:
  SAY #8503 /* ~Pardon thy ladyship, but I've not eaten in nigh unto three days. Spare a coin?~ */
  IF ~  PartyGoldGT(0)
~ THEN REPLY #8520 /* ~Take this coin, you poor creature.~ */ DO ~TakePartyGold(1)
~ GOTO 9
  IF ~~ THEN REPLY #8521 /* ~Sorry, but I don't have anything to give you.~ */ EXIT
END

IF ~~ THEN BEGIN 4 // from:
  SAY #8504 /* ~Could ye spare but a bit of change?~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 5 // from:
  SAY #8505 /* ~Alms? Alms for the poor?~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 6 // from:
  SAY #8506 /* ~Spare a coin for a fella down on his luck?~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 7 // from: 2.0
  SAY #8507 /* ~Thank you! Good fortune smile on ye.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 8 // from: 1.2
  SAY #8508 /* ~You're a saint, milord.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 9 // from: 3.0 0.0
  SAY #8509 /* ~You're a saint, milady.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 10 // from: 1.1
  SAY #8510 /* ~May the gods look favorably upon ye.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 11 // from: 0.1
  SAY #8511 /* ~You are too kind. Bless you.~ */
  IF ~~ THEN EXIT
END

IF ~  StateCheck(Myself,STATE_CHARMED)
~ THEN BEGIN 12 // from:
  SAY #8522 /* ~I'm a lousy street bum; you're too good to be my friend. Just leave me alone.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 13 // from:
  SAY #8940 /* ~You've made no friends here! Move along!~ */
  IF ~~ THEN EXIT
END

IF ~Global("TEW_caravanquest","GLOBAL",4)
~ THEN BEGIN 14
  SAY @12500 /* ~Pardon me, but I take you are looking into Talessyr's dirty laundry? Am I correct?~ */
  IF ~~ THEN REPLY @12501 /* ~Yes, you are correct. Do you know something?~ */ GOTO 15
END

IF ~~ THEN BEGIN 15
  SAY @12502 /* ~Well yes I do. He always leaves at sometime during the night and goes into the sewers. I do not know where he goes, but that he does.~ */
  IF ~~ THEN REPLY @12503 /* ~Hmmm. Thank you for the information.~ */ GOTO 16
END

IF ~~ THEN BEGIN 16
  SAY @12504 /* ~The information was obviously worth something to you. So, maybe you could spare a few platinum coins to a helpful stranger?~ */
  IF ~PartyGoldGT(99)
~ THEN REPLY @12505 /* ~Sure. Here you go.~ */ DO ~TakePartyGold(100)
AddJournalEntry(@100110,QUEST)
EraseJournalEntry(@100109)
SetGlobal("TEW_caravanquest","GLOBAL",5)
SetGlobal("TEW_BEGGARGOLD","GLOBAL",1)
EscapeArea()
~ GOTO 11
  IF ~~ THEN REPLY @12506 /* ~Platinum coins? That's like a hundred gold coins! Get lost!~ */ DO ~SetGlobal("TEW_caravanquest","GLOBAL",5)
AddJournalEntry(@100110,QUEST)
EraseJournalEntry(@100109)
EscapeArea()
~ GOTO 17
END

IF ~~ THEN BEGIN 17 // from:
  SAY @12507 /* ~Ungrateful bastard!~ */
  IF ~~ THEN EXIT
END

//////////////////////////////////////////////////
// TALESSYR DOOR
//////////////////////////////////////////////////
BEGIN ~R#TDOOR~

IF ~ True()
~ THEN BEGIN 0
  SAY @12100 /* ~The mechanism that operates this door does not have a conventional lock, and may be warded against simple spells.~ */
  IF ~  Global("TDOOR_PASS","GLOBAL",1)
Global("TDOOR_BREAKIN","GLOBAL",0)
GlobalLT("TEW_caravanquest","GLOBAL",8)
Global("TALESS_DEAD","GLOBAL",0)
~ THEN REPLY @12101 /* ~Coconut.~ */ DO ~OpenDoor("RANI53DOOR")
~ EXIT
  IF ~  Global("TDOOR_PASS","GLOBAL",1)
Global("TALESS_DEAD","GLOBAL",1)
~ THEN REPLY @12101 /* ~Coconut.~ */ DO ~OpenDoor("RANI53DOOR")
~ EXIT
  IF ~  Global("TDOOR_PASS","GLOBAL",1)
OR(2)
Global("TDOOR_BREAKIN","GLOBAL",1)
GlobalGT("TEW_caravanquest","GLOBAL",7)
Global("TALESS_DEAD","GLOBAL",0)
~ THEN REPLY @12101 /* ~Coconut.~ */ GOTO 1
  IF ~~ THEN REPLY @12102 /* ~Leave.~ */ EXIT
END

IF ~~ THEN BEGIN 1
  SAY @12103 /* ~It seems the password has been changed. You cannot enter the building anymore.~ */
  IF ~~ THEN EXIT
END


//////////////////////////////////////////////////
// RANI55 PORTAL
//////////////////////////////////////////////////
BEGIN ~R#PORT55~

IF ~ True()
~ THEN BEGIN 0
  SAY @12200 /* ~This portal key seems to operate without the need of a Portal Breach scroll. You feel there is at least a dozen different portal keys this one leads to, but you can sadly only use the ones you know about.~ */
  IF ~~ THEN REPLY @12201 /* ~Use the portal key to enter Nashkel Carnival.~ */ DO ~ActionOverride(Player1,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player2,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player3,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player4,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player5,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player6,ForceSpellRES("R#PORTA",Myself))
Wait(4)
ActionOverride(Player1,LeaveAreaLUA("AR4905","",[265.260],0))
ActionOverride(Player2,LeaveAreaLUA("AR4905","",[255.250],0))
ActionOverride(Player3,LeaveAreaLUA("AR4905","",[255.250],0))
ActionOverride(Player4,LeaveAreaLUA("AR4905","",[255.250],0))
ActionOverride(Player5,LeaveAreaLUA("AR4905","",[255.250],0))
ActionOverride(Player6,LeaveAreaLUA("AR4905","",[255.250],0)) 
SetGlobalTimer("TEW_PORTAL","GLOBAL",ONE_ROUND)
~ EXIT
  IF ~Global("EnteredBaldursGate","GLOBAL",1)
~ THEN REPLY @12202 /* ~Use the portal key to enter the Wide in Baldur's Gate.~ */ DO ~ActionOverride(Player1,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player2,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player3,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player4,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player5,ForceSpellRES("R#PORTA",Myself))
ActionOverride(Player6,ForceSpellRES("R#PORTA",Myself))
Wait(4)
ActionOverride(Player1,LeaveAreaLUA("RANI46","",[265.260],0))
ActionOverride(Player2,LeaveAreaLUA("RANI46","",[255.250],0))
ActionOverride(Player3,LeaveAreaLUA("RANI46","",[255.250],0))
ActionOverride(Player4,LeaveAreaLUA("RANI46","",[255.250],0))
ActionOverride(Player5,LeaveAreaLUA("RANI46","",[255.250],0))
ActionOverride(Player6,LeaveAreaLUA("RANI46","",[255.250],0))
SetGlobalTimer("TEW_PORTAL","GLOBAL",ONE_ROUND) 
~ EXIT
  IF ~~ THEN REPLY @12102 /* ~Leave.~ */ EXIT
END


//////////////////////////////////////////////////
// Robb the Ghost
//////////////////////////////////////////////////
BEGIN ~R#GHOST3~

IF ~ Global("R#GHOST3_SUM_T","GLOBAL",0)
~ THEN BEGIN 0
  SAY @16000 /* ~You! You called me! Please, I have nothing to tell you, but that I was captured on a caravan heading to Cragmyr's Keep. Mal was throwing his flaming liquid around and they got me.~ */
  IF ~~ THEN GOTO 1
END

IF ~~ THEN BEGIN 1
  SAY @16001 /* ~Please! You can help me. Could you please take my wedding ring to my wife Talisa in Cragmyr village? You can find it around my feet there, if you really look for it. The bandits didn't notice it. I hope all the best for you.~ */
  IF ~~ THEN DO ~DropItem("R#ROBB01",[-1.-1])
SetGlobal("R#GHOST3_SUM_T","GLOBAL",1)
~ EXIT
END

//////////////////////////////////////////////////
// Tassiter
//////////////////////////////////////////////////
BEGIN ~R#TASSI~

IF ~True()
~ THEN BEGIN 0
  SAY @16005 /* ~You there! What are you doing here? These sewers are a not a place for a fine <SIRMAAM> like yourself. However, there is a new tax in the city. It is called a Sewer Passage Tax. Everyone except sewer cleaners must pay the tax. It's 1000 gold coins.~ */
  IF ~~ THEN REPLY @16006 /* ~Hmmm. Alright. Who are you by the way?~ */ GOTO 1
END

IF ~~ THEN BEGIN 1
  SAY @16007 /* ~Me? I am just a simple sewer cleaner, who until recently has felt the keen sting of power. Tassiter is the name. However, I don't like repeating myself. So please <SIRMAAM>, can you please pay the tax so we can be on our way?~ */
  IF ~~ THEN REPLY @16008 /* ~No way you filty sewer rat. I am not giving you any made up tax gold.~ */ GOTO 2
  IF ~PartyGoldGT(999)~ THEN REPLY @16009 /* ~Sure thing. I'll give you the tax money.~ */ DO ~TakePartyGold(1000)
~ GOTO 3
  IF ~CheckStatGT([PC],22,CHR)~ THEN REPLY @16010 /* ~I think you are mistaken. I am the Sewer Cleaning Coordinator and last month you had an advance on your pay, so you owe me 1000 gold coins.~ */ GOTO 4
END

IF ~~ THEN BEGIN 2
  SAY @16011 /* ~It looks like fresh meat is back on the menu boys! Get them!~ */
  IF ~~ THEN DO ~Enemy()
SetGlobal("TASSI_ENEMY","GLOBAL",1)
~ EXIT
END

IF ~~ THEN BEGIN 3
  SAY @16012 /* ~Very good <SIRMAAM>. Now you are free to roam the sewers as you please. Let's go boys. We have to... clean the sewers... or something.~ */
  IF ~~ THEN DO ~SetGlobal("TASSI_ESCAPE","GLOBAL",1)
EscapeArea()
~ EXIT
END

IF ~~ THEN BEGIN 4
  SAY @16013 /* ~Ouh really? I am very sorry <SIRMAAM>. I don't have any money. Maybe you will you accept my personal club as payment?~ */
  IF ~~ THEN REPLY @16014 /* ~Hmm. Well that will have to do. Thank you.~ */ DO ~GiveItem("R#TASSI",[PC])
AddexperienceParty(800)
SetGlobal("TASSI_ESCAPE","GLOBAL",1)
EscapeArea()
~ EXIT
END

//////////////////////////////////////////////////
// Talisa
//////////////////////////////////////////////////
BEGIN ~R#TALISA~

IF WEIGHT #1
~  Global("Robb_RING","GLOBAL",0)
~ THEN BEGIN 0 // from:
  SAY @16002 /* ~Please, if you see my husband Robb, could you tell him to come home.~ */
  IF ~PartyHasItem("R#ROBB01")~ THEN REPLY @16003 /* ~I found your husband. I am sorry to say, but he is dead. He wanted me to bring this to you.~ */ GOTO 2
  IF ~~ THEN REPLY #466 /* ~Sure.~ */ EXIT
END

IF WEIGHT #0 ~  StateCheck(Myself,STATE_CHARMED)
~ THEN BEGIN 1 // from:
  SAY #6902 /* ~I'm just a town girl. I don't know much other than the usual gossip.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 2
  SAY @16004 /* ~Ouh no! No Robb! *sob* He just went to buy new shovels from Baldur's Gate. Nothing more. I... I don't have much to give you as a reward, but... take this. Maybe it will help you save other women's husbands.~ */
  IF ~~ THEN DO ~GiveItemCreate("potn52",[PC],1,1,0)
ReputationInc(1)
TakePartyItem("R#ROBB01")
SetGlobal("Robb_RING","GLOBAL",1)
~ EXIT
END

IF ~Global("Robb_RING","GLOBAL",1)
~ THEN BEGIN 3
  SAY #6902 /* ~I'm just a town girl. I don't know much other than the usual gossip.~ */
  IF ~~ THEN EXIT
END

//////////////////////////////////////////////////
// Baldur's Gate Beggars
//////////////////////////////////////////////////
EXTEND_BOTTOM BEGGBA 0
IF ~Global("ILTAR_QUEST1","GLOBAL",2)~ THEN REPLY @16020 /* ~I heard you might know where they dump unwanted bodies here? So, do you?~ */ GOTO R#BEGGBASTATE1 
END

EXTEND_BOTTOM BEGGBA 1
IF ~Global("ILTAR_QUEST1","GLOBAL",2)~ THEN REPLY @16020 /* ~I heard you might know where they dump unwanted bodies here? So, do you?~ */ GOTO R#BEGGBASTATE1 
END

EXTEND_BOTTOM BEGGBA 2
IF ~Global("ILTAR_QUEST1","GLOBAL",2)~ THEN REPLY @16020 /* ~I heard you might know where they dump unwanted bodies here? So, do you?~ */ GOTO R#BEGGBASTATE1 
END

EXTEND_BOTTOM BEGGBA 3
IF ~Global("ILTAR_QUEST1","GLOBAL",2)~ THEN REPLY @16020 /* ~I heard you might know where they dump unwanted bodies here? Especially a female wizard body of a shopkeeper at the Wide.~ */ GOTO R#BEGGBASTATE1 
END

EXTEND_BOTTOM BEGGBA 4
IF ~Global("ILTAR_QUEST1","GLOBAL",2)~ THEN REPLY @16020 /* ~I heard you might know where they dump unwanted bodies here? So, do you?~ */ GOTO R#BEGGBASTATE1 
END

APPEND BEGGBA
IF ~~ THEN R#BEGGBASTATE1
SAY @16021 /* ~Ouh yes I do. But that information is gonna cost you a lot! Give me one gold coin and I tell ya.~ */
  IF ~~ THEN REPLY @16022 /* ~I think not. I find someone else.~ */ EXIT
  IF ~PartyGoldGT(0)~ THEN REPLY @16023 /* ~Hmm. Alright. Here you go. Now tell me where they dump the bodies.~ */ DO ~TakePartyGold(1)
SetGlobal("ILTAR_QUEST1","GLOBAL",3)
~ GOTO R#BEGGBASTATE2
END

IF ~~ THEN R#BEGGBASTATE2
SAY @16024 /* ~I saw the Flaming Fist dumping the body into the sewers. The eastern part. You should be able to find her body there.~ */
IF ~~ THEN EXIT
END
END

//////////////////////////////////////////////////
// Dhan Menvhor
//////////////////////////////////////////////////
BEGIN ~R#DHANM~

IF WEIGHT #1
~ True() ~ THEN BEGIN 0
  SAY @17000 /* ~Hmph. You here to buy scrolls? I do not have time for small talk.~ */
  IF ~~ THEN REPLY @17001 /* ~Yeah sure. I take a look.~ */ DO ~StartStore("R#dhanm",LastTalkedToBy())
~ EXIT
  IF ~~ THEN REPLY @17002 /* ~Who are you? Why you selling scrolls in a tavern?~ */ GOTO 1
  IF ~Global("TEW_ogrequest","GLOBAL",12)~ THEN REPLY @17004 /* ~Are you Dhan "Untouchable" Menvhor? I have something I need from him.~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",13)
~ GOTO 2
  IF ~Global("TEW_ogrequest","GLOBAL",13)~ THEN REPLY @17005 /* ~I need to find Luci. Do you know where she is? Tell me, please.~ */ GOTO 3
  IF ~Global("TEW_ogrequest","GLOBAL",15)~ THEN REPLY @17028 /* ~The statue has been disabled. So, can I get Luci back now?~ */ GOTO 13
END

IF ~~ THEN BEGIN 1
  SAY @17003 /* ~That is none of your business. Now get lost. Like I said, I don't have time for small talk.~ */
  IF ~~ THEN EXIT
END

IF ~~ THEN BEGIN 2
  SAY @17006 /* ~Hmph. Maybe I am, maybe I'm not. What's it to you? Who are you mugs?~ */
  IF ~~ THEN REPLY @17007 /* ~My name is <GABBER>. We are looking for answers and I heard you might have the one with the answers. She is called Luci. Do you know where she is?~ */ GOTO 3
END

IF ~~ THEN BEGIN 3
  SAY @17008 /* ~Ouh, is that so? Well, maybe I do, maybe I don't. Might need a little something-something to jar my memory.~ */
  IF ~PartyGoldGT(999)~ THEN REPLY @17009 /* ~Very well. Here is a hundred.~ */ DO ~TakePartyGold(1000)
~ GOTO 4
  IF ~~ THEN REPLY @17010 /* ~I am not going to give you my gold. Nevermind.~ */ EXIT
END

IF ~~ THEN BEGIN 4
  SAY @17011 /* ~Ouh yeah, Luci. The last name is Galan if I am correct. I know her. And I even know where she is. But for that I need something more than just gold. I need a favor.~ */
  IF ~~ THEN REPLY @17012 /* ~A favor? Are you serious? We just gave you thousand gold coins.~ */ GOTO 5
END

IF ~~ THEN BEGIN 5
  SAY @17013 /* ~Yes, you did. And that will come to good use, since you purchased yourself a key to the place where they are holding her. Well, kind of holding her.~ */
  IF ~~ THEN REPLY @17014 /* ~What do you mean?~ */ GOTO 6
END

IF ~~ THEN BEGIN 6
  SAY @17015 /* ~Well, few weeks ago these Flaming Fist mercenaries raided my warehouse for not paying taxes. They confiscated all my inventory and I need them back. Well, not back, but... disabled.~ */
  IF ~~ THEN REPLY @17016 /* ~Disabled? What needs to be disabled?~ */ GOTO 7
END

IF ~~ THEN BEGIN 7
  SAY @17017 /* ~My guess is that you already know about the beholder statues since you are here asking about Luci. So, let me explain. They stole a huge number of those statues and now they have done something to them. The whole network of statues is out of order. And that means Luci is also trapped somewhere in there. I need you to break into their base at the docks and break all the statues they still have there.~ */
  IF ~~ THEN GOTO 8
END

IF ~~ THEN BEGIN 8
  SAY @17018 /* ~After those non-functional statues have been disabled, my... company's... network should be fully operational once more. And I can give you Luci. You can do whatever you want with her. I do not care.~ */
  IF ~~ THEN REPLY @17019 /* ~So you want me to break into a Flaming Fist building and break the statues? What if I am seen? Do I kill them all?~ */ GOTO 9
END

IF ~~ THEN BEGIN 9
  SAY @17020 /* ~I do not care if you kill a thousand Flaming Fist mercenaries, I just want those statues broken and disabled. This is a classical Quid pro quo situation: if you do not disable those statues, you or I neither get what we want. So, are we clear on the matter?~ */
  IF ~~ THEN REPLY @17021 /* ~Why haven't you already done this yourself? You seem more than capable.~ */ GOTO 10
END

IF ~~ THEN BEGIN 10
  SAY @17022 /* ~Why do something today yourself, when you can make someone else do the same thing tomorrow?~ */
  IF ~~ THEN REPLY @17023 /* ~Right. What about the gold? What was that for?~ */ GOTO 11
END

IF ~~ THEN BEGIN 11
  SAY @17024 /* ~Well, you just bought the rest of my inventory stored in the tower now occupied by the Flaming Fist. Enjoy!~ */
  IF ~~ THEN REPLY @17025 /* ~What? That is a cheap trick!~ */ GOTO 12
END

IF ~~ THEN BEGIN 12
  SAY @17026 /* ~If you don't want it, the Flaming Fist will surely put it into good use. But you should be happy. The items there are well worth over 1,000 measly gold coins. But now, I have other business to attend to. I shall give you Luci when you have disabled the statue. And don't try to cheat me on this.~ */
  IF ~~ THEN REPLY @17027 /* ~Sure. I'll be back.~ */ DO ~SetGlobal("TEW_ogrequest","GLOBAL",14)
~ EXIT
END

IF ~~ THEN BEGIN 13
  SAY @17029 /* ~Yes it seems you were successful with your quest. As promised, here is Luci. I have prepared the stone, so that Luci can be freed by anyone. Even by... well, you. Our business here is concluded, at least for now. Ta ta!~ */
  IF ~~ THEN DO ~SetGlobal("TEW_ogrequest","GLOBAL",16)
GiveItemCreate("R#LUCI3",[PC],1,1,0)
~ EXIT
END




