import 'package:wellbeingclinic/models/scale_model.dart';

import '../models/item_model.dart';

class Items {
  // wellbeing
  static String wellbeingInstruction =
      'নীচে সুস্থতা সম্পর্কিত ৫ টি উক্তি দেয়া আছে যা গত দুই সপ্তাহ ধরে আপনার অনুভূতিগুলো কেমন ছিল তা বর্ণনা করে। প্রতিটি উক্তি আপনার ক্ষেত্রে কতটুক প্রযোজ্য তা চিহ্নিত করুন';
  static List wellbeingScale = [
    ScaleModel(0, 'কোন সময় নয়'),
    ScaleModel(1, 'কিছু সময়'),
    ScaleModel(2, 'অর্ধেক সময়ের চেয়ে কম'),
    ScaleModel(3, 'অর্ধেক সময়ের চেয়ে বেশি'),
    ScaleModel(4, 'অধিকাংশ সময়'),
    ScaleModel(5, 'সব সময়'),
  ];
  static List<ItemModel> wellbeingItems = [
    ItemModel(
      1,
      'বিগত দুই সপ্তাহ ধরে আমি প্রফুল্ল ও আনন্দ অনুভব করেছি।',
    ),
    ItemModel(
      2,
      'বিগত দুই সপ্তাহ ধরে আমি শান্ত ও স্বস্তি অনুভব করছি।',
    ),
    ItemModel(
      3,
      'বিগত দুই সপ্তাহ ধরে আমি সক্রিয় এবং সবল ছিলাম।',
    ),
    ItemModel(
      4,
      'বিগত দুই সপ্তাহ ধরে আমি সতেজ এবং ফুরফুরে অনুভূতি নিয়ে ঘুম থেকে জেগেছি।',
    ),
    ItemModel(
      5,
      'বিগত দুই সপ্তাহ ধরে দৈনন্দিন জীবনে এমন বিষয়গুলো আমি পেয়েছি যেগুলো আমি আগ্রহ নিয়ে চেয়েছি।',
    ),
  ];

  // internet addiction Text
  static String internetAddictionInstruction =
      'নিম্নে বামপাশে আপনার ইন্টারনেট ব্যবহার সম্পর্কিত কিছু প্রশ্ন দেয়া আছে। প্রতিটি প্রশ্নের উত্তর ৫ বিন্দু বিশিষ্ট মানকের মাধ্যমে ডান পাশে দেয়া আছে। আপনি আপনার নিজের কথা চিন্তা করে প্রতিটি প্রশ্নের জন্য প্রযোজ্য উত্তরের সংখ্যাটি চিহ্নিত করুন। এখানে ভূল বা শুদ্ধ উত্তর বলে কিছু নেই। তাই অনুগ্রহ করে অকপটে উত্তর দিন।';
  static List internetAddictionScale = [
    ScaleModel(1, 'একেবারেই না'),
    ScaleModel(2, 'কিছুটা'),
    ScaleModel(3, 'মাঝে মাঝে'),
    ScaleModel(4, 'প্রায়ই'),
    ScaleModel(5, 'সব সময়'),
  ];
  static List<ItemModel> internetAddictionItems = [
    ItemModel(
      1,
      'আপনি কি আপনার প্রযোজনের চাইতে বেশি সময় অনলাইনে থাকেন?',
    ),
    ItemModel(
      2,
      'আপনি কি অনলাইনে থাকার জন্য দৈনন্দিন কাজকে অবহেলা করেন?',
    ),
    ItemModel(
      3,
      'আপনি কি অনলাইনে থাকার উত্তেজনাকে আপনার প্রিয়জনের নৈকট্যের চাইতে বেশি পছন্দ করেন?',
    ),
    ItemModel(
      4,
      'আপনি কি অনলাইনের মাধ্যমে নতুন নতুন সম্পর্ক তৈরি করেন ?',
    ),
    ItemModel(
      5,
      'আপনার প্রিয়জন কি আপনার দীর্ঘক্ষণ অনলাইনে থাকার বিষয়ে অভিযোগ করে থাকেন?',
    ),
    ItemModel(
      6,
      'অনলাইনে সময় ব্যয় করার জন্য কি আপনার লেখাপড়া ক্ষতিগ্রস্থ হয়?',
    ),
    ItemModel(
      7,
      'ইন্টারনেট ব্যবহারের কারণে আপনার কর্ম সম্পাদন ও উৎপাদনশীলতা কি বাধাগ্রস্থ হয় ?',
    ),
    ItemModel(8,
        'আপনি অনলাইনে কি করেন এই প্রশ্নের উত্তরে আপনি কি আত্মরক্ষামূলক পন্থা বা গোপনীয়তা অবলম্বন করেন ?'),
    ItemModel(9,
        'আপনি কি আপনার জীবনের বিরক্তিকর চিন্তাগুলোকে ইন্টারনেটের সুখকর চিন্তা দ্বারা প্রতিস্থাপন করেন ?'),
    ItemModel(10, 'আপনি পুনরায় অনলাইনে বসার জন্য কি অস্থিরতা প্রকাশ করেন ?'),
    ItemModel(11,
        'ইন্টারনেট ছাড়া জীবনকে কি আপনি একঘেঁয়ে ও নিরানন্দময় বলে মনে করেন ?'),
    ItemModel(12,
        'অনলাইনে থাকার সময় কারো হস্তক্ষেপ আপনার মাঝে কি বিরক্তি তৈরি করে ?'),
    ItemModel(13, 'গভীর রাতে অনলাইনে থাকার ফলে আপনি কি দেরিতে ঘুমোতে যান?'),
    ItemModel(14,
        'অফলাইন থাকাকালীন সময়ে আপনি কি নিজেকে অনলাইনে থাকার চিন্তায় নিমগ্ন বা বিভোর রাখেন?'),
    ItemModel(15,
        'আপনি কি অনলাইনে থাকার সময়কাল কমিয়ে আনার চেষ্টা করেন এবং ব্যর্থ হন?'),
    ItemModel(
        16, 'আপনি কতক্ষণ যাবৎ অনলাইনে থাকেন তা কি গোপন রাখার চেষ্টা করেন ?'),
    ItemModel(17,
        'অন্যদের সাথে বাইরে যাওয়ার চাইতে অনলাইনে থাকাকে কি আপনি বেশি পছন্দ করেন?'),
    ItemModel(18,
        'অফলাইনে থাকার সময় কি আপনি হতাশ, অভিমানী অথবা বিচলিত থাকেন যা পুনরায় অনলাইন হওয়ার সাথে সাথে আর থাকে না ?'),
  ];

