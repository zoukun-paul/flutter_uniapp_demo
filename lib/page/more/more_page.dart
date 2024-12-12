

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uniapp_demo/common/widget/divide.dart';
import 'package:flutter_uniapp_demo/plug/uni_app.dart';

class MorePage extends StatefulWidget {
   MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  // String uniAppDownloadUrl = "https://native-res.dcloud.net.cn/unimp-sdk/__UNI__7AEA00D.wgt";
  // String uniAppId = "__UNI__B278F03";
  // String uniAppId = "__UNI__EF86C8F";
  // String uniAppId = "__UNI__01E2F90";
  String uniAppId = "__UNI__EF86C8F";

  String password = "789456123";

  String? pagePath="pages/user/user";

  double process = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>FocusScope.of(context).requestFocus(FocusNode()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SafeArea(child: SizedBox()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: TextField(
                    onChanged: (e)=>uniAppId=e,
                    controller: TextEditingController(text: uniAppId),
                    decoration: const InputDecoration(
                      labelText:"uniAppDownloadUrl",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  child: TextField(
                    onChanged: (e)=>password=e,
                    controller: TextEditingController(text: password),
                    decoration: const InputDecoration(
                      labelText:"password",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                const SizedBox(height: 6,),
                SizedBox(
                  child: TextField(
                    onChanged: (e)=>pagePath=e,
                    controller: TextEditingController(text: pagePath),
                    decoration: const InputDecoration(
                      labelText:"pagePath",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                FilledButton(onPressed: () async {
                  var downloadAppFile = await UniAPP.downloadApp(uniAppId, progress: (int count, int total){
                    setState(() {
                      process = count/total;
                    });
                  });
                  if(downloadAppFile!=null){
                    UniAPP.openRemoteUniApp(uniAppId, downloadAppFile, password: password, pagePath: pagePath);
                  }else{
                    // 下载失败
                  }
                }, child: const Text("open2")),
                LinearProgressIndicator(
                  value: process,
                  backgroundColor: Colors.greenAccent,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            divider(bgColor: Colors.red, horizontal: true),
            const SizedBox(height: 10,),
            TextButton(onPressed: ()=>UniAPP.openLocalUniApp("__UNI__3BC70CE"), child: const Text("__UNI__3BC70CE")),
            TextButton(onPressed: ()=>UniAPP.openLocalUniApp("__UNI__F87B0CE"), child: const Text("__UNI__F87B0CE")),
            TextButton(onPressed: ()=>UniAPP.openLocalUniApp("__UNI__B61D13B"), child: const Text("__UNI__B61D13B")),
            Expanded(child: Container(color: Colors.transparent,))
          ],
        ),
      ),
    );
  }
}
