import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart' as dabase;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/helper/enum.dart';
import 'package:flutter_twitter_clone/model/feedModel.dart';
import 'package:flutter_twitter_clone/helper/utility.dart';
import 'package:flutter_twitter_clone/model/news_model.dart';
import 'package:flutter_twitter_clone/model/user.dart';
import 'package:flutter_twitter_clone/model/watchModel.dart';
import 'package:flutter_twitter_clone/state/appState.dart';
import 'package:path/path.dart' as Path;
// import 'authState.dart';

class FeedState extends AppState {
  bool isBusy = false;
  Map<String, List<FeedModel>> tweetReplyMap = {};
  FeedModel _tweetToReplyModel;
  FeedModel get tweetToReplyModel => _tweetToReplyModel;
  set setTweetToReply(FeedModel model) {
    _tweetToReplyModel = model;
  }

  List<FeedModel> _commentlist;

  List<FeedModel> _feedlist;
List<watchModel>  _watchlist=List<watchModel>();

  List<watchModel>  _mywatches=List<watchModel>();
  List<watchModel> _favouriteslist=List<watchModel>();
  List<NewsModel> _newslist;
  dabase.Query _feedQuery;
  List<FeedModel> _tweetDetailModelList;
  List<String> _userfollowingList;
  List<String> get followingList => _userfollowingList;

  List<FeedModel> get tweetDetailModel => _tweetDetailModelList;

  /// `feedlist` always [contain all tweets] fetched from firebase database
  List<FeedModel> get feedlist {
    if (_feedlist == null) {
      return null;
    } else {
      return List.from(_feedlist.reversed);
    }
  }
  List<watchModel> get watchlist {
    if (_watchlist == null) {
      return null;
    } else {
      return List.from(_watchlist);
    }
  }

  List<watchModel> get mywatches {
    if (_mywatches == null) {
      return null;
    } else {
      return List.from(_mywatches);
    }
  }
  List<watchModel> get favouriteslist {
    if (_favouriteslist == null) {
      return null;
    } else {
      return _favouriteslist;
    }
  }
  List<NewsModel> get newslist {
    if (_newslist == null) {
      return null;
    } else {
      return _newslist;
    }
  }

  /// contain tweet list for home page
  List<FeedModel> getTweetList(UserModel userModel) {
    if (userModel == null) {
      return null;
    }

    List<FeedModel> list;

    if (!isBusy && feedlist != null && feedlist.isNotEmpty) {
      list = feedlist.where((x) {
        /// If Tweet is a comment then no need to add it in tweet list
        if (x.parentkey != null &&
            x.childRetwetkey == null &&
            x.user.userId != userModel.userId) {
          return false;
        }

        /// Only include Tweets of logged-in user's and his following user's
        if (x.user.userId != userModel.userId || x.user.userId == userModel.userId && (x.type!="reply")) {
          return true;
        } else {
          return false;
        }
      }).toList();
      if (list.isEmpty) {
        list = null;
      }
    }
    return list;
  }
  List<FeedModel> getTweetListFriends(UserModel userModel) {
    if (userModel == null) {
      return null;
    }

    List<FeedModel> list;

    if (!isBusy && feedlist != null && feedlist.isNotEmpty) {
      list = feedlist.where((x) {
        /// If Tweet is a comment then no need to add it in tweet list
        if (x.parentkey != null &&
            x.childRetwetkey == null &&
            x.user.userId != userModel.userId) {
          return false;
        }
        /// Only include Tweets of logged-in user's and his following user's
        if (x.user.userId == userModel.userId&&x.type!="reply"||
            (userModel?.followingList != null &&
                userModel.followingList.contains(x.user.userId))) {
          return true;
        } else {
          return false;
        }
      }).toList();
      if (list.isEmpty) {
        list = null;
      }
    }
    return list;
  }
  List<watchModel> getWatches(UserModel userModel) {
    if (userModel == null) {
      return null;
    }

    List<watchModel> list;

    if (!isBusy && _watchlist != null && watchlist.isNotEmpty) {
      list = watchlist.where((x) {
        /// If Tweet is a comment then no need to add it in tweet list


        /// Only include Tweets of logged-in user's and his following user's
        if (x.user.userId != userModel.userId && x.type.toLowerCase().contains("add to sell")) {
          return true;
        } else {
          return false;
        }
      }).toList();
      if (list.isEmpty) {
        list = null;
      }
    }
    return list;
  }
  List<watchModel> getmyWatches(UserModel userModel) {
    if (userModel == null) {
      return null;
    }

    List<watchModel> list;

    if (!isBusy && _watchlist != null && watchlist.isNotEmpty) {
      list = watchlist.where((x) {
        /// If Tweet is a comment then no need to add it in tweet list


        /// Only include Tweets of logged-in user's and his following user's
        if (x.user.userId == userModel.userId ) {
          return true;
        } else {
          return false;
        }
      }).toList();
      if (list.isEmpty) {
        list = null;
      }
    }
    return list;
  }