  // Dark Triad Dirty Dozen
  static String dartTriadInstruction =
      'নিম্নে ব্যক্তিত্ব পরিমাপের কিছু উক্তি রয়েছে। প্রতিটি উক্তি আপনার ক্ষেত্রে কতুটুকু প্রযোজ্য তা ৭ মানকের যা কোন একটিতে টিকে প্রদানের মাধ্যমের প্রকাশ করুন।';
  static List dartTriadScale = [
    ScaleModel(1, 'দৃঢ় ভাবে অসম্মতি'),
    ScaleModel(2, 'অসম্মতি'),
    ScaleModel(3, 'সামান্য অসম্মতি'),
    ScaleModel(4, 'অসম্মতি বা সম্মতি কোনটি নয়'),
    ScaleModel(5, 'সামান্য সম্মতি'),
    ScaleModel(6, 'সম্মতি'),
    ScaleModel(7, 'দৃঢ় ভাবে সম্মতি'),
  ];
  static List<ItemModel> dartTriadItems = [
    ItemModel(
      1,
      'কার্যসিদ্ধির জন্য অন্যদের ব্যবহার করার প্রবণতা আমার আছে।',
    ),
    ItemModel(
      2,
      'কার্যসিদ্ধির জন্য আমি মিথ্যা বা প্রতারণার আশ্রয় নিয়েছি।',
    ),
    ItemModel(
      3,
      'কার্যসিদ্ধির জন্য আমি চাটুকারিতার আশ্রয় নিয়েছি।',
    ),
    ItemModel(
      4,
      'নিজের কাজ সম্পন্ন করতে অন্যদের কাজে লাগানোর প্রবণতা আমার রয়েছে।',
    ),
    ItemModel(
      5,
      'আমার অনুশোচনাবোধ কম।',
    ),
    ItemModel(
      6,
      'আমি আমার কাজের নৈতিক ভিত্তি নিয়ে চিন্তা করি না।',
    ),
    ItemModel(
      7,
      'আমি নির্বিকার বা অনুভূতিহীন প্রকৃতির।',
    ),
    ItemModel(8, 'আমি কঠিন প্রকৃতির মানুষ।'),
    ItemModel(9, 'আমি চাই অন্যরা আমার প্রশংসা করুক।'),
    ItemModel(10, 'আমি চাই অন্যরা আমার দিকে মনোযোগ দিক। '),
    ItemModel(11, 'আমি প্রতিপত্তি ও মর্যাদা লাভ করতে চাই।'),
    ItemModel(12,
        'আমার মাঝে অন্যদের থেকে বিশেষ আনুকূল্য প্রত্যাশা করার প্রবণতা রয়েছে।'),
  ];

