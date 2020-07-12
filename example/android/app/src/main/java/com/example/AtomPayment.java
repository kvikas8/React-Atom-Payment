package com.example;

import android.app.Activity;
import android.content.Intent;

import com.atom.mpsdklibrary.PayActivity;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import java.util.Arrays;

import static android.app.Activity.RESULT_OK;


public class AtomPayment extends ReactContextBaseJavaModule implements ActivityEventListener {
    private static ReactApplicationContext reactContext;
    private Callback nativeCallback;

    @Override
    public String getName() {
        return "AtomPayment";
    }

    AtomPayment(ReactApplicationContext context) {
        super(context);
        reactContext = context;
        reactContext.addActivityEventListener(this);
    }

    public String encodeBase64(String encode) {
        String decode = null;
        try {
            decode = Base64.encode(encode.getBytes());
        } catch (Exception e) {
            System.out.println("Unable to decode : " + e);
        }
        return decode;
    }

    @ReactMethod
    public void goForAtomPayment(
            ReadableMap details,
            Callback callback) {
        nativeCallback = callback;
        Intent newPayIntent = new Intent(reactContext, PayActivity.class);
        newPayIntent.putExtra("merchantId", (String) details.getString("merchantId"));
// txnscamt Fixed. Must be 0 
        newPayIntent.putExtra("txnscamt",(String) details.getString("txnscamt"));
        newPayIntent.putExtra("loginid",(String) details.getString("loginid"));
        newPayIntent.putExtra("password",(String) details.getString("password"));
        newPayIntent.putExtra("prodid",(String) details.getString("prodid"));
// txncurr Fixed. Must be �INR�
        newPayIntent.putExtra("txncurr",(String) details.getString("txncurr"));
        newPayIntent.putExtra("clientcode",(String) encodeBase64((String) details.getString("clientcode")));
        newPayIntent.putExtra("custacc",(String) details.getString("custacc"));
        newPayIntent.putExtra("channelid",(String) details.getString("channelid"));
// amt  Should be 2 decimal number i.e 1.00 
        newPayIntent.putExtra("amt",(String) details.getString("amt"));
        newPayIntent.putExtra("txnid",(String) details.getString("txnid"));
//Date Should be in same format 
        newPayIntent.putExtra("date",(String) details.getString("date"));
        newPayIntent.putExtra("signature_request",(String) details.getString("signatureRequest"));
        newPayIntent.putExtra("signature_response",(String) details.getString("signatureResponse"));
        newPayIntent.putExtra("discriminator",(String) details.getString("discriminator"));
        newPayIntent.putExtra("ru",(String) details.getString("ru"));
        newPayIntent.putExtra("isLive", details.getBoolean("isLive"));
        //Optinal Parameters //Only for Name n
        newPayIntent.putExtra("customerName", details.getString("customerName"));
//Only for Email ID
        newPayIntent.putExtra("customerEmailID",(String) details.getString("customerEmailID"));
//Only for Mobile Number 
        newPayIntent.putExtra("customerMobileNo",(String) details.getString("customerMobileNo"));
//Only for Address
        newPayIntent.putExtra("billingAddress",(String) details.getString("billingAddress"));
// Can pass any data 
        newPayIntent.putExtra("optionalUdf9",(String) details.getString("optionalUdf9"));
// Pass data in XML format, only for Multi product newPayIntent.putExtra("mprod", mprod);
// Pass data in XML format, only for Multi product newPayIntent.putExtra("mprod", mprod);
        // startActivityForResult(newPayIntent,1);
        getCurrentActivity().startActivityForResult(newPayIntent,1, null);

    }

    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {
        // Here is your Activity result :)
        // check if the request code is same as what is passed here it is 1
        System.out.println("RESULTCODE--->" + resultCode);
        System.out.println("REQUESTCODE--->" + requestCode);
        System.out.println("RESULT_OK--->" + RESULT_OK);

        if (requestCode == 1)
        {
            System.out.println("---------INSIDE-------");
            if (data != null)
            {
                String message = data.getStringExtra("status");
                String[] resKey = data.getStringArrayExtra("responseKeyArray");
                String[] resValue = data.getStringArrayExtra("responseValueArray");

                //Toast.makeText(this, message, Toast.LENGTH_LONG).show();
                WritableMap resultData = new WritableNativeMap();
                resultData.putString("result", message);
                String joinedString = Arrays.toString(resValue);
                resultData.putString("response", joinedString);
                System.out.println("RECEIVED BACK--->" + message);
                nativeCallback.invoke(null, resultData);
            } else {
                nativeCallback.invoke("Error in Payment", null);
            }

        } else  {
            nativeCallback.invoke("Error in Payment", null);
        }
    }

    @Override
    public void onNewIntent(Intent intent) {

    }

}
