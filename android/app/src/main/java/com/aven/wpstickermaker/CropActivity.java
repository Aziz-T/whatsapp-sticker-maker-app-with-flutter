package com.aven.wpstickermaker;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

public class CropActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crop);
    }
    @Override
    protected void onResume() {
        super.onResume();
        byte[] val = getIntent().getByteArrayExtra("val");
        setContentView(new SomeView(CropActivity.this, val));
    }
}