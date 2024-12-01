

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_uniapp_demo/common/widget/divide.dart';

class MorePage extends StatelessWidget {
   MorePage({super.key});

  // String uniAppDownloadUrl = "https://native-res.dcloud.net.cn/unimp-sdk/__UNI__7AEA00D.wgt";
  String uniAppDownloadUrl = "http://58.87.88.132:5000/package/__UNI__B278F03.wgt";

  String password = "789456123";

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
                    onChanged: (e){
                      uniAppDownloadUrl=e;
                    },
                    controller: TextEditingController(text: uniAppDownloadUrl),
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
                    onChanged: (e){
                      password=e;
                    },
                    controller: TextEditingController(text: password),
                    decoration: const InputDecoration(
                      labelText:"password",
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                  ),
                ),
                FilledButton(onPressed: (){
                  const channel = MethodChannel('UniMP_mini_apps');
                  String appId =  uniAppDownloadUrl.substring(uniAppDownloadUrl.lastIndexOf("/")+1,uniAppDownloadUrl.lastIndexOf(".wgt"));
                  var param = {'AppID': appId, "remote":true, "downloadBaseUri":uniAppDownloadUrl, "password":password};
                  channel.invokeMethod("open",param);
                }, child: Text("open"))
              ],
            ),
            SizedBox(height: 10,),
            divider(bgColor: Colors.red, horizontal: true),
            SizedBox(height: 10,),
            TextButton(onPressed: () async {
              const channel = MethodChannel('UniMP_mini_apps');
              channel.invokeMethod("open",{'AppID': "__UNI__3BC70CE"});
            }, child: Text("local-uniAPP-1")),
            TextButton(onPressed: () async {
              const channel = MethodChannel('UniMP_mini_apps');
              channel.invokeMethod("open",{'AppID': "__UNI__F87B0CE"});
            }, child: Text("local-uniAPP-2")),
            Expanded(child: Container(color: Colors.transparent,))
          ],
        ),
      ),
    );
  }
}
