package com.aven.wpstickermaker;

import androidx.appcompat.app.AppCompatActivity;
import android.util.DisplayMetrics;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.Toast;
public class CropActivity extends AppCompatActivity {
    private LinearLayout line1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crop);
        byte[] val = getIntent().getByteArrayExtra("val");
        int widthOfscreen = 0;
        int heightOfScreen = 0;

        DisplayMetrics dm = new DisplayMetrics();
        try {
            getWindowManager().getDefaultDisplay().getMetrics(dm);
        } catch (Exception ex) {
        }
        widthOfscreen = dm.widthPixels;
        heightOfScreen = dm.heightPixels;


        line1 = findViewById(R.id.line);
        line1.addView(new SomeView(CropActivity.this,val, line1, widthOfscreen,heightOfScreen));
    }

}