  List<watchModel> getmyWatches_sales(UserModel userModel) {
    if (userModel == null) {
      return null;
    }

    List<watchModel> list;

    if (!isBusy && _watchlist != null && watchlist.isNotEmpty) {
      list = watchlist.where((x) {

        if (x.user.userId == userModel.userId && x.type.toLowerCase().contains("add to sell")) {
          return true;
        } else {
          return false;
        }
      }).toList();
      if (list.isEmpty) {
        list = null;
      }
    }
    return list;
  }
  /// set tweet for detail tweet page
  /// Setter call when tweet is tapped to view detail
  /// Add Tweet detail is added in _tweetDetailModelList
  /// It makes `Fwitter` to view nested Tweets
  set setFeedModel(FeedModel model) {
    if (_tweetDetailModelList == null) {
      _tweetDetailModelList = [];
    }

    /// [Skip if any duplicate tweet already present]
    if (_tweetDetailModelList.length >= 0) {
      _tweetDetailModelList.add(model);
      cprint(
          "Detail Tweet added. Total Tweet: ${_tweetDetailModelList.length}");
      notifyListeners();
    }
  }

  /// `remove` last Tweet from tweet detail page stack
  /// Function called when navigating back from a Tweet detail
  /// `_tweetDetailModelList` is map which contain lists of commment Tweet list
  /// After removing Tweet from Tweet detail Page stack its commnets tweet is also removed from `_tweetDetailModelList`
  void removeLastTweetDetail(String tweetKey) {
    if (_tweetDetailModelList != null && _tweetDetailModelList.length > 0) {
      // var index = _tweetDetailModelList.in
      FeedModel removeTweet =
          _tweetDetailModelList.lastWhere((x) => x.key == tweetKey);
      _tweetDetailModelList.remove(removeTweet);
      tweetReplyMap.removeWhere((key, value) => key == tweetKey);
      cprint(
          "Last Tweet removed from stack. Remaining Tweet: ${_tweetDetailModelList.length}");
    }
  }

  /// [clear all tweets] if any tweet present in tweet detail page or comment tweet
  void clearAllDetailAndReplyTweetStack() {
    if (_tweetDetailModelList != null) {
      _tweetDetailModelList.clear();
    }
    if (tweetReplyMap != null) {
      tweetReplyMap.clear();
    }
    cprint('Empty tweets from stack');
  }

  /// [Subscribe Tweets] firebase Database
  Future<bool> databaseInit() {
    try {
      if (_feedQuery == null) {
        _feedQuery = kDatabase.child("tweet");
        _feedQuery.onChildAdded.listen(_onTweetAdded);
        _feedQuery.onValue.listen(_onTweetChanged);
        _feedQuery.onChildRemoved.listen(_onTweetRemoved);
      }

      return Future.value(true);
    } catch (error) {
      cprint(error, errorIn: 'databaseInit');
      return Future.value(false);
    }
  }

