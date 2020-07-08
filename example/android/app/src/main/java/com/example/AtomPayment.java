package com.example;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import java.util.Map;
import java.util.HashMap;

import android.app.Activity;
import android.content.Intent;

import com.facebook.react.bridge.ReadableMap;
import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;
import com.atom.mpsdklibrary.PayActivity;

import org.json.JSONException;
import org.json.JSONObject;

import static android.app.Activity.RESULT_OK;


public class AtomPayment extends ReactContextBaseJavaModule implements ActivityEventListener {
    private static ReactApplicationContext reactContext;

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
        Intent newPayIntent = new Intent(reactContext, PayActivity.class);
//            newPayIntent.putExtra("merchantId", (String) details.getString("merchantId"));
//// txnscamt Fixed. Must be 0 
//            newPayIntent.putExtra("txnscamt",(String) details.getString("txnscamt"));
//            newPayIntent.putExtra("loginid",(String) details.getString("loginid"));
//            newPayIntent.putExtra("password",(String) details.getString("password"));
//            newPayIntent.putExtra("prodid",(String) details.getString("prodid"));
//// txncurr Fixed. Must be �INR�
//            newPayIntent.putExtra("txncurr",(String) details.getString("txncurr"));
//            newPayIntent.putExtra("clientcode",(String) encodeBase64((String) details.getString("clientcode")));
//            newPayIntent.putExtra("custacc",(String) details.getString("custacc"));
//            newPayIntent.putExtra("channelid",(String) details.getString("channelid"));
//// amt  Should be 2 decimal number i.e 1.00 
//            newPayIntent.putExtra("amt",(String) details.getString("merchantId"));
//            newPayIntent.putExtra("txnid",(String) details.getString("amt"));
////Date Should be in same format 
//            newPayIntent.putExtra("date",(String) details.getString("date"));
//            newPayIntent.putExtra("signature_request",(String) details.getString("signatureRequest"));
//            newPayIntent.putExtra("signature_response",(String) details.getString("signatureResponse"));
//            newPayIntent.putExtra("discriminator",(String) details.getString("discriminator"));
//            newPayIntent.putExtra("ru",(String) details.getString("ru"));
//            newPayIntent.putExtra("isLive", details.getBoolean("isLive"));
//            //Optinal Parameters //Only for Name n
//        newPayIntent.putExtra("customerName", details.getString("customerName"));
////Only for Email ID
//            newPayIntent.putExtra("customerEmailID",(String) details.getString("customerEmailID"));
////Only for Mobile Number 
//            newPayIntent.putExtra("customerMobileNo",(String) details.getString("customerMobileNo"));
////Only for Address
//            newPayIntent.putExtra("billingAddress",(String) details.getString("billingAddress"));
//// Can pass any data 
//            newPayIntent.putExtra("optionalUdf9",(String) details.getString("optionalUdf9"));
// Pass data in XML format, only for Multi product newPayIntent.putExtra("mprod", mprod);


      newPayIntent.putExtra("merchantId", "197");
// txnscamt Fixed. Must be 0 
newPayIntent.putExtra("txnscamt", "0");
newPayIntent.putExtra("loginid","197" );
        newPayIntent.putExtra("password", "Test@123");
        newPayIntent.putExtra("prodid", "NSE");
// txncurr Fixed. Must be �INR�
        newPayIntent.putExtra("txncurr", "INR");
        newPayIntent.putExtra("clientcode", encodeBase64 ("007") );
        newPayIntent.putExtra("custacc","100000036600" );
        newPayIntent.putExtra("channelid", "INT");
// amt  Should be 2 decimal number i.e 1.00 newPayIntent.putExtra("amt","10.0" );
        newPayIntent.putExtra("txnid", "013");
//Date Should be in same format 
        newPayIntent.putExtra("date", "01/10/2019 18:31:00");
        newPayIntent.putExtra("signature_request","KEY123657234" );
        newPayIntent.putExtra("signature_response","KEYRESP123657234" );
        newPayIntent.putExtra("discriminator","All");
        newPayIntent.putExtra("isLive",false);
        //Optinal Parameters //Only for Name 
        newPayIntent.putExtra("customerName", "LMN PQR");
//Only for Email ID
        newPayIntent.putExtra("customerEmailID", "Test@gmail.com");
//Only for Mobile Number 
newPayIntent.putExtra("customerMobileNo","8087911057" );
//Only for Address
        newPayIntent.putExtra("billingAddress", "Pune");
// Can pass any data 
newPayIntent.putExtra("optionalUdf9", "OPTIONAL DATA 2");
// Pass data in XML format, only for Multi product newPayIntent.putExtra("mprod", mprod);
       // startActivityForResult(newPayIntent,1);
        reactContext.startActivityForResult(newPayIntent,1, null);

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
                if(resKey!=null && resValue!=null)
                {
                    for(int i=0; i<resKey.length; i++)
                        System.out.println("  "+i+" resKey : "+resKey[i]+" resValue : "+resValue[i]);
                }

                //Toast.makeText(this, message, Toast.LENGTH_LONG).show();
                System.out.println("RECEIVED BACK--->" + message);
            }
        }
    }

    @Override
    public void onNewIntent(Intent intent) {

    }

}
