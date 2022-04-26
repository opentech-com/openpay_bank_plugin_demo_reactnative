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

/* As defined in the OpenPay Bank Plugin documentation */
const SCA_RESULT_SUCCESS = 0
const SCA_RESULT_GENERIC_ERROR = -1
const SCA_RESULT_CANCELED = -2

const Sca = (props: { scaPayload: String }) => {
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
        Demo Hosting App{"\n"}
        SCA Solution
      </Text>

      <Text style={[styles.body, { marginTop: 32, flex: 1 }]}>
        This Panel simulates the SCA solution of the hosting app that is used to authorize the request made by the OpenPay Plug-in.{"\n"}{"\n"}
        The pending request can be authorized or denied.
      </Text>

      <TouchableOpacity
        style={[styles.buttonBg, { marginBottom: 32 }]}
        onPress={() => {
          let scaPayload = props.scaPayload
          let scaResult = "JWT" //TODO this JWT must be computed/retrieved by the Hosting app using the provided scaPayload
          OpenPayBankPlugin.scaCompleted(SCA_RESULT_SUCCESS, scaResult)
        }}>
        <Text style={styles.buttonText}>
          SIMULATE AUTHORIZATION
        </Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={[styles.buttonBg, { marginBottom: 32 }]}
        onPress={() => {
          OpenPayBankPlugin.scaCompleted(SCA_RESULT_GENERIC_ERROR, null)
        }}>
        <Text style={styles.buttonText}>
          SIMULATE DENIAL
        </Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={[styles.buttonBg, { backgroundColor: 'transparent' , marginBottom: 24}]}
        onPress={() => {
          OpenPayBankPlugin.scaCompleted(SCA_RESULT_CANCELED, null)
        }}>
        <Text style={[styles.buttonText, { color: 'white' }]}>
          CANCEL
        </Text>
      </TouchableOpacity>

    </View>
  );
};

export default Sca;
