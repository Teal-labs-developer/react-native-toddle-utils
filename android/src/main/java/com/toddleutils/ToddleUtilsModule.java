package com.toddleutils;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import android.content.Context;
import android.media.AudioManager;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Nullable;

public class ToddleUtilsModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public ToddleUtilsModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "ToddleUtils";
    }

    @ReactMethod
    public void sampleMethod(String stringArgument, int numberArgument, Callback callback) {
        // TODO: Implement some actually useful functionality
        callback.invoke("Received numberArgument: " + numberArgument + " stringArgument: " + stringArgument);
    }

    @ReactMethod
    public void isTablet(Callback callback) {
        boolean tabletSize = reactContext.getResources().getBoolean(R.bool.isTablet) ||
                reactContext.getPackageManager().hasSystemFeature("org.chromium.arc.device_management");

        callback.invoke(tabletSize);
    }

    @ReactMethod
    public void isCallConnected(Callback callback) {
        AudioManager manager = (AudioManager)reactContext.getSystemService(Context.AUDIO_SERVICE);
        String result = "disconnected";
        int mode = manager.getMode();
        if(mode == AudioManager.MODE_IN_CALL || mode == AudioManager.MODE_IN_COMMUNICATION) {
            result = "connected";
        }

        callback.invoke(result);
    }

    @Nullable
    @Override
    public Map<String, Object> getConstants() {
        final Map<String, Object> constants = new HashMap<>();
        constants.put("isTablet", reactContext.getResources().getBoolean(R.bool.isTablet) ||
                reactContext.getPackageManager().hasSystemFeature("org.chromium.arc.device_management"));
        constants.put("isChromeBook", reactContext.getPackageManager().hasSystemFeature("org.chromium.arc.device_management"));
        return constants;
    }
}
