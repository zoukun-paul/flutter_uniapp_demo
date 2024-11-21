package com.iks.flutter_uniapp_demo;

import android.app.Activity;
import android.content.Context;
import android.content.res.Resources;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.LinearLayout;

public class AndroidActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        newView view = newView.buildView(AndroidActivity.this);
        setContentView(view);
        Resources res = getResources();
        Bitmap bmp = BitmapFactory.decodeResource(res, R.drawable.launch_background);
        BitmapDrawable bmp1 = new BitmapDrawable(bmp);
        view.imageView.setImageDrawable(bmp1);
    }

    static class newView extends LinearLayout {
        private ImageView imageView;
        public newView(Context c) {
            super(c);
            imageView = new ImageView(c);
            addView(imageView);
        }
        public static newView buildView(Context c) {
            return new newView(c);
        }

    }

}