  // selfEsteem
  static String selfEsteemInstruction =
      'নিচে আত্মমর্যাদা সম্পর্কিত ১০টি উক্তি রয়েছে। প্রতিটি উক্তি আপনার ক্ষেত্রে কতটুকু প্রযোজ্য তা ৪টি পছন্দক্রমের যেকোনো একটিতে টিক(v) চিহ্ন দিয়ে প্রকাশ করুন।';
  static List selfEsteemScaleP = [
    ScaleModel(3, 'সম্পূর্ণভাবে একমত'),
    ScaleModel(2, 'একমত'),
    ScaleModel(1, 'একমত নই'),
    ScaleModel(0, 'একেবারেই একমত নই'),
  ];
  static List selfEsteemScaleN = [
    ScaleModel(0, 'সম্পূর্ণভাবে একমত'),
    ScaleModel(1, 'একমত'),
    ScaleModel(2, 'একমত নই'),
    ScaleModel(3, 'একেবারেই একমত নই'),
  ];
  static List<ItemModel> selfEsteemItems = [
    ItemModel(
      1,
      'অন্যদের সাথে সমান মাপকাঠিতে বিচার করলে আমি মনে করি আমি একজন যোগ্য ব্যক্তি।',
    ),
    ItemModel(
      2,
      'আমি মনে করি আমার বেশ কিছু ভাল গুণ আছে।',
    ),
    ItemModel(
      3,
      'সামগ্রিক বিচারে আমার মনে করার প্রবণতা আছে যে আমি ব্যর্থ।',
    ),
    ItemModel(
      4,
      'বেশিরভাগ লোকের মতো আমিও বিভিন্ন কাজ করতে সক্ষম।',
    ),
    ItemModel(
      5,
      'আমার মনে হয় গর্ব করার মত আমার বেশি কিছু নেই।',
    ),
    ItemModel(
      6,
      'নিজের প্রতি আমার ইতিবাচক মনোভাব আছে।',
    ),
    ItemModel(
      7,
      'আমি নিজেকে নিয়ে মোটামুটি সন্তুষ্ট।',
    ),
    ItemModel(
      8,
      'আমার ইচ্ছে হয় আমি নিজের প্রতি আরও শ্রদ্ধাশীল হবো।',
    ),
    ItemModel(
      9,
      'মাঝে মাঝে আমার মনে হয় আমার মূল্য নেই।',
    ),
    ItemModel(
      10,
      'মাঝে মাঝে আমার মনে হয় আমি মোটেও ভালো নেই।',
    ),
  ];

