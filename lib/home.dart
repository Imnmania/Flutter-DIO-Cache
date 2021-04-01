import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DioCacheManager _dioCacheManager;
  Options _cacheOptions;
  String _myData;

  @override
  void initState() {
    super.initState();
    // _getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dio Cache'),
      ),
      body: ListView(
        children: [
          FlatButton(
            child: Text('Get Data'),
            onPressed: () async {
              try {
                // Step 1
                _dioCacheManager = DioCacheManager(CacheConfig());
                // Step 2
                _cacheOptions = buildCacheOptions(
                  Duration(days: 1),
                  primaryKey: "jojo",
                  forceRefresh: true,
                );
                // Step 3
                Dio _dio = Dio();
                // Step 4
                _dio.interceptors.add(_dioCacheManager.interceptor);
                // Step 5
                Response response = await _dio.get(
                    "https://jsonplaceholder.typicode.com/users",
                    options: _cacheOptions);
                setState(() {
                  _myData = response.data.toString();
                });

                print(_myData);
              } catch (e) {
                print('NO INTERNET');
              }
            },
          ),
          FlatButton(
            child: Text("Delete Cache"),
            onPressed: () async {
              if (_dioCacheManager != null) {
                // bool res = await _dioCacheManager.deleteByPrimaryKey(
                //     "https://jsonplaceholder.typicode.com/users");
                bool res = await _dioCacheManager.clearAll();
                print(res);
              }
            },
          ),
          Text(_myData ?? "No Data"),
        ],
      ),
    );
  }

  // _getApiData() async {
  //   try {
  //     // Step 1
  //     _dioCacheManager = DioCacheManager(CacheConfig());
  //     // Step 2
  //     _cacheOptions = buildCacheOptions(
  //       Duration(days: 1),
  //       primaryKey: "jojo",
  //       // forceRefresh: true,
  //     );
  //     // Step 3
  //     Dio _dio = Dio();
  //     // Step 4
  //     _dio.interceptors.add(_dioCacheManager.interceptor);
  //     // Step 5
  //     Response response = await _dio.get(
  //         "https://jsonplaceholder.typicode.com/users",
  //         options: _cacheOptions);
  //     setState(() {
  //       _myData = response.data.toString();
  //     });

  //     print(_myData);
  //   } catch (e) {
  //     print('NO INTERNET');
  //   }
  // }
}
