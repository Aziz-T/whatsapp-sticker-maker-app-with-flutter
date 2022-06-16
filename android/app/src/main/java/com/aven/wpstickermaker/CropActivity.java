package com.aven.wpstickermaker;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.util.DisplayMetrics;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.Toast;
public class CropActivity extends AppCompatActivity {
    private LinearLayout line1;
    private Button cut;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crop);
        cut =findViewById(R.id.doneButton);
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
        cut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent();
                intent.putExtra("crop", true);
                setResult(RESULT_OK, intent);
                finish();
            }
        });

    }

}