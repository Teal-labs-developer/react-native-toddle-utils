# react-native-toddle-utils

## Getting started

`$ npm install react-native-toddle-utils --save`

### Mostly automatic installation

`$ react-native link react-native-toddle-utils`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-toddle-utils` and add `ToddleUtils.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libToddleUtils.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.reactlibrary.ToddleUtilsPackage;` to the imports at the top of the file
  - Add `new ToddleUtilsPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-toddle-utils'
  	project(':react-native-toddle-utils').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-toddle-utils/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-toddle-utils')
  	```


## Usage
```javascript
import ToddleUtils from 'react-native-toddle-utils';

// TODO: What to do with the module?
ToddleUtils;
```