  /// get [Tweet list] from firebase realtime database
  void getDataFromDatabase() {
    try {
      isBusy = true;
      _feedlist = null;
      notifyListeners();
      kDatabase.child('tweet').once().then((DataSnapshot snapshot) {
        _feedlist = List<FeedModel>();
        if (snapshot.value != null) {
          var map = snapshot.value;
          if (map != null) {
            map.forEach((key, value) {
              var model = FeedModel.fromJson(value);
              model.key = key;
              if (model.isValidTweet) {

                _feedlist.add(model);
              }
            });

            /// Sort Tweet by time
            /// It helps to display newest Tweet first.
            _feedlist.sort((x, y) => DateTime.parse(x.createdAt)
                .compareTo(DateTime.parse(y.createdAt)));
          }
        } else {
          _feedlist = null;
        }
        isBusy = false;
        notifyListeners();
      });
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getDataFromDatabase');
    }
  }
  void getwatchDataFromDatabase() {
    try {
      isBusy = true;
      _watchlist = null;
      notifyListeners();
      kDatabase.child('watches').once().then((DataSnapshot snapshot) {
        _watchlist = List<watchModel>();
        if (snapshot.value != null) {
          var map = snapshot.value;
          if (map != null) {
            map.forEach((key, value) {
              var model = watchModel.fromJson(value);
              model.key = key;
              _watchlist.add(model);


              /// Sort Tweet by time
              /// It helps to display newest Tweet first.
              _watchlist.sort((x, y) =>
                  DateTime.parse(x.createdAt)
                      .compareTo(DateTime.parse(y.createdAt)));

            });
        } else {
          _watchlist = null;
        }
        isBusy = false;
        notifyListeners();
      }});
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getwatchDataFromDatabase');
    }
  }
  void getFavouritesFromDatabase(String userId) {
    try {
      isBusy = true;
      _favouriteslist = null;
      notifyListeners();
      kDatabase.child('favourites').child(userId).once().then((DataSnapshot snapshot) {
        _favouriteslist = List<watchModel>();
        if (snapshot.value != null) {
          var map = snapshot.value;
          if (map != null) {
            map.forEach((key, value) {
              print(key);
              print(value);
              var model = watchModel.fromJson(value);
              model.key = key;
                _favouriteslist.add(model);

            });

            /// Sort Tweet by time
            /// It helps to display newest Tweet first.
            _favouriteslist.sort((x, y) => DateTime.parse(x.createdAt)
                .compareTo(DateTime.parse(y.createdAt)));
          }
        } else {
          _favouriteslist = List<watchModel>();
        }
        isBusy = false;
        notifyListeners();
      });
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getDataFromDatabase');
    }
  }
  void removeFromFavourites(String userId,String favId,watchModel feed){
    try{
      isBusy = true;
      kDatabase.child('favourites').child(userId).child(favId).remove();
      _favouriteslist.removeAt(
          _favouriteslist.indexWhere((element) => element.key==feed.key));
      notifyListeners();
      isBusy = false;

    }catch(error){

      isBusy = false;
      cprint(error, errorIn: 'errorRemovingFromDatabase');
    }

  }
  void getNewsFromDatabase() {
    try {
      isBusy = true;
      _newslist = null;
      notifyListeners();
      kDatabase.child('news').once().then((DataSnapshot snapshot) {
        _newslist = List<NewsModel>();
        if (snapshot.value != null) {
          var map = snapshot.value;
          if (map != null) {
            map.forEach((key, value) {
              var model = NewsModel.fromJson(value);
             // model.key = key;
             // if (model.isValidTweet) {
                _newslist.add(model);
            //  }
            });

            /// Sort Tweet by time
            /// It helps to display newest Tweet first.
            _newslist.sort((x, y) => DateTime.parse(x.createdAt)
                .compareTo(DateTime.parse(y.createdAt)));
          }
        } else {
          _newslist = null;
        }
        isBusy = false;
        notifyListeners();
      });
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getNewsFromDatabase');
    }
  }
  /// get [Tweet Detail] from firebase realtime kDatabase
  /// If model is null then fetch tweet from firebase
  /// [getpostDetailFromDatabase] is used to set prepare Tweetr to display Tweet detail
  /// After getting tweet detail fetch tweet coments from firebase
  void getpostDetailFromDatabase(String postID, {FeedModel model}) async {
    try {
      FeedModel _tweetDetail;
      if (model != null) {
        // set tweet data from tweet list data.
        // No need to fetch tweet from firebase db if data already present in tweet list
        _tweetDetail = model;
        setFeedModel = _tweetDetail;
        postID = model.key;
      } else {
        // Fetch tweet data from firebase
        kDatabase
            .child('tweet')
            .child(postID)
            .once()
            .then((DataSnapshot snapshot) {
          if (snapshot.value != null) {
            var map = snapshot.value;
            _tweetDetail = FeedModel.fromJson(map);
            _tweetDetail.key = snapshot.key;
            setFeedModel = _tweetDetail;
          }
        });
      }

      if (_tweetDetail != null) {
        // Fetch comment tweets
        _commentlist = List<FeedModel>();
        // Check if parent tweet has reply tweets or not
        if (_tweetDetail.replyTweetKeyList != null &&
            _tweetDetail.replyTweetKeyList.length > 0) {
          _tweetDetail.replyTweetKeyList.forEach((x) {
            if (x == null) {
              return;
            }
            kDatabase
                .child('tweet')
                .child(x)
                .once()
                .then((DataSnapshot snapshot) {
              if (snapshot.value != null) {
                var commentmodel = FeedModel.fromJson(snapshot.value);
                var key = snapshot.key;
                commentmodel.key = key;

                /// add comment tweet to list if tweet is not present in [comment tweet ]list
                /// To reduce duplicacy
                if (!_commentlist.any((x) => x.key == key)) {
                  _commentlist.add(commentmodel);
                }
              } else {}
              if (x == _tweetDetail.replyTweetKeyList.last) {
                /// Sort comment by time
                /// It helps to display newest Tweet first.
                _commentlist.sort((x, y) => DateTime.parse(y.createdAt)
                    .compareTo(DateTime.parse(x.createdAt)));
                tweetReplyMap.putIfAbsent(postID, () => _commentlist);
                notifyListeners();
              }
            });
          });
        } else {
          tweetReplyMap.putIfAbsent(postID, () => _commentlist);
          notifyListeners();
        }
      }
    } catch (error) {
      cprint(error, errorIn: 'getpostDetailFromDatabase');
    }
  }

