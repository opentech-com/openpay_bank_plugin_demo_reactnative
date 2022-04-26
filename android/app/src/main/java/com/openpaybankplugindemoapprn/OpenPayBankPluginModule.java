package com.openpaybankplugindemoapprn;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.UiThreadUtil;
import com.opentech.othfclientsdk.OthfApp;
import com.opentech.othfclientsdk.ScaListener;

import java.util.HashMap;
import java.util.Map;

public class OpenPayBankPluginModule extends ReactContextBaseJavaModule {
	public OpenPayBankPluginModule(ReactApplicationContext context) {
		super(context);
	}

	@NonNull
	@Override
	public String getName() {
		return "OpenPayBankPlugin";
	}

	@ReactMethod
	public void launch(String target, ReadableMap options) {
		Activity currentActivity = getCurrentActivity();
		if (currentActivity != null) {
			Map<String, String> map;
			if (options != null) {
				map = new HashMap<>();
				HashMap<String, Object> hashMap = options.toHashMap();
				for (Map.Entry<String, Object> entry : hashMap.entrySet()) {
					map.put(entry.getKey(), String.valueOf(entry.getValue()));
				}
			} else {
				map = null;
			}
			UiThreadUtil.runOnUiThread(() -> {
				OthfApp.getInstance().launch(currentActivity, target, map);
			});
		}
	}

	@ReactMethod
	public void scaCompleted(int resultCode, String scaResult) {
		ScaListener scaListener = MainApplication.getInstance().getScaListener();
		if (scaListener != null) {
			scaListener.onComplete(resultCode, scaResult);
			MainApplication.getInstance().clearScaListener();

			Activity currentActivity = getCurrentActivity();
			if (currentActivity != null) {
				currentActivity.finish();
			}
		}
	}
}
