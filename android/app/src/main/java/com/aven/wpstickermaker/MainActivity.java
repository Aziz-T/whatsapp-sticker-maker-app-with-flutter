package com.aven.wpstickermaker;

import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "samples.flutter.dev/battery";
    MethodChannel.Result res;
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {

                            if(call.method.equals("goIntent")){
                                res = result;
                                Map<String,byte[]> map= call.arguments();
                                byte[] bytes = map.get("data");
                                Log.d("GAGAGA", String.valueOf(bytes));
                                goCropPage(bytes);
                            }
                        }
                );
    }



    void goCropPage(byte[] val){
        Intent i = new Intent(MainActivity.this, CropActivity.class);
        i.putExtra("val",val);
        startActivityForResult(i, 1);
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1) {
            if(resultCode == RESULT_OK) {
                boolean val = getIntent().getBooleanExtra("val",false);
                res.success(SomeView.croppedImageByteList);
            }
        }
    }
}
