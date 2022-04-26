package com.openpaybankplugindemoapprn;

import android.app.Application;
import android.content.Context;
import android.content.Intent;

import androidx.fragment.app.FragmentActivity;

import com.facebook.react.PackageList;
import com.facebook.react.ReactApplication;
import com.facebook.react.ReactInstanceManager;
import com.facebook.react.ReactNativeHost;
import com.facebook.react.ReactPackage;
import com.facebook.soloader.SoLoader;
import com.opentech.openpay.openpaybankplugin.demoapp.BuildConfig;
import com.opentech.othfclientsdk.OthfApp;
import com.opentech.othfclientsdk.ScaListener;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.annotation.Nullable;

public class MainApplication extends Application implements ReactApplication {

	private static MainApplication instance;

	private ScaListener scaListener;

	private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
		@Override
		public boolean getUseDeveloperSupport() {
			return BuildConfig.DEBUG;
		}

		@Override
		protected List<ReactPackage> getPackages() {
			List<ReactPackage> packages = new PackageList(this).getPackages();
			packages.add(new OpenPayBankPluginPackage());
			return packages;
		}

		@Override
		protected String getJSMainModuleName() {
			return "index";
		}
	};

	@Override
	public ReactNativeHost getReactNativeHost() {
		return mReactNativeHost;
	}

	@Override
	public void onCreate() {
		super.onCreate();

		instance = this;

		SoLoader.init(this, /* native exopackage */ false);
		initializeFlipper(this, getReactNativeHost().getReactInstanceManager());

		String othfFile = "openpaybankplugin-demoapp-dev-android.opbp";
		OthfApp.init(this, new OthfApp(othfFile) {
			@Override
			public void onScaRequested(FragmentActivity openpayManagedActivity, String scaPayload, ScaListener scaListener) {
				MainApplication.this.scaListener = scaListener;

				Intent intent = new Intent(openpayManagedActivity, ScaReactActivity.class);
				intent.putExtra(ScaReactActivity.SCA_PAYLOAD_EXTRA, scaPayload);
				openpayManagedActivity.startActivity(intent);
			}
		});
	}

	public static MainApplication getInstance() {
		return instance;
	}

	@Nullable
	public ScaListener getScaListener() {
		return scaListener;
	}

	public void clearScaListener() {
		scaListener = null;
	}

	/**
	 * Loads Flipper in React Native templates. Call this in the onCreate method with something like
	 * initializeFlipper(this, getReactNativeHost().getReactInstanceManager());
	 *
	 * @param context
	 * @param reactInstanceManager
	 */
	private static void initializeFlipper(Context context, ReactInstanceManager reactInstanceManager) {
		if (BuildConfig.DEBUG) {
			try {
                /*
                 We use reflection here to pick up the class that initializes Flipper,
                since Flipper library is not available in release mode
                */
				Class<?> aClass = Class.forName("com.openpaybankplugindemoapprn.ReactNativeFlipper");
				aClass.getMethod("initializeFlipper", Context.class, ReactInstanceManager.class).invoke(null, context, reactInstanceManager);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (NoSuchMethodException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			} catch (InvocationTargetException e) {
				e.printStackTrace();
			}
		}
	}
}
