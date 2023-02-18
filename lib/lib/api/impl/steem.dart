import 'package:telsavideo/api/post.dart';
import 'package:telsavideo/api/relationship.dart';
import 'package:telsavideo/api/reply.dart';
import 'package:telsavideo/api/steem.dart';
import 'package:telsavideo/api/tag.dart';
import 'package:telsavideo/api/user.dart';
import 'package:telsavideo/api/vote.dart';
import 'package:telsavideo/models/user.dart';
import 'package:telsavideo/services/requestor.dart';
import 'post.dart';
import 'relationship.dart';
import 'reply.dart';
import 'tag.dart';
import 'user.dart';
import 'vote.dart';

class SteemApiImpl implements SteemApi {
  SteemPostsApi? _posts;
  SteemRelationshipsApi? _relationships;
  SteemCommentsApi? _replies;
  SteemTagsApi? _tags;
  SteemUsersApi? _users;
  SteemVotesApi? _votes;

  @override
  final String accessToken;

  @override
  final User user;

  final Requestor requestor;

  SteemApiImpl(this.accessToken, this.user, this.requestor);

  @override
  SteemPostsApi get posts => _posts ??= new SteemPostsApiImpl(requestor);

  @override
  SteemRelationshipsApi get relationships =>
      _relationships ??= new SteemRelationshipsApiImpl(requestor);

  @override
  SteemCommentsApi get replies =>
      _replies ??= new SteemCommentsApiImpl(requestor);

  @override
  SteemTagsApi get tags => _tags ??= new SteemTagsApiImpl(requestor);

  @override
  SteemUsersApi get users => _users ??= new SteemUsersApiImpl(requestor);

  @override
  SteemVotesApi get votes => _votes ??= new SteemVotesApiImpl(requestor);
}
