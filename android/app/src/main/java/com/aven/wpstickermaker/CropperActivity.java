package com.aven.wpstickermaker;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

public class CropperActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cropper);
    }

    @Override
    protected void onResume() {
        super.onResume();
        byte[] val = getIntent().getByteArrayExtra("val");
        setContentView(new SomeView(CropperActivity.this, val));
    }
}