  /// Fetch `Retweet` model from firebase realtime kDatabase.
  /// Retweet itself  is a type of `Tweet`
  Future<FeedModel> fetchTweet(String postID) async {
    FeedModel _tweetDetail;

    /// If tweet is availabe in feedlist then no need to fetch it from firebase
    if (feedlist.any((x) => x.key == postID)) {
      _tweetDetail = feedlist.firstWhere((x) => x.key == postID);
    }

    /// If tweet is not available in feedlist then need to fetch it from firebase
    else {
      cprint("Fetched from DB: " + postID);
      var model = await kDatabase.child('tweet').child(postID).once().then(
        (DataSnapshot snapshot) {
          if (snapshot.value != null) {
            var map = snapshot.value;
            _tweetDetail = FeedModel.fromJson(map);
            _tweetDetail.key = snapshot.key;
            print(_tweetDetail.description);
          }
        },
      );
      if (model != null) {
        _tweetDetail = model;
      } else {
        cprint("Fetched null value from  DB");
      }
    }
    return _tweetDetail;
  }

  /// create [New Tweet]
  createTweet(FeedModel model) {
    ///  Create tweet in [Firebase kDatabase]
    isBusy = true;
    notifyListeners();
    try {
      kDatabase.child('tweet').push().set(model.toJson());
    } catch (error) {
      cprint(error, errorIn: 'createTweet');
    }
    isBusy = false;
    notifyListeners();
  }
  createWatch(watchModel model) {
    ///  Create tweet in [Firebase kDatabase]
    isBusy = true;
    notifyListeners();
    String key=DateTime.now().millisecondsSinceEpoch.toString();
    model.key=key;
    try {
      kDatabase.child('watches').child(key).set(model.toJson());
      _watchlist.add(model);

notifyListeners();
    } catch (error) {
      cprint(error, errorIn: 'createWatch');
    }
    isBusy = false;
    notifyListeners();
  }
  createFavourite(watchModel feed,String userId){
    isBusy = true;
    notifyListeners();
    try {
      // String favId=DateTime.now().millisecondsSinceEpoch.toString();
      // feed.key=favId;
      kDatabase.child('favourites').child(userId).child(feed.key).set(feed.toJson());
      _favouriteslist.add(feed);

    } catch (error) {
      cprint(error, errorIn: 'createFavourite');
    }
    isBusy = false;
    notifyListeners();

  }

