package com.aven.wpstickermaker;

import androidx.appcompat.app.AppCompatActivity;
import android.util.DisplayMetrics;
import android.os.Bundle;
import android.widget.Toast;
public class CropActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crop);
    }
    @Override
    protected void onResume() {
        super.onResume();
        int widthOfscreen = 0;
        int heightOfScreen = 0;

        DisplayMetrics dm = new DisplayMetrics();
        try {
            getWindowManager().getDefaultDisplay().getMetrics(dm);
        } catch (Exception ex) {
        }
        widthOfscreen = dm.widthPixels;
        heightOfScreen = dm.heightPixels;
        Toast.makeText(CropActivity.this, widthOfscreen + "", Toast.LENGTH_SHORT).show();
        byte[] val = getIntent().getByteArrayExtra("val");
        setContentView(new SomeView(CropActivity.this, val,widthOfscreen,heightOfScreen));
    }
}