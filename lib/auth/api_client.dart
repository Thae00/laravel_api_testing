import 'package:laravel_api/models/message.dart';
import 'package:laravel_api/models/post.dart';
import 'package:laravel_api/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8000/api/") //we don't have own hosting
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/user") //baseUrl/user
  Future<Message> register(@Body() User user);

  @POST("/login")
  Future<Message> login(@Body() User user);

  @GET("/posts")
  Stream<List<Post>> getAllPosts(@Header("Authorization") String authApi); //call with Auth Api 
}
