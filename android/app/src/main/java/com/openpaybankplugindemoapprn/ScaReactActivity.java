package com.openpaybankplugindemoapprn;

import android.os.Bundle;

import androidx.annotation.Nullable;

import com.facebook.react.ReactActivity;
import com.facebook.react.ReactActivityDelegate;
import com.opentech.othfclientsdk.ScaListener;

public class ScaReactActivity extends ReactActivity {
	public static final String SCA_PAYLOAD_EXTRA = "scaPayload";

	@Override
	protected String getMainComponentName() {
		// The string here (e.g. "MyReactNativeApp") has to match
		// the string in AppRegistry.registerComponent() in index.js
		return "Sca";
	}

	@Override
	protected void onDestroy() {
		super.onDestroy();

		// If the scaListener was not cleared when the SCA activity is being destroyed, it means that the user
		// has pressed the native back, so notify that the SCA was canceled and clear the scaListener.
		ScaListener scaListener = MainApplication.getInstance().getScaListener();
		if (scaListener != null) {
			scaListener.onComplete(ScaListener.RESULT_CANCELED, null);
			MainApplication.getInstance().clearScaListener();
		}
	}

	@Override
	protected ReactActivityDelegate createReactActivityDelegate() {
		return new ScaReactActivityDelegate(this, getMainComponentName());
	}

	class ScaReactActivityDelegate extends ReactActivityDelegate {
		ScaReactActivityDelegate(ReactActivity activity, String mainComponentName) {
			super(activity, mainComponentName);
		}

		@Nullable
		@Override
		protected Bundle getLaunchOptions() {
			Bundle initialProperties = new Bundle();
			initialProperties.putString(SCA_PAYLOAD_EXTRA, getIntent().getStringExtra(SCA_PAYLOAD_EXTRA));
			return initialProperties;
		}
	}
}
