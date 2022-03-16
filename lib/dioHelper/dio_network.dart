import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_app/dioHelper/url.dart';

class DioHelper{

  static Dio dio;

  static inti(){

    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true
      ),
    );
  }

  static Future<Response> getData({
    @required String url,
    String lang = 'en',
    String token,
    dynamic query,
  })

  async{

    dio.options.headers = {

      'lang' : lang,
      'Authorization' :token,
      'Content-Type':'application/json'

    };

    return await dio.get(
      url,
      queryParameters: query,
    );

  }

  static Future<Response> postData({
    @required String url,
    @required Map<String,dynamic>data,
    Map<String,dynamic>query,

  }) async {

    dio.options.headers = {

      'Content-Type':'application/json',
      'Authorization': 'key=AAAAM-UDeYw:APA91bHlTfeYDPpiS8yJSe_jmQQB33z38nXOXwAvU0ROoUqEWsqPUpkXujcAkdALBTDoVqm0s2gGtexQVsLWwScjtXmDM6qIIFoNpdKIIvLL2u3VyCqITNAW8NyYhoLDgrTqvqLbQPFr',
    };

    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );

  }

  static Future<Response> updateData({
    @required String url,
    @required Map<String,dynamic>data,
    String lang = 'en',
    String token,
    Map<String,dynamic>query,

  }) async {

    dio.options.headers = {

      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };

    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );

  }

  static Future<Response> deleteData({
    @required String url,
    @required Map<String,dynamic>data,
    String lang = 'en',
    String token,
    Map<String,dynamic>query,

  }) async {

    dio.options.headers = {

      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token??'',
    };

    return await dio.delete(
      url,
      queryParameters: query,
      data: data,
    );

  }


}