  // socialAnxiety
  static String socialAnxietyInstruction =
      'নিচের বক্তব্য গুলো সামাজিক আচরণ বিষয়ক। আপনার ক্ষেত্রে মিল বা অমিলের ভিত্তিতে সত্য/মিথ্যা চিহ্নিত করুন।';
  static List socialAnxietyScale = [
    ScaleModel(
      0,
      'সত্য',
    ),
    ScaleModel(
      1,
      'মিথ্যা',
    ),
  ];
  static List<ItemModel> socialAnxietyItems = [
    ItemModel(
      1,
      'আমি অপরিচিত সামাজিক পরিবেশেও স্বচ্ছন্দ বোধ করি।',
    ),
    ItemModel(
      2,
      'সামাজিকতা মানতে বাধ্য করে এমন অবস্থা আমি এড়িয়ে চলতে চেষ্টা করি।',
    ),
    ItemModel(
      3,
      'অপরিচিত লোকের মাঝেও আমি স্বচ্ছন্দ বোধ করি।',
    ),
    ItemModel(
      4,
      'মানুষকে এড়িয়ে চলার পিছনে আমার কোন বিশেষ উদ্দেশ্য নেই ।',
    ),
    ItemModel(
      5,
      'আমি প্রায়ই সামাজিক অনুষ্ঠান সমূহকে বিশৃঙ্খল দেখি।',
    ),
    ItemModel(
      6,
      'আমি সাধারণত সামাজিক অনুষ্ঠানে স্বচ্ছন্দ বোধ করি।',
    ),
    ItemModel(
      7,
      'আমি বিপরীত লিঙ্গের কারো সাথে কথোপকথনের সময় সাধারণত সহজ থাকি।',
    ),
    ItemModel(
      8,
      'আমি ভালোভাবে কাউকে না জানা পর্যন্ত তাদের সাথে কথোপকথন এড়িয়ে চলি।',
    ),
    ItemModel(
      9,
      'যদি কোন নতুন ব্যক্তির সাথে পরিচয়ের সুযোগ আসে তাহলে আমি প্রায়ই তা গ্রহণ করি।',
    ),
    ItemModel(
      10,
      'পুরুষ ও মহিলা উভয়ের উপস্থিতিতে কোন ঘরোয়া প্রীতি সম্মেলনে যোগদান করতে আমি ভীষণ ভাবে নার্ভাস বোধ করি।',
    ),
    ItemModel(
      11,
      'ভালোভাবে কাউকে না জেনে লোকজনের সাথে মিশতে আমি সাধারণত নার্ভাস হয়ে পড়ি।',
    ),
    ItemModel(
      12,
      'আমি সাধারণত অনেক লোকের সাথে থাকতে স্বচ্ছন্দ বোধ করি।',
    ),
    ItemModel(
      13,
      'আমি প্রায়ই লোকজন থেকে দূরে থাকতে চাই।',
    ),
    ItemModel(
      14,
      'অপরিচিত কোন লোকজনের সাথে থাকতে আমি সাধারণত নার্ভাস হয়ে পড়।',
    ),
    ItemModel(
      15,
      'কারো সাথে প্রথম পরিচয়ে আমি স্বচ্ছন্দ বোধ করি।',
    ),
    ItemModel(
      16,
      'কারো সাথে পরিচিত হওয়ার সময় আমি উত্তেজিত ও নার্ভাস হয়ে পড়ি।',
    ),
    ItemModel(
      17,
      'ঘর ভর্তি অপরিচিত লোকের মধ্যে আমি যে কোনভাবেই প্রবেশ করতে পারি।',
    ),
    ItemModel(
      18,
      'আমি নিজ ইচ্ছায় কোনো বড় সমাবেশে যোগদান করি না।',
    ),
    ItemModel(
      19,
      'বয়োজ্যেষ্ঠরা যখন আমার সাথে কথা বলতে চান তখন আমি আগ্রহ ভরে তাদের সাথে কথা বলি।',
    ),
    ItemModel(
      20,
      'আমি যখন একদল লোকের মাঝে থাকি তখন প্রায়ই আমার মনে হয় আমি যেন কিনারে দাঁড়িয়ে আছি।',
    ),
    ItemModel(
      21,
      'আমি লোকজন থেকে নিজেকে দূরেও সরিয়ে রাখতে ভালোবাসি।',
    ),
    ItemModel(
      22,
      'কোন ঘরোয়া বা সামাজিক অনুষ্ঠানে লোকজনের সাথে কথা বলতে আমি সংকোচ বোধ করিনা।',
    ),
    ItemModel(
      23,
      'আমি বড় কোন সমাবেশে কদাচিৎ সহজ হতে পারি।',
    ),
    ItemModel(
      24,
      'সামাজিক কোন অনুষ্ঠান এড়াতে আমি প্রায়ই অজুহাত খুঁজি।',
    ),
    ItemModel(
      25,
      'লোকজনের সাথে পরস্পর পরিচয় করিয়ে দিতে আমি কখনও কখনও দায়িত্ব গ্রহণ করে থাকি।',
    ),
    ItemModel(
      26,
      'আনুষ্ঠানিক কোনে সামাজিক অনুষ্ঠান আমি এড়াতে চেষ্টা করি।',
    ),
    ItemModel(
      27,
      'আমি সাধারণত সব ধরণের সামাজিক অনুষ্ঠানে যাই।',
    ),
    ItemModel(
      28,
      'আমি সহজে অপরের সাথে মিলে আনন্দ উপভোগ করি।',
    ),
  ];

