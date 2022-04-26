import React from 'react';
import {
  StyleSheet,
  NativeModules,
  SafeAreaView,
  ScrollView,
  StatusBar,
  Text,
  View,
  TouchableOpacity
} from 'react-native';

const { OpenPayBankPlugin } = NativeModules;

const App = () => {
  const styles = StyleSheet.create({
    container: {
      backgroundColor: "#4a93cd",
      padding: 24,
      flex: 1,
    },
    title: {
      color: 'white',
      fontSize: 30,
      fontWeight: 'bold',
    },
    body: {
      color: 'white',
      fontSize: 20,
    },
    buttonBg: {
      backgroundColor: 'white',
      borderRadius: 12,
    },
    buttonText: {
      textAlign: 'center',
      margin: 12,
      fontSize: 16,
      color: "#4a93cd",
    },
  });

  return (
    <View style={styles.container}>
      <Text style={[styles.title, { marginTop: 32 }]}>
        Welcome to Demo Hosting App
      </Text>

      <Text style={[styles.body, { flex: 1, marginTop: 32 }]}>
        The Demo Hosting app is an example application for the integration of the OpenPay Plugin.{"\n"}{"\n"}
        This screen is part of the Demo Hosting App, please use the button below to start the OpenPay Plug-in.
      </Text>

      <TouchableOpacity
        style={[styles.buttonBg, { marginBottom: 32 }]}
        onPress={() => {
          OpenPayBankPlugin.launch("", {})
        }}>
        <Text style={styles.buttonText}>
          START OPENPAY PLUG-IN
        </Text>
      </TouchableOpacity>

    </View>
  );
};


export default App;
