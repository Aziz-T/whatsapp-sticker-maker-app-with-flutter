package com.aven.wpstickermaker;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.DashPathEffect;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.PorterDuff;
import android.graphics.PorterDuffXfermode;
import android.util.AttributeSet;
import android.util.Log;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.List;

public class SomeView extends View implements View.OnTouchListener {
    private Paint paint;
    public static List<Point> points;
    int DIST = 2;
    boolean flgPathDraw = true;

    Point mfirstpoint = null;
    boolean bfirstpoint = false;
    public static byte[] croppedImageByteList;
    byte[] bytes;
    Point mlastpoint = null;
    int width ;
    int height ;
    Bitmap bitmap ;
    Context mContext;
    LinearLayout line;

    public SomeView(Context c, byte[] val,  LinearLayout line1, int widthOfscreen , int heightOfScreen) {
        super(c);
        width = widthOfscreen;
        height = heightOfScreen;
        bytes = val ;
        mContext = c;
        setFocusable(true);
        setFocusableInTouchMode(true);
        line = line1;
        bitmap =  BitmapFactory.decodeByteArray(val, 0,val.length);
        bitmap = Bitmap.createScaledBitmap(bitmap, width, width, false);
        paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        paint.setStyle(Paint.Style.STROKE);
        paint.setPathEffect(new DashPathEffect(new float[] { 10, 20 }, 0));
        paint.setStrokeWidth(5);
        paint.setColor(Color.WHITE);
        this.setLayoutParams(new LinearLayout.LayoutParams(width, width));
        this.setOnTouchListener(this);
        points = new ArrayList<Point>();

        bfirstpoint = false;





    }

    public SomeView(Context context, AttributeSet attrs) {
        super(context, attrs);
        mContext = context;
        setFocusable(true);
        setFocusableInTouchMode(true);

        paint = new Paint(Paint.ANTI_ALIAS_FLAG);
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeWidth(2);
        paint.setColor(Color.WHITE);

        this.setOnTouchListener(this);
        points = new ArrayList<Point>();
        bfirstpoint = false;

    }

    public void onDraw(Canvas canvas) {
        canvas.drawBitmap(bitmap, 0, 0, null);

        Path path = new Path();
        boolean first = true;

        for (int i = 0; i < points.size(); i += 2) {
            Point point = points.get(i);
            if (first) {
                first = false;
                path.moveTo(point.x, point.y);
            } else if (i < points.size() - 1) {
                Point next = points.get(i + 1);
                path.quadTo(point.x, point.y, next.x, next.y);
            } else {
                mlastpoint = points.get(i);
                path.lineTo(point.x, point.y);
            }
        }
        canvas.drawPath(path, paint);
    }

    public boolean onTouch(View view, MotionEvent event) {
        // if(event.getAction() != MotionEvent.ACTION_DOWN)
        // return super.onTouchEvent(event);

        Point point = new Point();
        point.x = (int) event.getX();
        point.y = (int) event.getY();

        if (flgPathDraw) {

            if (bfirstpoint) {

                if (comparepoint(mfirstpoint, point)) {
                    // points.add(point);
                    points.add(mfirstpoint);
                    flgPathDraw = false;
                    showcropdialog();
                } else {
                    points.add(point);
                }
            } else {
                points.add(point);
            }

            if (!(bfirstpoint)) {

                mfirstpoint = point;
                bfirstpoint = true;
            }
        }

        invalidate();
        Log.e("Hi  ==>", "Size: " + point.x + " " + point.y);

        if (event.getAction() == MotionEvent.ACTION_UP) {

            mlastpoint = point;
            if (flgPathDraw) {
                if (points.size() > 12) {
                    if (!comparepoint(mfirstpoint, mlastpoint)) {
                        flgPathDraw = false;
                        points.add(mfirstpoint);
                        showcropdialog();
                    }
                }
            }
        }

        return true;
    }

    private boolean comparepoint(Point first, Point current) {
        int left_range_x = (int) (current.x - 3);
        int left_range_y = (int) (current.y - 3);

        int right_range_x = (int) (current.x + 3);
        int right_range_y = (int) (current.y + 3);

        if ((left_range_x < first.x && first.x < right_range_x)
                && (left_range_y < first.y && first.y < right_range_y)) {
            if (points.size() < 10) {
                return false;
            } else {
                return true;
            }
        } else {
            return false;
        }

    }

    public void fillinPartofPath() {
        Point point = new Point();
        point.x = points.get(0).x;
        point.y = points.get(0).y;

        points.add(point);
        invalidate();
    }

    public void resetView() {
        points.clear();
        paint.setColor(Color.WHITE);
        paint.setStyle(Paint.Style.STROKE);
        flgPathDraw = true;
        invalidate();
    }

    public void showcropdialog() {

        ImageView compositeImageView = new ImageView(mContext);


        Bitmap resultingImage = Bitmap.createBitmap(width,
                width, bitmap.getConfig());

        Canvas canvas = new Canvas(resultingImage);
        Paint paint = new Paint();
        paint.setAntiAlias(true);

        Path path = new Path();
        for (int i = 0; i < SomeView.points.size(); i++) {
            path.lineTo(SomeView.points.get(i).x, SomeView.points.get(i).y);
        }
        canvas.drawPath(path, paint);

        paint.setXfermode(new PorterDuffXfermode(PorterDuff.Mode.SRC_IN));



        canvas.drawBitmap(bitmap, 0, 0, paint);

        ByteArrayOutputStream stream = new ByteArrayOutputStream();
        resultingImage.compress(Bitmap.CompressFormat.PNG, 100, stream);
        byte[] byteArray = stream.toByteArray();

        compositeImageView.setMinimumHeight(400);
        compositeImageView.setImageBitmap(resultingImage);
        line.removeAllViews();
        line.setGravity(Gravity.CENTER);
        line.addView(compositeImageView);
        croppedImageByteList = byteArray;

//        Intent intent;
//        intent = new Intent(this.mContext, CropActivity.class);
//        intent.putExtra("crop", true);
//        mContext.startActivity(intent);

    }

//    public static String convert(Bitmap bitmap)
//    {
//        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
//        bitmap.compress(Bitmap.CompressFormat.PNG, 100, outputStream);
//
//        return Base64.encodeToString(outputStream.toByteArray(), Base64.DEFAULT);
//    }

    private void showcropdialogs() {
        DialogInterface.OnClickListener dialogClickListener = new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Intent intent;
                switch (which) {
                    case DialogInterface.BUTTON_POSITIVE:
                        // Yes button clicked
                        // bfirstpoint = false;
                        ByteArrayOutputStream stream = new ByteArrayOutputStream();
                        bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
                        byte[] byteArray = stream.toByteArray();
                        bitmap.recycle();

                        intent = new Intent(mContext, CropActivity.class);
                        intent.putExtra("crop", true);
                        mContext.startActivity(intent);
                        break;

                    case DialogInterface.BUTTON_NEGATIVE:
                        // No button clicked

                        intent = new Intent(mContext, CropActivity.class);
                        intent.putExtra("crop", false);
                        mContext.startActivity(intent);

                        bfirstpoint = false;
                        // resetView();

                        break;
                }
            }
        };

        AlertDialog.Builder builder = new AlertDialog.Builder(mContext);
        builder.setMessage("Do you Want to save Crop or Non-crop image?")
                .setPositiveButton("Crop", dialogClickListener)
                .setNegativeButton("Non-crop", dialogClickListener).show()
                .setCancelable(false);
    }
}






class Point {

    public float dy;
    public float dx;
    float x, y;

    @Override
    public String toString() {
        return x + ", " + y;
    }
}
