# Adobe-AIR-scheme
自定义URL scheme 的好处就是你可以在其它程序中通过这个url打开应用程序。如Ａ应用程序注册了一个url scheme:myApp,那么就在mobile浏览器中就可以通过<href='myApp://'>打开你的应用程序Ａ。<br>
iOS与Android在这儿有点小区别，在iOS中如果系统注册了url scheme且安装了那个应用程序，通过上面那种网页的方式就可以启动应用程序，如果没有注册或没有安装那个应用程序，就没有任何效果（你注册的url scheme不能是http://xxx 这样的）。<br>
在Android系统中注册了url scheme且安装了那个应用程序，通过上面那种网页的方式就可以启动应用程序，如果没有注册或没有安装那个应用程序，就没有任何效果;<br>
如果注册了是http://xxx这样的，就会弹了一个对话框让你选，是打开网页还是程序。iOS中不能注册http://xxx这样的url scheme,而Android是可以的。<br>
在IOS或Android平台上，adobe air打包的移动应用中也能自定义URL scheme，在air应用描述文件中定义。\<br>
例，要注册一个自定URL scheme是my-scheme如下：

android平台：
---
```xml
<android>
    <manifestAdditions>
      <![CDATA[
            <manifest android:installLocation="auto">
                <application>
                 android:icon="@drawable/icon"	
                 <activity>
                     <intent-filter>
                           <action android:name="android.intent.action.MAIN"/>
                           <category android:name="android.intent.category.LAUNCHER"/>
                     </intent-filter>
                     <intent-filter>
                           <action android:name="android.intent.action.VIEW"/>
                           <category android:name="android.intent.category.BROWSABLE"/>
                           <category android:name="android.intent.category.DEFAULT"/>
                           <data android:scheme="my-scheme"/>
                     </intent-filter>
                 </activity>
              </application>
              <uses-permission android:name="android.permission.INTERNET"/>
            </manifest>
      ]]>
    </manifestAdditions>
</android>
```
IOS平台：
---
```xml
<iPhone>
    <InfoAdditions>
    <![CDATA[
        <key>UIDeviceFamily</key>
        <array>
            <string>1</string>
            <string>2</string>
        </array>

        <key>CFBundleURLTypes</key>
        <array>
            <dict>
                <key>CFBundleURLSchemes</key>
                <array>
                    <string>my-scheme</string>
                </array>
                <key>CFBundleURLName</key>
                <string>com.myapp</string>
            </dict>
        </array>]]>
    </InfoAdditions>
    <requestedDisplayResolution>high</requestedDisplayResolution>
</iPhone>
```
Adobe Air
---
也能从请求源传参数到要启动的应用，参数放在URL scheme的冒号后面，如：my-scheme:myparam，在air的应用中能监听外部的调用事件如：<br>
```as
NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
```
在事件中通过InvokeEvent类的arguments属性来取得传来的参数，它是一个数组，例如：<br>
```as
NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, onInvoke);
private function onInvoke(event:InvokeEvent):void
{
    trace("Arguments: " + event.arguments);
}
```
但是在AIR apps中用自定义URL schemes调用别的apps是不允许的，AIR的安全模型对于schemes在http:，sms：，tel: ，mailto:， file:  ，app:  ，app-storage: ，vipaccess:和connectpro:中的限制是很严格的。

Adobe Air 调用的代码
---
```as
navigateToURL(new URLRequest(scheme + "://" + args));
```
scheme就是你的app程序注册的值，args就是需要传过去的参数！
