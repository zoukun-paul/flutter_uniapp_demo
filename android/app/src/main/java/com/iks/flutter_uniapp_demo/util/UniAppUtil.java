package com.iks.flutter_uniapp_demo.util;

import android.content.Context;
import android.util.Log;

import java.io.File;
import java.io.IOException;

public class UniAppUtil {
    private final static String TAG = "UniAppUtil";
    public static File uniAppSavePath(Context context){
        String path = context.getExternalCacheDir().getPath() + File.separator + "uni" + File.separator;
        File file = new File(path);
        if (!file.mkdirs()) {
            try {
                file.createNewFile();
            } catch (IOException e) {
                Log.d(TAG, "uniAppSavePath exception " + e.getMessage());
            }
        }
        return file;
    }

}
