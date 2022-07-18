package com.aven.wpstickermaker;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.util.Log;

import androidx.annotation.NonNull;


import java.io.ByteArrayOutputStream;
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
                            if(call.method.equals("resize")){
                                Map<String,byte[]> map= call.arguments();
                                byte[] bytes = map.get("data");
                                Log.d("GAGAGA", String.valueOf(bytes));
                                result.success(resizeImage(bytes, 512,512));
                            }
                        }
                );
    }



    void goCropPage(byte[] val){
        Intent i = new Intent(MainActivity.this, CropActivity.class);
        i.putExtra("val",val);
        startActivityForResult(i, 1);
    }

    byte[] resizeImage(byte[] val, int newWidth ,int newHeight){
        Bitmap bitmap =  BitmapFactory.decodeByteArray(val, 0,val.length);
        float scale = Math.min((float) newWidth / bitmap.getWidth(), (float) newHeight / bitmap.getHeight());
        float scaledWidth = scale * bitmap.getWidth();
        float scaledHeight = scale * bitmap.getHeight();

        Matrix matrix = new Matrix();
        matrix.postScale(scale, scale);
        matrix.postTranslate(
                (newWidth - scaledWidth) / 2f,
                (newHeight - scaledHeight) / 2f
        );

        Bitmap outputBitmap = Bitmap.createBitmap(newWidth, newHeight, bitmap.getConfig());
        outputBitmap.eraseColor(Color.TRANSPARENT);

        Canvas canvas = new Canvas(outputBitmap);
        canvas.drawBitmap(
                bitmap,
                matrix,
                null);
        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        outputBitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
        byte[] byteArray = stream.toByteArray();
        return byteArray;
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
