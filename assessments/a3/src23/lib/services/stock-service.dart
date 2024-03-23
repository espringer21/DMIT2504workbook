// ignore_for_file: avoid_print, unused_local_variable, file_names

import 'dart:async';
import '../services/network.dart';


const apiToken = 'OIXL1J56KKKHZADZ';

class StockService {
  Future getCompanyInfo(String symbol) async {
    print("getting company info for $symbol");
    var urlUsingOneString = Uri.parse(
        'https://www.alphavantage.co/query?function=OVERVIEW&symbol=$symbol&apikey=$apiToken');

    Uri url = Uri(
        scheme: 'https',
        host: 'www.alphavantage.co',
        path: '/query',
        query: 'function=OVERVIEW&symbol=$symbol&apikey=$apiToken');
    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    return data;
  }

  Future getQuote(String symbol) async {
    //TODO: Complete this method.
    Uri url = Uri(
        scheme: 'https',
        host: 'www.alphavantage.co',
        path: '/query',
        query: 'function=GLOBAL_QUOTE&symbol=$symbol&apikey=$apiToken');

    print('url: $url');
    NetworkService networkService = NetworkService(url);
    var data = await networkService.getData();
    return data;
  }
}