  ///  It will create tweet in [Firebase kDatabase] just like other normal tweet.
  ///  update retweet count for retweet model
  createReTweet(FeedModel model) {
    try {
      createTweet(model);
      _tweetToReplyModel.retweetCount += 1;
      updateTweet(_tweetToReplyModel);
    } catch (error) {
      cprint(error, errorIn: 'createReTweet');
    }
  }

  /// [Delete tweet] in Firebase kDatabase
  /// Remove Tweet if present in home page Tweet list
  /// Remove Tweet if present in Tweet detail page or in comment
  deleteTweet(String tweetId, TweetType type, {String parentkey}) {
    try {
      /// Delete tweet if it is in nested tweet detail page
      kDatabase.child('tweet').child(tweetId).remove().then((_) {
        if (type == TweetType.Detail &&
            _tweetDetailModelList != null &&
            _tweetDetailModelList.length > 0) {
          // var deletedTweet =
          //     _tweetDetailModelList.firstWhere((x) => x.key == tweetId);
          _tweetDetailModelList.remove(_tweetDetailModelList);
          if (_tweetDetailModelList.length == 0) {
            _tweetDetailModelList = null;
          }

          cprint('Tweet deleted from nested tweet detail page tweet');
        }
      });
    } catch (error) {
      cprint(error, errorIn: 'deleteTweet');
    }
  }
  deleteWatch(watchModel model) {
    try {
      /// Delete tweet if it is in nested tweet detail page
      kDatabase.child('watches').child(model.key).remove().then((_) {
        if(_watchlist.contains(model)) {
          _watchlist.remove(model);
        }
        if(_mywatches.contains(model)) {
          _mywatches.remove(model);
        }
          cprint('watch deleted');
       notifyListeners();
      });
    } catch (error) {
      cprint(error, errorIn: 'deleteWatch');
    }
  }
  /// upload [file] to firebase storage and return its  path url
  Future<String> uploadFile(File file) async {
    try {
      isBusy = true;
      notifyListeners();
      var storageReference = FirebaseStorage.instance
          .ref()
          .child("tweetImage")
          .child(Path.basename(file.path));
      await storageReference.putFile(file);

      var url = await storageReference.getDownloadURL();
      if (url != null) {
        return url;
      }
      return null;
    } catch (error) {
      cprint(error, errorIn: 'uploadFile');
      return null;
    }
  }
  Future<String> uploadwatchFile(File file) async {
    try {
      isBusy = true;
      notifyListeners();
      var storageReference = FirebaseStorage.instance
          .ref()
          .child("watches")
          .child(Path.basename(file.path));
      await storageReference.putFile(file);

      var url = await storageReference.getDownloadURL();
      if (url != null) {
        return url;
      }
      return null;
    } catch (error) {
      cprint(error, errorIn: 'uploadFileWatch');
      return null;
    }
  }

  /// [Delete file] from firebase storage
  Future<void> deleteFile(String url, String baseUrl) async {
    try {
      var filePath = url.split(".com/o/")[1];
      filePath = filePath.replaceAll(new RegExp(r'%2F'), '/');
      filePath = filePath.replaceAll(new RegExp(r'(\?alt).*'), '');
      //  filePath = filePath.replaceAll('tweetImage/', '');
      cprint('[Path]' + filePath);
      var storageReference = FirebaseStorage.instance.ref();
      await storageReference.child(filePath).delete().catchError((val) {
        cprint('[Error]' + val);
      }).then((_) {
        cprint('[Sucess] Image deleted');
      });
    } catch (error) {
      cprint(error, errorIn: 'deleteFile');
    }
  }