  // stress
  static String stressInstruction =
      'গত মাসে আপনার অনূভুতিও চিন্তা সম্পর্কিত কিছু প্রশ্ন করব। প্রতিটি প্রশ্ন আমি আপনাকে পড়ে শোনাব। প্রতিটি প্রশ্নের জন্য পাঁচটি (৫টি) করে জবাব দেয়া আছে। যেটি আপনার কাছে প্রযোজ্য মনে হবে সেভাবে জবাব দিন। এখানে ভূল বা সঠিক জবাব নেই আপনার নিজস্ব অনুভূতিই ব্যক্ত করুন। আপনার মতামত এভাবে প্রকাশ করুন।';
  static List stressScale = [
    ScaleModel(
      0,
      'কখনই না',
    ),
    ScaleModel(
      1,
      'প্রায় কখনই না/বেশির ভাগ সময় না',
    ),
    ScaleModel(
      2,
      'মাঝে মাঝে',
    ),
    ScaleModel(
      3,
      'প্রায়ই/বেশিরভাগ সময়',
    ),
    ScaleModel(
      4,
      'খুব বেশি',
    ),
  ];
  static List<ItemModel> stressItems = [
    ItemModel(
      1,
      'গত কিছুদিন ধরে (মাসখানেক) কতটা মানসিক চাপের মধ্যে থেকেছেন?',
    ),
    ItemModel(
      2,
      'গত কিছুদিন একটুতেই কতটা ঘাবড়ে গেছেন বা নার্ভাস বোধ করেছেন?',
    ),
    ItemModel(
      3,
      'গত কিছুদিন ধরে আপনার জীবনের গুরুত্বপূর্ণ বিষয়গুলো নিয়ন্ত্রণ করতে আপনি কতটা ব্যর্থ হয়েছেন বলে আপনার মনে হয়?    ',
    ),
    ItemModel(
      4,
      'গত কিছুদিন ধরে পাড়াপড়শী, পরিবারের লোকজনের সাথে কতটা ঝগড়া বিবাদ লেগে থেকেছে?',
    ),
    ItemModel(
      5,
      'গত কিছুদিন ধরে আপনি কতটা অনিশ্চয়তার মধ্যে থেকেছেন ও বিচলিত বোধ করেছেন? ',
    ),
    ItemModel(
      6,
      'গত কিছুদিন ধরে কতটা এমন আকস্মিক কিছু ঘটনা ঘটেছে যাতে আপনি হতবাক হয়ে গিয়েছিলেন?',
    ),
    ItemModel(
      7,
      'গত কিছুদিন ধরে খুব মন দিয়ে  কাজ করে কাজটি শেষ করতে পেরেছেন বলে কতটা মনে করেন?',
    ),
    ItemModel(
      8,
      'গত কিছুদিন ধরে আপনার জীবনের পীড়নকর (কষ্টকর) ঘটনাগুলো প্রতিনিয়ত মনের মধ্যে কতটা ঘুরপাক খেয়েছে?',
    ),
    ItemModel(
      9,
      'গত কিছুদিন ধরে আপনার জীবনের বিরক্তিকর বিষয়গুলো কতটা নিয়ন্ত্রণ করতে পেরেছেন?',
    ),
    ItemModel(
      10,
      'গত কিছুদিন ধরে আপনার ব্যক্তিগত সমস্যা সামাল দেয়ার ব্যাপারে কতটা আত্নবিশ্বাসী ছিলেন?',
    ),
    ItemModel(
      11,
      'গত কিছুদিন ধরে আপনি কোনো সমস্যায় পড়লে তা মোকাবেলার জন্য কতটা আপ্রাণ চেষ্টা করেছেন?',
    ),
    ItemModel(
      12,
      'গত কিছুদিন ধরে আপনার সমস্যাগুলো  সহজ ভাবে মেনে নিতে চেষ্টা করেছেন কতটা?',
    ),
    ItemModel(
      13,
      'গত কিছুদিন ধরে কতটা বিমর্ষ (মনখারাপ) থেকেছেন?',
    ),
    ItemModel(
      14,
      'গত কিছুদিন ধরে কোনো কঠিন সমস্যায় পড়লে তা এড়িয়ে যেতে চেয়েছেন কতটা?',
    ),
    ItemModel(
      15,
      'গত কিছুদিন ধরে  অসুখ-বিসুখে (সর্দি, পেটের অসুখ প্রভৃতি) কতটা ভুগেছেন?',
    ),
    ItemModel(
      16,
      'গত কিছুদিন ধরে যা কিছু ঘটেছে তা আপনার নিয়ন্ত্রণের বাইরে ভেবে আপনি কতটা রাগান্বিত হয়েছেন?',
    ),
    ItemModel(
      17,
      'গত কিছুদিন ধরে পিঠে, ঘাড়ে, কোমরে ব্যাথায় (ক্রনিক) কতটা ভুগেছেন?',
    ),
    ItemModel(
      18,
      'গত কিছুদিন ধরে সবসময় মনে মনে একই চিন্তায় কতটা আচ্ছন্ন থেকেছেন?',
    ),
    ItemModel(
      19,
      'গত কিছুদিন ধরে সর্দি/ উচ্চরক্তচাপ/ডায়াবেটিস বেড়েছে কতটা?',
    ),
    ItemModel(
      20,
      'গত কিছুদিন ধরে কতটা দুর্বলতাবোধ করেছেন?',
    ),
  ];
}
