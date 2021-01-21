<h1>An Atlas map provided by Here</h1>

## Getting Started

### Clone the project:
* `git clone https://github.com/edsondiasalves/here_maps_atlas.git`
### Enter in the root directory: 
- `cd here_maps_atlas`
### Download the root dependencies:
* `flutter pub get`
### Download the here sdk ios framework manually:
>Since the [here sdk ios framework file](https://github.com/edsondiasalves/here_sdk/blob/main/ios/Frameworks/heresdk.framework/heresdk) uses git lfs to be hosted in github, you need to download it manually to the flutter dependency directory: `/Users/[YOUR-USER]/.pub-cache/git/here_sdk-[REFERENCE]/ios/Frameworks/heresdk.framework/`
### Enter in the example project:
* `cd example`
### Download the example dependencies:
* `flutter pub get`
### Set the credentials
#### For getting you API Key and secret sign up to the [Here Developer Portal](https://developer.here.com/#)
#### Ios:
> In the `ios/Runner/Info.plist` file change the highlighted values
```
<key>HERECredentials</key>
      <dict>
          <key>AccessKeyId</key>
          <string>[PUT YOUR KEY HERE]</string>
          <key>AccessKeySecret</key>
          <string>[PUT YOUR SECRET HERE]</string>
      </dict>
```

#### Android:
> In the `app/src/main/AndroidManifest.xml` file change the highlighted values

```
<application
        android:name="io.flutter.app.FlutterApplication"
        android:label="here_maps_atlas"
        android:icon="@mipmap/ic_launcher">

        <meta-data android:name="com.here.sdk.access_key_id" android:value="[PUT YOUR KEY KERE]"/>
        <meta-data android:name="com.here.sdk.access_key_secret" android:value="[PUT YOUR SECRET HERE]"/>

```
### Run the project:
* `flutter run lib/src/main.dart`