  /// [update] tweet
  updateTweet(FeedModel model) async {
    await kDatabase.child('tweet').child(model.key).set(model.toJson());
  }
  updateWatch(watchModel model,watchModel oldmodel) async {

    await kDatabase.child('watches').child(model.key).set(model.toJson());

    notifyListeners();
    getwatchDataFromDatabase();

  }
  /// Add/Remove like on a Tweet
  /// [postId] is tweet id, [userId] is user's id who like/unlike Tweet
  addLikeToTweet(FeedModel tweet, String userId) {
    try {
      if (tweet.likeList != null &&
          tweet.likeList.length > 0 &&
          tweet.likeList.any((id) => id == userId)) {
        // If user wants to undo/remove his like on tweet
        tweet.likeList.removeWhere((id) => id == userId);
        tweet.likeCount -= 1;
      } else {
        // If user like Tweet
        if (tweet.likeList == null) {
          tweet.likeList = [];
        }
        tweet.likeList.add(userId);
        tweet.likeCount += 1;
      }
      // update likelist of a tweet
      kDatabase
          .child('tweet')
          .child(tweet.key)
          .child('likeList')
          .set(tweet.likeList);

      // Sends notification to user who created tweet
      // UserModel owner can see notification on notification page
      kDatabase.child('notification').child(tweet.userId).child(tweet.key).set({
        'type': tweet.likeList.length == 0
            ? null
            : NotificationType.Like.toString(),
        'updatedAt': tweet.likeList.length == 0
            ? null
            : DateTime.now().toUtc().toString(),
      });
    } catch (error) {
      cprint(error, errorIn: 'addLikeToTweet');
    }
  }

  /// Add [new comment tweet] to any tweet
  /// Comment is a Tweet itself
  addcommentToPost(FeedModel replyTweet) {
    try {
      isBusy = true;
      notifyListeners();
      if (_tweetToReplyModel != null) {
        FeedModel tweet =
            _feedlist.firstWhere((x) => x.key == _tweetToReplyModel.key);
        var json = replyTweet.toJson();
        kDatabase.child('tweet').push().set(json).then((value) {
          tweet.replyTweetKeyList.add(_feedlist.last.key);
          updateTweet(tweet);
        });
      }
    } catch (error) {
      cprint(error, errorIn: 'addcommentToPost');
    }
    isBusy = false;
    notifyListeners();
  }

  /// Trigger when any tweet changes or update
  /// When any tweet changes it update it in UI
  /// No matter if Tweet is in home page or in detail page or in comment section.
  _onTweetChanged(Event event) {
    var model = FeedModel.fromJson(event.snapshot.value);
    model.key = event.snapshot.key;
    if (_feedlist.any((x) => x.key == model.key)) {
      var oldEntry = _feedlist.lastWhere((entry) {
        return entry.key == event.snapshot.key;
      });
      _feedlist[_feedlist.indexOf(oldEntry)] = model;
    }

    if (_tweetDetailModelList != null && _tweetDetailModelList.length > 0) {
      if (_tweetDetailModelList.any((x) => x.key == model.key)) {
        var oldEntry = _tweetDetailModelList.lastWhere((entry) {
          return entry.key == event.snapshot.key;
        });
        _tweetDetailModelList[_tweetDetailModelList.indexOf(oldEntry)] = model;
      }
      if (tweetReplyMap != null && tweetReplyMap.length > 0) {
        if (true) {
          var list = tweetReplyMap[model.parentkey];
          //  var list = tweetReplyMap.values.firstWhere((x) => x.any((y) => y.key == model.key));
          if (list != null && list.length > 0) {
            var index =
                list.indexOf(list.firstWhere((x) => x.key == model.key));
            list[index] = model;
          } else {
            list = [];
            list.add(model);
          }
        }
      }
    }
    if (event.snapshot != null) {
      cprint('Tweet updated');
      isBusy = false;
      notifyListeners();
    }
  }

  /// Trigger when new tweet added
  /// It will add new Tweet in home page list.
  /// IF Tweet is comment it will be added in comment section too.
  _onTweetAdded(Event event) {
    FeedModel tweet = FeedModel.fromJson(event.snapshot.value);
    tweet.key = event.snapshot.key;

    /// Check if Tweet is a comment
    _onCommentAdded(tweet);
    tweet.key = event.snapshot.key;
    if (_feedlist == null) {
      _feedlist = List<FeedModel>();
    }
    if ((_feedlist.length == 0 || _feedlist.any((x) => x.key != tweet.key)) &&
        tweet.isValidTweet) {
      _feedlist.add(tweet);
      cprint('Tweet Added');
    }
    isBusy = false;
    notifyListeners();
  }

