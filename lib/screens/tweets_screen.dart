import 'dart:convert';
import 'dart:developer';

import 'package:deshgujarat/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:tweet_ui/embedded_tweet_view.dart';
import 'package:tweet_ui/models/api/tweet.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:tweet_webview/tweet_webview.dart';
import 'package:twitter_api/twitter_api.dart';
import 'package:url_launcher/url_launcher.dart';
import '../helpers/helpers.dart';
import '../helpers/deco_localizations.dart';
import '../widgets/deco_appbar.dart';
import '../widgets/deco_news_drawer.dart';

class TweetsScreen extends StatefulWidget {
  @override
  _TweetsScreenState createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen> {
  final _twitterOauth = new twitterApi(
      consumerKey: 'BR7nnV5i0Xfhk0JQVf8YcdHE4',
      consumerSecret: 'GMmc0vjav3C8c1lQql3gHWExTJGEavCjmRd6hICvcenPXiEOHI',
      token: '2841623869-jQvByLWnBkFMRm9MMg66gQZPmYfhqgiA8jEirtQ',
      tokenSecret: 'JCrx2auocVfNYARUE1DVxRO5KIe5rlLxXbZxvXzQtROWE');

  List<Map<String, dynamic>> tweets = [];

  @override
  void initState() {
    super.initState();
    fetchTweets();
  }

  Future<List<Map<String, dynamic>>> fetchTweets() async {
    var twitterResponse = await _twitterOauth.getTwitterRequest(
      // Http Method
      "GET",
      // Endpoint you are trying to reach
      "statuses/user_timeline.json",
      // The options for the request
      options: {
        "user_id": "19025957",
        "screen_name": "DeshGujarat",
        "count": "20",
        "trim_user": "true",
        "tweet_mode": "extended", // Used to prevent truncating tweets
      },
    );
    // Print off the response
    // print(twitterResponse.statusCode);
    // print(twitterResponse.body);
    return [...jsonDecode(twitterResponse.body)];
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: adPadding(context: context),
      child: Scaffold(
        appBar: DecoNewsAppBar(),
        drawer: DecoNewsDrawer(),
        body: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchTweets(),
            builder:
                (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text('No Tweets Available'),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      print(snapshot.data[index]);
                      return TweetWebView.tweetID(
                          snapshot.data[index]['id_str']);
                    },
                    itemCount: snapshot.data.length,
                  );
                }
              } else {
                return Loading();
              }
            }),
        bottomNavigationBar: SafeArea(
          child: Container(
            width: double.infinity,
            height: 55.0,
            margin: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 10.0),
            child: RaisedButton(
              onPressed: () async {
                const url = 'https://www.deshgujarat.com/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              padding: EdgeInsets.all(0),
              color: isDark ? Colors.white : Color(0xFF1B1E28),
              textColor: isDark ? Color(0xFF1B1E28) : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0)),
              child: Text('Contact Now'),
            ),
          ),
        ),
      ),
    );
  }

  var data = {
    "created_at": "Fri May 19 16:24:47 +0000 2017",
    "id": 865604154676432896,
    "id_str": "865604154676432896",
    "text":
        "So this is a Quoted Tweet of an 'original' Tweet that has a @Mention,  $Symbol, a #Hastag and four attached photos. https://t.co/FwuQVeNOHn",
    "truncated": false,
    "entities": {
      "hashtags": [
        {
          "text": "Hastag",
          "indices": [82, 89]
        }
      ],
      "symbols": [
        {
          "text": "Symbol",
          "indices": [71, 78]
        }
      ],
      "user_mentions": [
        {
          "screen_name": "Mention",
          "name": "Mention",
          "id": 435854974,
          "id_str": "435854974",
          "indices": [60, 68]
        }
      ],
      "urls": [
        {
          "url": "https://t.co/FwuQVeNOHn",
          "expanded_url":
              "https://twitter.com/FloodSocial/status/861627479294746624",
          "display_url": "twitter.com/FloodSocial/st…",
          "indices": [116, 139]
        }
      ]
    },
    "source":
        "<a href=\"http://twitter.com\" rel=\"nofollow\">Twitter Web Client</a>",
    "in_reply_to_status_id": null,
    "in_reply_to_status_id_str": null,
    "in_reply_to_user_id": null,
    "in_reply_to_user_id_str": null,
    "in_reply_to_screen_name": null,
    "user": {
      "id": 944480690,
      "id_str": "944480690",
      "name": "API demos",
      "screen_name": "FloodSocial",
      "location": "Boulder, CO",
      "description":
          "Exploring @TwitterDev, one demo or test at a time. \n🌍💧❄️🌧️☀️ \n@FloodSocial notification sign-up bot was the precursor to @SnowBotDev",
      "url": "https://t.co/rzmuONbWMR",
      "entities": {
        "url": {
          "urls": [
            {
              "url": "https://t.co/rzmuONbWMR",
              "expanded_url": "https://github.com/jimmoffitt/FloodSocial",
              "display_url": "github.com/jimmoffitt/Flo…",
              "indices": [0, 23]
            }
          ]
        },
        "description": {"urls": []}
      },
      "protected": false,
      "followers_count": 73,
      "friends_count": 19,
      "listed_count": 5,
      "created_at": "Mon Nov 12 19:59:55 +0000 2012",
      "favourites_count": 36,
      "utc_offset": null,
      "time_zone": null,
      "geo_enabled": true,
      "verified": false,
      "statuses_count": 187,
      "lang": null,
      "contributors_enabled": false,
      "is_translator": false,
      "is_translation_enabled": false,
      "profile_background_color": "000000",
      "profile_background_image_url":
          "http://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_image_url_https":
          "https://abs.twimg.com/images/themes/theme1/bg.png",
      "profile_background_tile": false,
      "profile_image_url":
          "http://pbs.twimg.com/profile_images/1162409582213226497/wHPWq9eI_normal.jpg",
      "profile_image_url_https":
          "https://pbs.twimg.com/profile_images/1162409582213226497/wHPWq9eI_normal.jpg",
      "profile_banner_url":
          "https://pbs.twimg.com/profile_banners/944480690/1412809012",
      "profile_link_color": "7FDBB6",
      "profile_sidebar_border_color": "000000",
      "profile_sidebar_fill_color": "000000",
      "profile_text_color": "000000",
      "profile_use_background_image": false,
      "has_extended_profile": false,
      "default_profile": false,
      "default_profile_image": false,
      "following": null,
      "follow_request_sent": null,
      "notifications": null,
      "translator_type": "none"
    },
    "geo": null,
    "coordinates": null,
    "place": null,
    "contributors": null,
    "is_quote_status": true,
    "quoted_status_id": 861627479294746624,
    "quoted_status_id_str": "861627479294746624",
    "quoted_status": {
      "created_at": "Fri Jul 26 19:00:05 +0000 2019",
      "id": 1154828755774390300,
      "id_str": "1154828755774390277",
      "full_text":
          "#FIFA20 Cover Stars revealed!\n⚽ Standard Edition: @hazardeden10\n⚽ Champions Edition: @VirgilvDijk\n⚽ Ultimate Edition: Coming Soon 👀\nPre Order -&gt; https://t.co/5SqUm1ES8Q https://t.co/nYF559icO4",
      "truncated": false,
      "display_text_range": [0, 171],
      "entities": {
        "hashtags": [
          {
            "text": "FIFA20",
            "indices": [0, 7]
          }
        ],
        "symbols": [],
        "user_mentions": [
          {
            "screen_name": "hazardeden10",
            "name": "Eden Hazard",
            "id": 366592246,
            "id_str": "366592246",
            "indices": [50, 63]
          },
          {
            "screen_name": "VirgilvDijk",
            "name": "Virgil van Dijk",
            "id": 395305090,
            "id_str": "395305090",
            "indices": [85, 97]
          }
        ],
        "urls": [
          {
            "url": "https://t.co/5SqUm1ES8Q",
            "expanded_url": "http://xbx.ms/yUCsbG",
            "display_url": "xbx.ms/yUCsbG",
            "indices": [148, 171]
          }
        ],
        "media": [
          {
            "id": 1154828739785740300,
            "id_str": "1154828739785740289",
            "indices": [172, 195],
            "media_url": "http://pbs.twimg.com/media/EAbGnstXUAEjkNS.jpg",
            "media_url_https":
                "https://pbs.twimg.com/media/EAbGnstXUAEjkNS.jpg",
            "url": "https://t.co/nYF559icO4",
            "display_url": "pic.twitter.com/nYF559icO4",
            "expanded_url":
                "https://twitter.com/Xbox/status/1154828755774390277/photo/1",
            "type": "photo",
            "sizes": {
              "thumb": {"w": 150, "h": 150, "resize": "crop"},
              "small": {"w": 539, "h": 680, "resize": "fit"},
              "medium": {"w": 952, "h": 1200, "resize": "fit"},
              "large": {"w": 1520, "h": 1916, "resize": "fit"}
            }
          }
        ]
      },
      "extended_entities": {
        "media": [
          {
            "id": 1154828739785740300,
            "id_str": "1154828739785740289",
            "indices": [172, 195],
            "media_url": "http://pbs.twimg.com/media/EAbGnstXUAEjkNS.jpg",
            "media_url_https":
                "https://pbs.twimg.com/media/EAbGnstXUAEjkNS.jpg",
            "url": "https://t.co/nYF559icO4",
            "display_url": "pic.twitter.com/nYF559icO4",
            "expanded_url":
                "https://twitter.com/Xbox/status/1154828755774390277/photo/1",
            "type": "photo",
            "sizes": {
              "thumb": {"w": 150, "h": 150, "resize": "crop"},
              "small": {"w": 539, "h": 680, "resize": "fit"},
              "medium": {"w": 952, "h": 1200, "resize": "fit"},
              "large": {"w": 1520, "h": 1916, "resize": "fit"}
            }
          },
          {
            "id": 1154828749600411600,
            "id_str": "1154828749600411649",
            "indices": [172, 195],
            "media_url": "http://pbs.twimg.com/media/EAbGoRRXUAEoLLE.jpg",
            "media_url_https":
                "https://pbs.twimg.com/media/EAbGoRRXUAEoLLE.jpg",
            "url": "https://t.co/nYF559icO4",
            "display_url": "pic.twitter.com/nYF559icO4",
            "expanded_url":
                "https://twitter.com/Xbox/status/1154828755774390277/photo/1",
            "type": "photo",
            "sizes": {
              "thumb": {"w": 150, "h": 150, "resize": "crop"},
              "medium": {"w": 952, "h": 1200, "resize": "fit"},
              "small": {"w": 539, "h": 680, "resize": "fit"},
              "large": {"w": 1520, "h": 1916, "resize": "fit"}
            }
          }
        ]
      },
      "source":
          "<a href=\"https://prod2.sprinklr.com\" rel=\"nofollow\">Sprinklr Publisher</a>",
      "in_reply_to_status_id": null,
      "in_reply_to_status_id_str": null,
      "in_reply_to_user_id": null,
      "in_reply_to_user_id_str": null,
      "in_reply_to_screen_name": null,
      "user": {
        "id": 24742040,
        "id_str": "24742040",
        "name": "Xbox",
        "screen_name": "Xbox",
        "location": "Redmond, WA",
        "description":
            "Xbox news + updates—we've got you covered. Because when everyone plays, we all win. \n\n👉Support👉: https://t.co/iF8ijavkE2",
        "url": "https://t.co/aigkgbMkRg",
        "entities": {
          "url": {
            "urls": [
              {
                "url": "https://t.co/aigkgbMkRg",
                "expanded_url": "http://Xbox.com",
                "display_url": "Xbox.com",
                "indices": [0, 23]
              }
            ]
          },
          "description": {
            "urls": [
              {
                "url": "https://t.co/iF8ijavkE2",
                "expanded_url": "http://xbx.lv/29ucmtj",
                "display_url": "xbx.lv/29ucmtj",
                "indices": [97, 120]
              }
            ]
          }
        },
        "protected": false,
        "followers_count": 13462473,
        "friends_count": 17022,
        "listed_count": 17436,
        "created_at": "Mon Mar 16 18:30:52 +0000 2009",
        "favourites_count": 3097,
        "utc_offset": null,
        "time_zone": null,
        "geo_enabled": false,
        "verified": true,
        "statuses_count": 249422,
        "lang": null,
        "contributors_enabled": false,
        "is_translator": false,
        "is_translation_enabled": false,
        "profile_background_color": "107C10",
        "profile_background_image_url":
            "http://abs.twimg.com/images/themes/theme14/bg.gif",
        "profile_background_image_url_https":
            "https://abs.twimg.com/images/themes/theme14/bg.gif",
        "profile_background_tile": true,
        "profile_image_url":
            "http://pbs.twimg.com/profile_images/1146101175529250816/uu1-VeT1_normal.png",
        "profile_image_url_https":
            "https://pbs.twimg.com/profile_images/1197940587774631936/qDPwiXBO_normal.jpg",
        "profile_banner_url":
            "https://pbs.twimg.com/profile_banners/24742040/1563813585",
        "profile_link_color": "107C10",
        "profile_sidebar_border_color": "000000",
        "profile_sidebar_fill_color": "EFEFEF",
        "profile_text_color": "333333",
        "profile_use_background_image": false,
        "has_extended_profile": false,
        "default_profile": false,
        "default_profile_image": false,
        "following": null,
        "follow_request_sent": null,
        "notifications": null,
        "translator_type": "none"
      },
      "geo": null,
      "coordinates": null,
      "place": null,
      "contributors": null,
      "is_quote_status": false,
      "retweet_count": 95,
      "favorite_count": 668,
      "favorited": false,
      "retweeted": false,
      "possibly_sensitive": false,
      "possibly_sensitive_appealable": false,
      "lang": "en"
    },
    "retweet_count": 1,
    "favorite_count": 4,
    "favorited": false,
    "retweeted": false,
    "possibly_sensitive": false,
    "possibly_sensitive_appealable": false,
    "lang": "en"
  };
}
