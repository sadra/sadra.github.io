---
layout: blog_post_rtl
title:  "فایربیس ۱: سرویس Firebase Cloud Messaging"
date: '2017-10-24'

tags:
- Google
- Firebase
- Android

categories:
- فایربیس
- آموزش

cover: /assets/img/post/2017-10-24/fcm-cover.png

author: Sadra
---

بنا بر قولی که در [پست قبلی](http://isapanah.com/2017/set-fire-into-the-problems-with-firebase) داده بودم، میخوام در یک مجموعه نوشته درباره پیاده سازی و استفاده از سرویس‌های مختلف فایربیس (تا جایی که این امکان برای ما در ایران وجود داشته باشه) صحبت کنم. شما می‌تونید پست‌های این بلاگ را، در رابطه با سرویس‌های فایربیس، از این [لینک موضوعی](http://isapanah.com/tag/firebase) مطالعه کنید.

ازونجایی که مطالب زیاد بود و همچنین دسته بندی‌ها تودرتو، در ادامه فهرستی از کل مطالب و تیترهای موجود در این پست رو لیست کردم. با کلیک روی هر تیتر به اون موضوع هدایت می‌شید.

## فهرست مطالب

*   [معرفی Firebase Cloud Messaging](#introduction)
*   [افتتاح حساب و ایجاد یک پروژه اندروید در فایربیس](#fcm-account)
*   [تنظیمات اولیه اپلیکیشن اندروید](#basic-app-settings-for-fcm)
*   [سرویس پوش‌ناتیفیکیشن با Node.js](#node-service)
    *   [آماده‌سازی سرویس Node.js](#prepare-node-service)
    *   [استفاده از سرویس Node.js](#using-nodejs)
        *   [Notification](#node-notification)
        *   [Data](#node-data)
        *   [Combined Message](#node-combined-message)
*   [آماده سازی اپلیکیشن برای دریافت ناتیفیکیشن](#prepare-app-for-fcm)
*   [دریافت ناتیفیکیشن](#receiving-notification)
    *   [ارسال و دریافت ناتیفیکیشن برای گروهی از کاربران](#send-and-receive-notification)
    *   [ارسال و دریافت ناتیفیکیشن بر اساس Topic یا موضوعی خاص](#user-topics)
    *   [ارسال پیام برای همه‌ی کاربران](#send-message-to-all)
    *   [دیگر تنظیمات ارسال پیام](#other-settings)
        *   [اولویت Priority](#other-settings-priority)
        *   [زمان اعتبار پیام timeToLive](#other-settings-time-to-alive)
        *   [کلید جایگزینی پیام collapse_key](#other-settings-collapse-key)
*   [نتیجه‌گیری](#conclusion)


<h2 id="introduction">معرفی Firebase Cloud Messaging</h2>

فایربیس کلاد مسیجینگ یا به اختصار FCM یکی از سرویس‌های کاربردی فایربیس هست که به شما کمک میکنه تا بتونین پیام‌هاتون رو در کمترین زمان و بدون هیچ هزینه‌ای به دست کاربرتون در پلتفرم‌های مختلفی مثل Android, iOS, WebApplication, C++, Unituy برسونید.پیام شما می‌تونه به یک کاربر، یا گروهی از کاربران، یا بر اساس یه تاپیک و موضوع ارسال بشه.
ایجاد یک سرویس و ارسال پیام به کاربران شما خیلی ساده‌ست. اول از همه با اضافه کردن SDK فایبربیس به اپلیکیشنتون، کاربرانتون رو در شبکه کلاد فایبربیس رجیستر می‌کنید. و بعد در سمت سرورتون یکسری کد می‌نویسید، تا توسط اون بتونید پیام‌هاتون رو به کاربر یا گروهی از کاربران ارسال کنید.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-13.png)

شما می‌تونید ده‌ها، هزاران، یا حتی میلیون‌ها پیام در روز بدون هزینه و با دقت ۹۵٪ در کمتر از ۲۵۰میلی‌ثانیه بدون توجه به پلتفرم کاربر به دستشون برسونید. به همین سادگی، به همین خوشمزگی.😍

<h2 id="fcm-account">افتتاح حساب و ایجاد یک پروژه اندروید در فایربیس</h2>

پس از ثبت‌نام و ورود به [کنسول فایربیس،](https://console.firebase.google.com/) می‌بینید که یک پروژه آماده و البته دمو به اسم **[Firebase Demo Project](https://console.firebase.google.com/project/fir-demo-project/overview)** وجود داره، این پروژه فقط درحالت View Only و تنها برای دیدن امکانات فایربیس ایجاد شده. برای ایجاد اولین پروژه فقط کافیه روی Add Project کلیک کنید.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-0.png)

در پنجره باز شده اسمی برای پروژه (FirebaseApp) می‌نویسیم. بهتره Country/region روی همون UnitedStates باقی بمونه. توجه کنید که برای استفاده از Firebase محدودیت وجود داره و فقط می‌تونید ۳ پروژه ایجاد کنید! برای ساختن بیشتر از ۳ پروژه یا باید با یه حساب کاربری دیگه وارد بشید یا اینکه هزینه پرداخت کرده و ظرفیت کنسولتون رو افزایش بدید.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-1.png)

پروژه اولیه ایجاد شده. حالا وقتی وارد پنل می‌شید ۳تا گزینه دارید، ما از بین گزینه‌های پایین، Android App رو انتخاب می‌کنیم.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-2.png)

خب، در این مرحله باید مشخصات اپ رو ثبت کنیم. اول از همه **Package Address** اپ رو وارد می‌کنیم، و بعد در **App nickname** همونطور که از اسمش مشخصه یه اسم برای پروژمون می‌نویسیم. در بخش **SHA-1** میتونید امضای امنیتی اپتون رو وارد کنید، درصورتی که خواستید امنیت بیشتری لحاظ کنید که فقط روی همون پکیج با همون امضا کار کنه (ما که خالی میزاریم 😇). و بعدش هم که **Register App** رو می‌زنیم.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-3.png)

خب پروژه ایجاد شده، فقط کافیه فایل **google-service.json** رو دانلود کنیم و سپس روی Continue کلیک کنیم.

![fcm-4](/assets/img/post/2017-10-24/fcm-4.png)

حالا اون فایل JSON رو، مثل تصویر زیر، به پروژه اپلیکیشنمون (که امیدوارم از قبل درسته کرده بوده باشید) در مسیر `../Project/app` کپی می‌کنیم.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-5.png)

خب پروژمون ایجاد شده و کار تمومه.با کلیک روی پروژه اپلیکیشن ایجاد شده در کنسول فایربیس، می‌تونیم وارد پنل بشیم و کارهای که لازمه داریم رو انجام بدیم.

<h2 id="basic-app-settings-for-fcm">تنظیمات اولیه اپلیکیشن اندروید</h2>

قبل شروع همه‌چیز این رو بگم با مراجعه به [این ریپوی گیتهاب](https://github.com/sadra/FirebaseApp)، می‌تونید به نمونه اپلیکیشنی که برای همین منظور ایجاد کردم دسترسی داشته باشید.

اول از همه در فایل build.gradle مربوط به **project**، خطوط زیر رو اصلاح و اضافه میکنیم.

```groovy
// Project-level build.gradle (<project>/build.gradle):
buildscript {
  dependencies {
    // Add this line
    classpath 'com.google.gms:google-services:3.1.0'
  }
}
```

و در فایل build.gradle مربوط به **app.module** خطوط زیر رو در انتهای محتویات قبلی اضافه می‌کنیم:

```groovy
// App-level build.gradle (<project>/<app-module>/build.gradle):
...
// Add to the bottom of the file
apply plugin: 'com.google.gms.google-services'
```

و همچنین لازمه که لایبرری های مربوط به فایربیس رو هم به **dependencies** اضافه کنیم.

```groovy
// Project-level build.gradle (<project>/build.gradle):
dependencies {
  ...
  // Add this line
  compile "com.google.firebase:firebase-core:11.+"
  compile "com.google.firebase:firebase-messaging:11.+"
}
```

و در نهایت باید گریدل رو Sync کنیم. بعد از اینکه Gradle کتابخونه‌های مد نظرش رو دریافت و آماده استفاده شد میریم سراغ مرحله بعد.

خب، حالا اول از همه در مسیر اپلیکیشن یک دایرکتوری به اسم `PushNotification` ایجاد کرده، و در اون یک کلاس به اسم `FCMInstanceIDService`، که از `FirebaseInstanceIdService` ارث‌بری میکنه، ایجاد میکنیم. این کلاس وظیفه ساخت توکن و بروزرسانی اون درصورتی که اکسپایر شده رو بر عهده داره.

وقتی که کاربر یک توکن دریافت کرده یا توکن قبلی وی باطل و توکن جدید صادر شد، تابع `onTokenRefresh` در این کلاس صدا فراخونی میشه. ([مشاهده کلاس در گیتهاب](https://github.com/sadra/FirebaseApp/blob/master/app/src/main/java/com/isapanah/firebase/PushNotification/FCMInstanceIDService.java))

```java
public class FCMInstanceIDService extends FirebaseInstanceIdService {
    @Override
    public void onTokenRefresh() {
        super.onTokenRefresh();
        String refreshedToken = FirebaseInstanceId.getInstance().getToken();
	...
    }
}
```

خب بعد از اینکه کاربر توکن دریافت کرد میتونه از سرویس FCM استفاده کنه، پس ما هم باید یه کلاس ایجاد کنیم که پیام‌های دریافتی FCM رو مدیریت کنه. برای این منظور کلاسی به نام `FCMService` ایجاد کرده و اون رو  **extend** می‌کنیم از `FirebaseMessagingService`.

در این کلاس ما می‌تونیم با استفاده از تابع `onMessageReceived` در هنگام دریافت پیامی از FCM اون رو مدیریت کرده و هر بلایی که میخواییم سرش بیاریم 😈 ([مشاهده کلاس در گیتهاب](https://github.com/sadra/FirebaseApp/blob/master/app/src/main/java/com/isapanah/firebase/PushNotification/FCMService.java))

```java
public class FCMService extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        Log.e("FCM", "New notification from: " + remoteMessage.getFrom());
    }
}
```

بعد از اینکه دو کلاس **FCMInstanceIDService** و **FCMService** رو آماده کردیم، وقتشه که اونهارو در `AndroidManifest` هم به عنوان سرویس رویداد‌های `INSTANCE_ID_EVENT` و `MESSAGING_EVENT` معرفی کنیم.

```xml
<!-- ADD this lines before </application> close tag -->
<service
    android:name=".PushNotification.FCMInstanceIDService">
    <intent-filter>
        <action android:name="com.google.firebase.INSTANCE_ID_EVENT"/>
    </intent-filter>
</service>

<service
    android:name=".PushNotification.FCMService">
    <intent-filter>
        <action android:name="com.google.firebase.MESSAGING_EVENT"/>
    </intent-filter>
</service>
```

خب در همینجا هم میتونیم آیکون ناتیفیکیشن و رنگ پیش‌زمینه اون رو در منیفست مشخص کنیم. ([مشاهده AndroidManifest در گیتهاب](https://github.com/sadra/FirebaseApp/blob/master/app/src/main/AndroidManifest.xml))

```xml
<!-- ADD this lines before </application> close tag -->
<meta-data
    android:name="com.google.firebase.messaging.default_notification_icon"
    android:resource="@mipmap/ic_launcher" />

<meta-data
    android:name="com.google.firebase.messaging.default_notification_color"
    android:resource="@color/colorPrimary" />
```

البته این دو متا دیتا فقط برای ورژن های اندروید 21 یعنی Lolipop به بالا کار میکنه!

<h2 id="node-service">سرویس پوش‌ناتیفیکیشن با Node.js</h2>

خب قبل از اینکه بریم سراغ تنظیمات بعدی و آماده‌سازی اپلیکیشن، لازمه که یه سرویسی هم فراهم کنیم برای اینکه بتونیم با استفاده از API گوگل برای تلفن‌های همراهی که اپلیکیشن مارو نصب دارند پیام ارسال کنیم.

<h3 id="prepare-node-service">آماده سازی سرویس Node.js</h3>

من برای اینکه شما درگیر کارهای مربوط به تهیه این سرویس نشید از قبل اون رو با Node.js نوشتم و در [ریپوزیتوری گیتهاب](https://github.com/sadra/FCMPushNotification) قرار دادم.
فقط کافیه ترمینال رو باز کرده و با دستور `git clone REPO_ADDRESS` اون رو در جایی که میخواهید کلون بگیرید.
بعد از کلون گرفتن (با استفاده از ترمینال یا CMD) وارد دایرکتوری اصلی پروژه node شده و دستور `npm install` رو اجرا کنید تا پکیج‌های مورد نیاز رو دانلود کنه. در نهایت بعد از نصب شدن پکیج ها فقط با اجرای دستور `npm start` سرویس آماده استفاده ست و با آدرس `http://localhost:3000` در دسترس شماست. پس:

```bash
➜  git clone git@github.com:sadra/FCMPushNotification.git
➜  cd ~/FCMPushNotification
➜  FCMPushNotification git:(master) ✗ npm install
➜  FCMPushNotification git:(master) ✗ npm start
```

اگر فایل `app.js` رو در این پروژه باز کنید چند کلید وجود داره، اول از همه لازمه که کلید امنیتی استفاده از FCM رو از کنسول فایربیس پروژتون دریافت کرده و بجای API_KEY قرار بدید. برای دریافت API Key به کنسول فایربیس مراجعه کرده، روی پروژه FirebaseApp، و بعد هم روی منوی پروژه اپ اندروید Firebase کلیک کنید و به Settings این اپ برید.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-6.png)

در پنجره باز شده به سربرگ Cloud Messaging رفته کد Server Key رو کپی کرده و در پروژه Node.js بجای `API_KEY` قرار بدید.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-7.png)

در بعد از اون هم لازمه توکن اون اپلیکیشنی برای تست استفاده می‌کنید رو برای `USER_KEY` مقدار‌دهی کنید. (این گزینه انتخابیست و الزامی نداره، اما بهتره یک یوزر تست داشته باشیم برای جلوگیری از خطاهای انسانی و تست اپ.)

```javascript
/// PATH: ../FCMPushNotification/app.js
let API_KEY = "key="+"AAAAr_E2NCM:APA91bEgmznGj0R5PpRg1ek7GKeMmpADJ5Bj..."; // Your FCM server API key
let USER_KEY = "eWRAtJC2zTs:APA91bEZ_zgxYiEWFaxpHI_wMDO5IApmEt..."; // User FCM Token ID
```

<h3 id="using-nodejs">استفاده از سرویس پوش Node.js</h3>

قبل از اینکه به توضیحات استفاده از این سرویس بپردازم لازمه بدونید که ما چند نوع پیام می‌تونیم ارسال کنیم. مطابق با مستندات FCM ما فقط ۲ نوع پیام داریم: **Notification** و **Data**. اما هرکدوم چی هستن و چه فرقی باهم دارن؟

- <h4 id="node-notification">Notification</h4>

  این نوع پیام فقط ۲ بخش داره، `title` و `body`. شما فقط می‌تونید یه پیام ساده با یک عنوان و یک متن ارسال کنید که محدودیت کارکتر هم دارید. ساختار این پیام به این شکله:

```javascript
var payload = {
    notification: {
      title: "Title of the notification message",
      body: "This is Body of the notification message."
    }
};
```

- <h4 id="node-data">Data</h4>

  اما اگر پیام شما از نوع Data باشه، شما این امکان رو دارید که پیامتون رو بصورت JSON و با هر ساختار و مقادیری که دوست دارید ارسال کنید، برای مثال:

```javascript
var payload = {
    data: {
      score: "850",
      time: "2:45"
    }
};
```

- <h4 id="node-combined-message">Combined Message</h4>

    جالب اینجاست که شما می‌تونید هردو نوع Notification و Data رو باهم یکجا بفرستید. برای مثال یه پیام ناتیفیکیشن دارید که میخواهید هم به کاربر پیامی نشون بده هم مقداری رو در دیتابیس اپلیکیشن تغییر بده:

 ```javascript
var payload = {
  notification: {
    title: "$GOOG up 1.43% on the day",
    body: "$GOOG gained 11.80 points to close at 835.67, up 1.43% on the day."
  },
  data: {
    stock: "GOOG",
    open: 829.62,
    close: "635.67"
  }
};
 ```

من در این پروژه با استفاده از Express و بر پایه REST API یکسری Route آماده کردم تا شما بتونید بدون دردسر پیام‌هاتون رو ارسال کنید. ما 4 روت داریم، که هرکدوم به ترتیب وظایف زیر رو برعهده دارند:

- با این روت می‌تونید یک پیام به صورت notification ساده ارسال کنید.

```http
POST /send/notification
```

- با این روت می‌تونید یک پیام data ساده ارسال کنید.

```http
POST /send/data-notification
```

- توسط این روت یک پیام data برای یک دسته خاص از کاربرانمون که VIP هستند ارسال می‌کنیم (در ادامه توضیح خواهم داد).

```http
POST /send/data-notification/VIP
```

- توسط این روت هم یک پیام combined برای یک دسته خاص از کاربرانمون که VIP هستند ارسال می‌کنیم.

```http
POST /send/combined-notification/VIP
```


برای استفاده از این روت‌ها می‌تونید از دستور CURL در ترمینال کمک بگیرید. اما من توصیه میکنم از [Postman](https://www.getpostman.com/) برای ریکوئست زدن استفاده کنید. کالکشن این ریکوئست‌هارو هم من از قبل برای شما آماده کردم و در پروژه قرار دادم. فقط کافیه از داخل دایرکتوری پروژه، در فولدر postman-export و یا [از اینجا در ریپوی گیتهاب](https://github.com/sadra/FCMPushNotification/blob/master/postman-export/Firebase%20Push%20Notification.postman_collection) اون رو دریافت کرده و به [Postmanتون import](https://www.getpostman.com/docs/postman/collections/data_formats) کنید. و یا [از اینجا](https://www.getpostman.com/collections/3776ad8010e1b7ae2c6e) بطور مستقیم به پست‌منتون اضافه کنید.

![Firebase Cloud Messaging Console](/assets/img/post/2017-10-24/fcm-8.png)

حالا تنها کاری که لازمه انجام بدید اینه که سرویس رو با `npm start` اجرا کرده و با Postman ریکوئست‌هاتون رو ارسال کنید. خب کارمون با سرویس Node.js و Postman تا اینجا تموم شد.

<h2 id="prepare-app-for-fcm">آماده سازی اپلیکیشن برای دریافت ناتیفیکیشن</h2>

خب رسیدیم به اصل ماجرا، حالا هم اپلیکیشن آماده است هم سرویس Node.js. اگه پیام رو ارسال کنید اپلیکیشن بدون هیچ مشکلی اون رو دریافت می‌کنه اما چیزی نشون نمیده، چون ما هنوز بهش نگفتیم با پیامی که دریافت کرده چه کاری بکنه.

<h3 id="receiving-notification">دریافت ناتیفیکیشن</h3>

همونطور که در قسمت قبلی گفتم پیام‌ها توسط کلاس `FCMService` در تابع `onMessageReceived` می‌تونیم دریافت کنیم. و همچنین گفتم که ۲نوع پیام داریم، که یا notification هستند یا data ( و یا هردو باهم ). برای دریافت پیام notification باید تابع `getNotification` و برای data از تابع `getData` استفاده می‌کنیم.

```java
@Override
public void onMessageReceived(RemoteMessage remoteMessage) {

    Log.e(TAG, "New notification from: " + remoteMessage.getFrom());

    if (remoteMessage.getNotification() != null) {
        Log.i(TAG, "Notification message: " + remoteMessage.getNotification());
        notificationMessageReceived(remoteMessage.getNotification().getTitle(), remoteMessage.getNotification().getBody());
    }

    if (remoteMessage.getData().size() > 0) {
        Log.i(TAG, "Data Payload: " + remoteMessage.getData());
        dataMessageReceived(remoteMessage.getData());
    }

}
```

اگر پیام که ارسال شده از نوع **notification** بود، فقط کافیه title و body رو گرفته و با استفاده از `NotificationCompat` اون رو نشون بدیم.

```java
private void notificationMessageReceived(String title, String body){

    NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this)
            .setContentTitle(title)
            .setContentText(body)
            .setAutoCancel(true)
            .setSmallIcon(getNotificationIcon())
            .setLargeIcon(BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher))
            .setColor(ContextCompat.getColor(this, R.color.colorPrimary));

    NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
    notificationManager.notify(getNotify(), notificationBuilder.build());

}
```

و اگر پیام از نوع **data** بود، با کمک `getData` محتوی پیام رو گرفته، به فایل **JSONObject** تبدیل کرده و ازش استفاده می‌کنیم.

من در این پروژه نمونه برای پیام data یک آبجکت بنام `type` تعریف کردم. و بر اساس **type** پیامِ دیتا، مشخص میکنم که چه رفتاری باید از اپلیکیشن سر بزنه.

```java
private void dataMessageReceived(java.util.Map<java.lang.String,java.lang.String> body) {

    try{
        JSONObject bodyObjects = new JSONObject(body);

        if(bodyObjects.getString("type").equals("banner")){
            showNotificationWithBanner( bodyObjects.getString("title"), bodyObjects.getString("message"), bodyObjects.getString("banner_url")  );
        }else if(bodyObjects.getString("type").equals("dialog_message")){
            broadcastTheMessage(bodyObjects.getString("title"), bodyObjects.getString("message"));
        }

    }catch (Exception e){ Log.e("There is a problem","Exception: "+e); }

}
```

اگه type برابر banner باشه، اول پیام رو دریافت کرده، و بعد یه `BigPictureStyle` برای `NotificationCompat` میسازیم، و در نهایت اون رو به `NotificationCompat.Builder` نسبت‌دهی می‌کنیم.

```java
private void showNotificationWithBanner(String title, String message, String bannerURL){

    //Style for showing notification With Banner
    Bitmap remote_picture = BitmapFactory.decodeResource(getResources(), R.drawable.gray_banner);
    NotificationCompat.BigPictureStyle notiStyle = new NotificationCompat.BigPictureStyle();
    try {
        remote_picture = BitmapFactory.decodeStream((InputStream) new URL(bannerURL).getContent());
    } catch (IOException e) {
        e.printStackTrace();
    }
    notiStyle.bigPicture(remote_picture);

    NotificationCompat.Builder notificationBuilder = new NotificationCompat.Builder(this)
            .setContentTitle(title)
            .setContentText(message)
            .setAutoCancel(true)
            .setSmallIcon(getNotificationIcon())
            .setLargeIcon(BitmapFactory.decodeResource(getResources(), R.mipmap.ic_launcher))
            .setColor(ContextCompat.getColor(this, R.color.colorPrimary))
            .setStyle(notiStyle);

    NotificationManager notificationManager = (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);
    notificationManager.notify(getNotify(), notificationBuilder.build());

}
```


مواقعی هست که ما نمی‌خواهیم پیام دریافتی رو بصورت ناتیفیکیشن دریافت کنیم. بلکه میخوایم مثلا اطلاعات دریافتی رو در دیتابیس ذخیره کنیم، یا میخواهیم چیزی رو به کاربر نشون بدیم. من در این نمونه میخواستم که به کاربر یه دیالوگ نشون بدم.
من مقدار **type** پیام رو برابر `dialog_message` گذاشتم. که بعدش تابع `broadcastTheMessage` فراخونی میشه، و این تابع دیتای دریافتی رو در داخل اپلیکیشن **BroadCast** میکنه.

```java
private void broadcastTheMessage(String title, String message){
    Intent notification = new Intent(FCM_ACTION_NEW_NOTIFICATION);
    notification.putExtra("title", title);
    notification.putExtra("message", message);
    LocalBroadcastManager.getInstance(this).sendBroadcast(notification);
}
```

خوب وقتشه تظیمات مربوط به اونجایی که قراره دیالوگ رو نشون بده هم انجام بدیم. پس در MainActivity اول میام یه `BroadcastReceiver` ایجاد میکنم و بهش میگم هرموقع پیامی دریافت کردی که کلید **FCM_ACTION_NEW_NOTIFICATION** رو داشت، متد مورد نظر من رو صدا کن.

```java
private BroadcastReceiver mRegistrationBroadcastReceiver;

@Override
protected void onCreate(Bundle savedInstanceState) {
    ...
    mRegistrationBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            switch (intent.getAction()) {
                case FCM_ACTION_NEW_NOTIFICATION:
                    showDialog(intent); //Call the method that shows AlertDialog
                    break;
            }
        }
    };
}
```

و بعدش هم در متد `onResume` لازمه که بگم این اکتیویتی رو برای پیام برودکست شده ای که کلیدش **FCM_ACTION_NEW_NOTIFICATION** هست، رجیستر کن.

```java
@Override
protected void onResume() {
    super.onResume();
    LocalBroadcastManager.getInstance(this).registerReceiver(mRegistrationBroadcastReceiver, new IntentFilter(FCM_ACTION_NEW_NOTIFICATION));
}
```

**نکته:** توجه کنید که رجیستر کردن برای یک برادکست حتما باید بعد از ساختن BroadcastReceiver باشه.

همه چی آمادست. اگه پیام معمولی ارسال کنیم یا بصورت دیتای بنری، به راحتی ناتیفیکیشن رو نشون میده.

![Firebase Notification](/assets/img/post/2017-10-24/fcm-9.png)

و اگر هم نوع پیام data بصورت dialog باشه، برادکست به راحتی دریافت شده و دیالوگ نشون داده میشه.

![Firebase Notification](/assets/img/post/2017-10-24/fcm-11.jpg)

<h3 id="send-and-receive-notification">ارسال و دریافت ناتیفیکیشن برای گروهی از کاربران</h3>

خب تا الان یاد گرفتیم که برای کاربران اپلیکیشنمون ناتیفیکیشن بفرستیم. اما مواقعی پیش میاد که نمیخواییم برای همه کاربرها پیام ارسال کنیم، بلکه میخوایم فقط گروهی از اونها پیام مارو دریافت کنند. اما چطوری؟

ما به دو صورت می‌تونیم پیام ارسال کنیم:

1. ارسال پیام بر اساس توکن کاربر (بصورت فردی یا گروهی)

2. ارسال پیام بر اساس Topic

تا قبل از این ما بر اساس توکن به کاربر پیام می‌فرستادیم. بهتره یه نگاهی به ساختار ریکوئستی که برای FCM ارسال میکنیم بندازیم:

```javascript
let payload = {
   notification: {
       "title": body.title,
       "body": body.message
   },
   to : USER_KEY,
   // to : TOPIC_GLOBAL,
   // to : TOPIC_VIP_USER,
   // condition : "'onscreen' in topics && 'vip_user' in topics",
};
```

   ما در **payload** (درواقع درخواستی که به سمت FCM ارسال میشه)، دو بخش اصلی داریم، اولی `notification` یا `data` که حامل پیام ما به کاربر هستند و `to` یا `condition` که مقصد و دریافت کننده پیام رو مشخص میکنه. اما هرکدوم چیکار می‌کنند:

   - مقصد مشخص **to**

     ما با دونستن توکن کاربر می‌تونیم پیام رو به یه کاربر خاص یا مجموعه ای از کاربرها ارسال کنیم. برای مثال:

```javascript
to: "XXXXX:YYYYYYYUUUUUIIIIOOOOOO",
//or
to: ["XXXXX:YYYYYYYUUUUUIIIIAAAAA", "XXXXX:YYYYYYYUUUUUIIIIBBBBB", "XXXXX:YYYYYYYUUUUUIIIICCCCC"]
```

 سرویس FCM به ما اجازه می‌ده که کاربرنامون رو در `Topic` یا موضوع (و موضوع‌های) خاصی عضو کنیم. و بدین ترتیب پیام فقط برای کاربرانی که در فلان موضوع عضو هستند ارسال بشه. به این منظور مقصد دریافت رو با کلیدواژه **topics** و نام تاپیک می‌نویسیم. برای مثال در زیر، مقصدِ پیام برای کاربرانی که عضو موضوع `vip_user` هستند تعریف شده:

```javascript
to: "/topics/vip_user"
```

- مقصد شرطی **condition**

    مقصد شرطی یا conditional به ما این امکان رو میده که پیام رو به کاربران بر اساس شرط عضویت اونها در تاپیک‌های خاصی بصورت AND و OR ارسال کنیم. برای مثال در زیر پیام برای کاربرانی که عضو VIP بوده و همچنین خانم هستند ارسال میشه:

```javascript
condition : "'gender_female' in topics && 'vip_user' in topics"
```

<h3 id="user-topics">ارسال و دریافت ناتیفیکیشن بر اساس Topic یا موضوعی خاص</h3>

   در این پروژه ای که برای نمونه ساختم، خواستم پیام برای کاربرانی که درحال حاضر صفحه اپلیکیشنشون باز بوده و از نوع VIP بودن ارسال کنم. پس اول از همه موقعی که اپلیکیشن لانچ شد در متد `onResume` اونهارو در تاپیک `onscreen` عضو کردم:

```java
@Override
protected void onResume() {
   super.onResume();
   FirebaseMessaging.getInstance().subscribeToTopic("onscreen");
}
```

   و وقتی هم میره روی `onPause` عضویتش رو از اون تاپیک لغو میکنم:

```java
@Override
protected void onPause() {
   super.onPause();
   FirebaseMessaging.getInstance().unsubscribeFromTopic("onscreen");
}
```

   و حالا برای عضویت در حالت VIP یه FloatActionButton ساختم که وقتی کاربر روش کلیک میکنه اون رو عضو VIP کرده یا عضویتش رو لغو میکنه.

```java
private void setUserVIP(boolean isVIP, View view){
    getSharedPreferences(FCM, 0).edit().putBoolean(VIP_USER, isVIP).apply();
    VIPUser.setImageResource( isVIP ? R.drawable.special : R.drawable.not_special );
    if(isVIP){
        Snackbar.make(view, "You are a VIP user.", Snackbar.LENGTH_LONG).show();
        FirebaseMessaging.getInstance().subscribeToTopic("vip_user");
    }else{
        Snackbar.make(view, "You are a regular user", Snackbar.LENGTH_LONG).show();
        FirebaseMessaging.getInstance().unsubscribeFromTopic("vip_user");
    }
}
```

خب، همه‌چی آمادست، و فقط کافیه از Postman یه ریکئوست روی  `/send/data-notification/VIP` بفرستیم، و نتیجه اینکه:

![Firebase Notification](/assets/img/post/2017-10-24/fcm-10.png)

<h3 id="send-message-to-all">ارسال پیام برای همه کاربران</h3>

 حالا اگه بخواییم پیام برای همه کاربرا ارسال بشه چی؟ آیا باید توکن همه کابرارو لیست کنیم و بفرستیم؟ نه، نیازی به اینکار نیست! فقط کافیه همون اول که اپلیکیشن کاربر رو عضو تاپیک `global` کنید و بدین صورت همه کاربرانتون عضو این تاپیک میشن.

```java
@Override
protected void onResume() {
    super.onResume();

    FirebaseMessaging.getInstance().subscribeToTopic("global");
}
```

 وبعد، هرموقع خواستید پیام برای همه کاربران ارسال بشه، فقط کافیه سمت سرور تاپیکِ مقصد رو روی `global` ست کنید:

```javascript
to: "/topics/global"
```


<h3 id="other-settings">دیگر تنظیمات ارسال پیام</h3>


<b id="other-settings-priority">اولویت Priority:</b> شما میتونید برای پیامی که ارسال می‌کنید اولویت گذاری کنید. ما به ازای هر پیام دو اولویت  `normal`  و `high` داریم.

- high: این اولویت برای مواقعی‌ست که میخواییم پیام در سریعترین زمان ممکن به دست کاربر برسه،‌و اگر اولویت همین باشه، حتی موقعی که گوشی لاک بوده و اینترنتش برای صرفه‌جویی برق قطع باشه، اینترنت رو وصل میکنه، پیام رو دریافت میکنه و به کاربر نشون میده. این حالت برای اپ‌هایی که پیام‌رسان هستند یا باید پیام همون لحظه به دست کاربر برسه، بیشتر استفاده میشه. در حالت پیشفرض برای پیام‌های notification اولویت روی high قرار داره.

- normal: این اولویت برای مواقعی‌ست که زمان رسیدن پیام اهمیت نداره،‌و به محض اینکه کاربر گوشیشو از لاک در بیاره و اینترنتش وصل بشه پیام رو بهش نشون میده. درحالت پیشفرض برای پیام‌های data اولویت روی normal قرار داره.

  البته شما‌ می‌تونید خودتون بصورت دستی هم اولویت رو برای اون پیام مشخص کنید.

  برای این منظور در سرویس Node.js و در بخش options، آیتم مربوط به priority رو اضافه می‌کنیم.


<b id="other-settings-time-to-alive">زمان اعتبار پیام timeToLive:</b> ممکن است شما بخوایید برای پیام خودتون اعتبار زمانی اعمال کنید، و اگه پیام تا فلان موقع رسید دست کاربر که هیچ، اگه نرسید دیگه به درد نمیخوره نرسون بهش. بصورت پیشفرض این مقدار روی ۰ قرار داره. سرویس FCM تمام تلاششو میکنه تا پیامتون حتما به کاربر برسه ولی خب اعتقاد داره "Now or Never"، یعنی پیامتون یا همین الان به دست کاربر میرسه یا اصن نمیرسه! 😎
برای این مورد در سرویس Node.js و در بخش options، آیتم مربوط به timeToLive رو اضافه می‌کنیم.

<b id="other-settings-collapse-key">کلید جایگزینی پیام collapse_key:</b> البته معنی تحت الفضیه این عبارت میشه (کلید اضمحلال 😐🤣). فرض کنید اولویت پیام درحالت normal قرار داره. یه پیام برای کاربر که میفرستین که مثلا میگه فلان جنس ۲۵٪ تخفیف داره اگه همین الان بخری. بعد نیم‌ساعت تصمیم گرفتین که درصد رو کاهش بدین به ۱۰٪. اونهایی که هنوز پیام رو ندیدن لازم نباشه پیام قبلیو ببینن که گیج بشن، همین ۱۰٪ رو ببینن کافیه. برای اینکار از `collapse_key` استفاده می‌کنیم.

هنگامی که اپلیکیشن در حالت Lock قرار داره، پیام رو به کاربر نشون نمیده تا  موقعی که کاربر گوشیشو unlock کنه، اگر پیام جدید با همون کلید دریافت کرد،‌ پیام قبلی رو discard کرده و بجاش این پیام جدید رو نگه می‌داره تا نشون بده.
برای این مورد در سرویس Node.js و در بخش options، آیتم مربوط به collapse_key رو اضافه می‌کنیم.
پس درنهایت مقادیر آپشن میشه:

```javascript
let options = {
  method: 'POST',
  uri: 'https://fcm.googleapis.com/fcm/send',
  body: payload,
  headers: {
      'Content-Type': 'application/json',
      'Authorization': API_KEY,
  },
  json: true,
  priority: "high", // or set it on -normal- priority
  timeToLive: 60 * 60 * 24 // this message has 24hours to be expired
  collapseKey: "discount", //or what ever you want
};
```

<h2 id="conclusion">نتیجه گیری</h2>

فکر نمیکنم دیگه موردی برای گفتن مونده باشه. سعی کردم تمام چیزهایی که لازمه رو ذکر کرده باشم. فقط میمونه ارسال پیام ناتیفیکیشن از داخل خود کنسول فایربیس که اون بمونه بعد از قسمت Analytics بهش می‌پردازم، چون بخش‌هایی از سرویس Analytics در اون دخیل هستند.

امیدوارم به راحتی بتونید از این سرویس استفاده کنید. اگه سوال یا مشکلی بود می‌تونید از طریق [توییتر](https://twitter.com/sadra_amlashi) یا [تلگرام](https://t.me/amlashi) پیام بدید تا باهم در ارتباط باشیم. 😉

درصورتی که به موارد جدیدی برخوردم، این پست رو به‌روزرسانی خواهم کرد.