  /// Trigger when comment tweet added
  /// Check if Tweet is a comment
  /// If Yes it will add tweet in comment list.
  /// add [new tweet] comment to comment list
  _onCommentAdded(FeedModel tweet) {
    if (tweet.childRetwetkey != null) {
      /// if Tweet is a type of retweet then it can not be a comment.
      return;
    }
    if (tweetReplyMap != null && tweetReplyMap.length > 0) {
      if (tweetReplyMap[tweet.parentkey] != null) {
        tweetReplyMap[tweet.parentkey].add(tweet);
      } else {
        tweetReplyMap[tweet.parentkey] = [tweet];
      }
      cprint('Comment Added');
    }
    isBusy = false;
    notifyListeners();
  }

  /// Trigger when Tweet `Deleted`
  /// It removed Tweet from home page list, Tweet detail page list and from comment section if present
  _onTweetRemoved(Event event) async {
    FeedModel tweet = FeedModel.fromJson(event.snapshot.value);
    tweet.key = event.snapshot.key;
    var tweetId = tweet.key;
    var parentkey = tweet.parentkey;

    ///  Delete tweet in [Home Page]
    try {
      FeedModel deletedTweet;
      if (_feedlist.any((x) => x.key == tweetId)) {
        /// Delete tweet if it is in home page tweet.
        deletedTweet = _feedlist.firstWhere((x) => x.key == tweetId);
        _feedlist.remove(deletedTweet);

        if (deletedTweet.parentkey != null &&
            _feedlist.isNotEmpty &&
            _feedlist.any((x) => x.key == deletedTweet.parentkey)) {
          // Decrease parent Tweet comment count and update
          var parentModel =
              _feedlist.firstWhere((x) => x.key == deletedTweet.parentkey);
          parentModel.replyTweetKeyList.remove(deletedTweet.key);
          parentModel.commentCount = parentModel.replyTweetKeyList.length;
          updateTweet(parentModel);
        }
        if (_feedlist.length == 0) {
          _feedlist = null;
        }
        cprint('Tweet deleted from home page tweet list');
      }

      /// [Delete tweet] if it is in nested tweet detail comment section page
      if (parentkey != null &&
          parentkey.isNotEmpty &&
          tweetReplyMap != null &&
          tweetReplyMap.length > 0 &&
          tweetReplyMap.keys.any((x) => x == parentkey)) {
        // (type == TweetType.Reply || tweetReplyMap.length > 1) &&
        deletedTweet =
            tweetReplyMap[parentkey].firstWhere((x) => x.key == tweetId);
        tweetReplyMap[parentkey].remove(deletedTweet);
        if (tweetReplyMap[parentkey].length == 0) {
          tweetReplyMap[parentkey] = null;
        }

        if (_tweetDetailModelList != null &&
            _tweetDetailModelList.isNotEmpty &&
            _tweetDetailModelList.any((x) => x.key == parentkey)) {
          var parentModel =
              _tweetDetailModelList.firstWhere((x) => x.key == parentkey);
          parentModel.replyTweetKeyList.remove(deletedTweet.key);
          parentModel.commentCount = parentModel.replyTweetKeyList.length;
          cprint('Parent tweet comment count updated on child tweet removal');
          updateTweet(parentModel);
        }

        cprint('Tweet deleted from nested tweet detail comment section');
      }

      /// Delete tweet image from firebase storage if exist.
      if (deletedTweet.imagePath != null && deletedTweet.imagePath.length > 0) {
        deleteFile(deletedTweet.imagePath, 'tweetImage');
      }

      /// If a retweet is deleted then retweetCount of original tweet should be decrease by 1.
      if (deletedTweet.childRetwetkey != null) {
        await fetchTweet(deletedTweet.childRetwetkey).then((retweetModel) {
          if (retweetModel == null) {
            return;
          }
          if (retweetModel.retweetCount > 0) {
            retweetModel.retweetCount -= 1;
          }
          updateTweet(retweetModel);
        });
      }

      /// Delete notification related to deleted Tweet.
      if (deletedTweet.likeCount > 0) {
        kDatabase
            .child('notification')
            .child(tweet.userId)
            .child(tweet.key)
            .remove();
      }
      notifyListeners();
    } catch (error) {
      cprint(error, errorIn: '_onTweetRemoved');
    }
  }
}
