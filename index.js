/**
 * @format
 */

import { AppRegistry } from 'react-native';
import App from './App';
import Sca from './Sca';
import { name as appName } from './app.json';

AppRegistry.registerComponent(appName, () => App);
AppRegistry.registerComponent("Sca", () => Sca);
