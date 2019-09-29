---
layout: blog_post_rtl
title:  "انیمیشن در اندروید با Lottie"
date: '2017-08-07'

tags:
    - Android
    - UI
    - Animation
    - Lottie

categories:
    - ابزار
    - تجربه کاربری

cover: /assets/img/post/2017-07-30/oh-my-lottie-0.png

author: Sadra
---

همونطور که قبلا بهتون در پست  " [استفاده از انیمیشن در توسعه اپلیکیشن](http://sadra.me/2017/oh-my-lottie) " قول داده بودم، در این پست قراره به آموزش استفاده از [لایبرری Lottie](https://github.com/airbnb/lottie-android) و اضافه کردن منابع بصری انیمه به پروژه اندروید بپردازیم.

فهرست:

*   **[پلاگین BodyMovin](#bodymovin)**

1.  [نصب پلاگین](#bodymovin-install)
2.  [گرفتن خروجی JSON از پروژه انیمیشن](#bodymovin-usage)

*   **[لایبرری Lottie برای اندروید](#lottie)**

1.  [نصب و آماده‌سازی اولیه](#lottie-install)
2.  [مبانی اولیه و استفاده از یک انیمیشن ساده](#lottie-basic)
3.  [انیمیشن با قابلیت کنترل progress](#lottie-progress)
4.  [پیاده‌سازی دکمه‌های انیمیشنی](#lottie-animated-button)
5.  [پیاده سازی فونت انیمیشنی](#lottie-animated-font)
6.  [طراحی صفحه خوش‌آمد گویی با انیمیشن](#lottie-intro)

*   **[نکات مهم](#lottie-tips)**
*   **[صحبت پایانی](#lottie-final)**

<h2 id="bodymovin">پلاگین BodyMovin</h2>

<h3 id="bodymovin-install">1.  نصب پلاگین</h3>

در اولین گام، فرض میکنیم که شما انیمیشن مورد نظر خودتون رو در AfterEffect طراحی کردین و حالا وقتشه که ازش خروجی بگیرید. خب برای اینکار لازمه که اول پلاگین [BodyMovin](https://github.com/bodymovin/bodymovin) روی افترافکت نصب کرده باشید.

میتونید پلاگین رو از [aescripts](http://aescripts.com/bodymovin/) یا [adobe store](https://creative.adobe.com/addons/products/12557) دریافت کنید؛ اما چون دانلود کردن از اینجا خیلی دردسر داشت، من گذاشتمش در ریپوی پروژه و میتونید از گیتهاب مستقیما دانلودش کنید. ( [دانلود پلاگین BodyMovin](https://github.com/sadra/LottieExampleProject/blob/master/repo/plugin/bodymovin_v4.10.2.zip) )

فایل دانلودی رو آنزیپ کنید، درون پوشه یک فایل **bodymovin.zxp** وجود داره. باید اون رو به عنوان اکستنشن به پروژه اضافه کنید، که اونم خیلی دردسر داره! برای راحتتر پیش رفتن این موضوع از ابزاری به نام **zxp** استفاده میکنیم. نرم‌افزار zxp-installer رو از [aescripts](http://aescripts.com/learn/zxp-installer/) دانلود و نصب کنید. بعد از اجرا کردنش کافیه فایل bodymovin.zxp رو به zxp درگ اند دراپ کنید.


![ZXP Installer](/assets/img/post/2017-08-10/zxp-0.png)

حالا اکستنشن نصب شده و فقط لازمه AfterEffect رو ری استارت کنید.

قبل از استفاده از BodyMovin لطفا به `Edit > Preferences > General` رفته، و تیک **Allow Scripts to Write Files and Access Network** رو فعال کنید.

![ZXP Installer](/assets/img/post/2017-08-10/zxp-1.png)

تمامی این روند در هردو سیستم عامل Windows و MacOS به همین ترتیبی که گفتم انجام میشه.

<h3 id="bodymovin-usage">2.  گرفتن خروجی JSON از پروژه انیمیشن</h3>

خب حالا وقته خروجی گرفتنه.اول از همه پروژه AfterEffect تون رو باز کنید و بعد کافیه به مسیر `Edit > Extionstions > BodyMovin` رفته تا بادی‌مووین آماده خروجی گرفتن بشه.

![ZXP Installer](/assets/img/post/2017-08-10/bodymovin-0.png)

خب حالا باید مسیر خروجی رو مشخص کنید.

![ZXP Installer](/assets/img/post/2017-08-10/bodymovin-1.png)

انمیشین‌ی که میخوایید ازش خروجی بگیرید رو انتخاب کنید‌.

توجه کنید که میتونید در همینجا Preview انیمیشن رو هم مشاهده کنید، یا میتونید اینکارو با نصب پلیر مخصوص بادی‌مووین انجام بدید، فقط کافیه روی Get the Player کلیک کرده و نصبش کنید.

و در آخر روی Render کلیک کنید.

![ZXP Installer](/assets/img/post/2017-08-10/bodymovin-2.png)

حالا همه چی تموم شده و روی Done کلیک کنید و تمام.

![ZXP Installer](/assets/img/post/2017-08-10/bodymovin-3.png)

تمامی مراحل نصب و خروجی گرفتن از BodyMovin رو پشت‌سر گذاشتیم. فقط کافیه فایل json خروجی گرفته شده رو به پروژه اندروید، iOS و یا ReactNative اضافه کنیم.

***

<h2 id="lottie">لایبرری Lottie برای اندروید</h2>

<h3 id="lottie-install">1.  نصب و آماده‌سازی اولیه</h3>

قبل از شروع همه چیز، من برای نمونه و تمرین یه پروژه اندروید ساخته و در گیتهابم گذاشتم، میتونید به [صفحه گیتهاب این پروژه](https://github.com/sadra/LottieExampleProject) مراجعه کرده و به تمامی فایلها مثل پلاگینها، نمونه های انیمیشن و کدهای سمپل در همون ریپوزیتوری دسترسی داشته باشد.

در اولین گام باید لایبرری **Lottie** رو به پروژمون اضافه کنیم. کافیه اون رو در Dependencie های پروژه در فایل `build.gradle` معرفی کنیم و بعدشم هم پروژه رو یکبار سینک میکنیم.

```groovy
dependencies {
  compile 'com.airbnb.android:lottie:2.1.0'
}
```

شما باید فایلهای انیمیشن رو در پوشه **assets** قرار بدید. اگر قبلا پوشه رو تعریف کردین که هیچ، اما اگه اینکارو نکردین کافیه یه دایرکتوری به اسم assets در مسیر `app/src/main` ایجاد کرده و بعد فایلهای json انیمیشن رو بریزید اونجا.

فایلهای JSON ای که در این پروژه استفاده کردم رو میتونید مستقیما از [ریپوی گیتهاب](https://github.com/sadra/LottieExampleProject/tree/master/app/src/main/assets) دریافت کنید.

<h3 id="lottie-basic">2.  مبانی اولیه و استفاده از یک انیمیشن ساده</h3>

اول باید view مربوط به لاتی رو به Layout مورد نظرتون اضافه کنید.

```xml
<com.airbnb.lottie.LottieAnimationView
        android:id="@+id/animation_view"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        app:lottie_fileName="gift.json"
        app:lottie_loop="true"
        app:lottie_autoPlay="true" />
```

قبل از هرچیزی بهتره با پارامتر‌های اصلی که به ویوومون دادیم آشنا بشیم. پارامتر **lottie_fileName** اشاره به نام و محل فایل json انیمیشنتون داره. توجه کنید که اگه فایل json رو همینجوری در assets قرار دادید که هیچ، فقط کافیه اسم فایل رو نام ببرید؛ اما اگه اون رو در یک پوشه درون assets تجمیع کردین، یادتون نره که حتما نام پوشه رو قبل از فایل ذکر کنید مثلا: `myFolder/anim.json`

پارامتر **lottie_loop** اشاره به این مورد داره که این انیمیشن بصورت  با یا بدون لوپ (بی پایان) پخش بشه. اگه اشاره ای بهش نکنید بصورت پیشفرض `false` هست، ولی اگه میخواهید انیمیشنتون لوپ داشته باشه، یادتون نره که به `true` بودنش اشاره کنید.

و مورد آخر هم **lottie_autoPlay** هست، که میگه میخوایید همون موقع که ویوو ظاهر شده، شروع کنه به پخش یا نه؟ این هم بصورت پیشفرض `false` هست.

خب حالا اگه پروژه رو بیلد کنید، میبینید که به چه آسونی انیمیشن به پروژتون اضافه شده ^_^

![Lottie Simple Animation Demo](/assets/img/post/2017-08-10/lottie-anim-0.gif)

همه این موارد رو در خود کلاستون هم میتونید انجام بدید. اول ویوو رو در کلاستون معرفی و کَست کنید.

```java
LottieAnimationView animationView = (LottieAnimationView) findViewById(R.id.animation_view);
```

و بعد مورادی مثل محل و نام انیمیشن، لوپ بودنش، و پخش اتوماتیک رو به همون راحتی متیونید واسش تعریف کنید.

```java
animationView.setAnimation("hello-world.json");
animationView.loop(true);
animationView.playAnimation();
```

ما در حالت کد، امکانات خیلی زیادی داریم. برای مثال اگه بخوایم سرعت انیمیشن رو کم یا زیاد کنیم کافیه متد `.setSpeed(floatValue)` رو صدا بزنیم و مقدار دهی کنیم. مقدار 1.0 یعنی همون سرعت نرمال خودش. حالا هرچی از یک بالاتر یا پایینتر باشه، انیمیشن به همون نسبت سریعتر یا کندتر نمایش داده میشه.

```java

animationView.setSpeed(1.0); //normal speed
animationView.setSpeed(0.2); //2x faster
animationView.setSpeed(0.5); //2x slower
```

شما همچنین میتونید انیمیشن رو Pause یا متوقف کنید و سپس اقدام به ادامه پخش اون کنید.

```java
animationView.pauseAnimation(); //Pause the animation
animationView.resumeAnimation(); //and Resume it again
```

> توجه کنید که اگر یکبار Pause کنید انیمیشن متوقف میشه، اما مجددا اگر pauseAnimation رو صدا کنید انیمیشن به نمایش خودش ادامه می‌دهد( Resume میشه ). این مورد درباره resumeAnimation هم صادق هست! احساس میکنم مشکلی در خود لایبرریه، و این مورد رو واسشون issue کردم تا بررسی کنن، پس حواستون بهش باشه.

یکی دیگه از امکاناتی که در کد به ما داده میشه، اینه که بتونیم به انیمشن رنگ دلخواه خودمون رو بدیم. یه `PorterDuffColorFilter` ایجاد کرده و رنگ مورد نظرتون رو بهش بدین. این موضوع رو در نظر داشته باشن که **Mode** رنگ هم روی `PorterDuff.Mode.SRC` باشه بهترین حالته، در مودهای دیگه رنگ تغییر میکنه.

خب، حالا برای اضافه کردن رنگ ۲متد اصلی داریم. برای اینکه به کل ویوو انیمیشنمون رنگ بدیم، باید از متد `addColorFilter(colorFilter)` استفاده کنیم. مواقعی پیش میاد که میخواییم به یه لایه خاص از انیمیشنمون رنگ بدیم، برای اینکار از متد `addColorFilterToLayer(“layerName”, colorFilter)` استفاده می‌کنیم. لازمه که اول اسم لایه ای که میخواید رنگ بگیره رو نام برده، و سپس فیلتر رنگ خودتون رو مشخص کنید.

```java
final PorterDuffColorFilter colorFilter1 = new PorterDuffColorFilter(Color.parseColor("#CC0321"), PorterDuff.Mode.SRC);
animationView.addColorFilter(colorFilter1);

final PorterDuffColorFilter colorFilter2 = new PorterDuffColorFilter(Color.RED, PorterDuff.Mode.SRC);
animationView.addColorFilterToLayer("LAYER_NAME", colorFilter1);
```

برای پاک شدن رنگ هم کافیه متد clear رو صدا بزنید.

```java
animationView.clearColorFilters();
```

البته شما میتونید فیلتر رنگ رو در خود Layout هم تعریف کنید. البته در اونجا فقط میتونید رنگ رو برای کل ویوو در نظر بگیرید، نه برای یک لایه خاص.

```xml
<com.airbnb.lottie.LottieAnimationView
    app:lottie_colorFilter="@android:color/holo_purple"
    android:id="@+id/animation_view"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content" />
```

و آدرس تمامی کدهای و نمونه‌هایی که در این قسمت پیاده کردیم:

{% ltr %}
**Get it from github:** [Class](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/java/com/isapanah/lottieeexampleproject/SimpleAnimation.java) / [Layout](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/res/layout/simple_animation.xml) / [JSON Animation](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/gift.json)
{% endltr %}

---

<h3 id="lottie-progress">3.  انیمیشن با قابلیت کنترل Progress  </h3>

یکی از قابلیت های کاربردی که Lottie در اختیار شما میگذاره، اینه که شما بتونید روند یا Progress انیمیشنتون رو کنترل کنید. هر انیمیشنی شامل یک بازه **0.0** تا **1.0** میشه (اشاره به همون ۰ تا ۱۰۰ درصد داره)، برای اینکه بتونید مشخص کنید که انیمیشنتون از کجا شروع بشه، یا اینکه الان در کدوم فریم باشه، فقط کافیه متد `setProgress(floatValue)` رو صدا زده و مقدار مورد نظر رو بهش بدید.

من برای اینکه این تمرین رو انجام بدم، یه seekBar در لی‌اَوت‌م گذاشتم، و با **onProgressChanged** اون رو ردیابی کرده،‌ و به ازای هر تغییر، مقدار `((float)progress)/100` رو به progress انیمیشنمون مقداردهی میکنم:

```java
seekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {

    @Override
    public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
        animation_view.setProgress( ((float)progress) / 100 );
    }

    ...
});
```

و خب، نتیجش میشه این:

![Lottie Progress Animation Demo](/assets/img/post/2017-08-10/lottie-anim-1.gif)

شما حتی میتونین برای انیمیشنتون یه رنج هم تعریف کنید. در [بخش بعدی](#lottie-animated-button) بصورت عینی در مورد این موضوع مثال زدم.

و آدرس تمامی کدهای و نمونه‌هایی که در این قسمت پیاده کردیم:

{% ltr %}
**Get it from github:** [Class](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/java/com/isapanah/lottieeexampleproject/ProgressAnimation.java) / [Layout](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/res/layout/progress_animation.xml) / [JSON Animation](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/starwars.json)
{% endltr %}

---

<h3 id="lottie-animated-button">4.  پیاده‌سازی دکمه‌های انیمیشنی</h3>

یکی از مواردی که خیلی در زیبایی و تجربه کاربری لذت‌بخش تاثیر داره و در [منابع متریال](https://material.io/guidelines/motion/material-motion.html) هم به اون اشاره شده، استفاده کردن از دکمه‌هاییه که افکت‌های انیمیشنی دارند. برای مثال همبرگر منويي که با کلیک میچرخه و از Hamburger به Back Button تبدیل میشه.

سوال اینجاست که چطوری باید همچین چیزی رو طراحی کنیم!؟ بگذارید موضوع رو ساده کنیم، ما یه انیمیشن از دکمه سوییچ داریم. این انیمیشن از پراگرس **0.0** تا **0.5** نشون میده که سوییچ `On` میشه، و از پراگرس **0.5** تا **1.0** نشون میده که سوییچ `Off` میشه.

حالا موقعی که کاربر سویچ on رو تپ کرد، انیمیشن رو از پراگرس **0.0** به **0.5** انیمیت می‌کنیم. و وقتی سویچ رو off کرد، میتونیم ۲ کار انجام بدیم:

*   یا انیمیشن رو از 0.5 به 1.0، انیمیت کنیم.

*   یا اینکه انیمیشن رو بصورت **reverse** پخش کنیم. یعنی پراگرس از 0.5 به 0.0 انیمیت میشه.

من در نمونه اپلیکیشنی که در گیتهاب گذاشتم، چند مثال در این مورد آوردم:

**دکمه سوییچ:** در این مثال من یه مقدار بولین به اسم `switchIsOn` ایجاد کردم تا باز یا بسته بودن سوییچ رو بتونم دنبال کنم. وقتی که کاربر کلیک کرد یکبار متد `playAnimation()` و دفعه بعد `reverseAnimation()` رو صدا میزنم.

```java
if(switchIsOn){
    animatedSwitchButton.reverseAnimation();
    switchIsOn = false;
} else {
    animatedSwitchButton.playAnimation();
    switchIsOn = true;
}
```

**همبرگر منو:** در این مثال بازم هم من یه مقدار بولین برای دنبال کردن باز/بسته بودن منو درست کردم. حالا موقع بازشدن همبرگر منو، با استفاده از کلاس `ValueAnimator` یک رنج از پراگرس ایجاد کرده `(0.05f, 0.45f)` و مقداری هم برای مدت زمان سپری کردن این انیمیشن تعریف میکنم `setDuration(2000)`. برای بسته شدن همبرگر منو هم، یه رنج دیگه با مقادیری بلعکس ایجاد کردم. خب، از الان هربار که کاربر روی دکمه کلیک کنه، انیمیشن نمایش داده میشه و انگار که منو باز و بسته میشه.

```java
//With ValueAnimator
ValueAnimator animator;
if(!hamburgerIsOpen){
    animator = ValueAnimator.ofFloat(0.05f, 0.45f).setDuration(2000);
    hamburgerIsOpen = true;
} else {
    animator = ValueAnimator.ofFloat(0.45f, 0.05f).setDuration(2000);
    hamburgerIsOpen = false;
}

animator.addUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
    @Override
    public void onAnimationUpdate(ValueAnimator animation) {
        animatedHamburger.setProgress((Float) animation.getAnimatedValue());
    }
});
animator.start();
```

**دکمه رادیو:** در مورد کیس رادیو باتن هم برای اکتیو کردن سلکشن، یکبار انیمیشن کامل به نمایش درمیاد، بار دوم که کاربر کلیک میکنه، پراگرس روی **0.0** یعنی موقعی که رادیو انتخاب نشده بود سِت میشه. و این روند همینجوری ادامه خواهد داشت.

```java
if(animatedRadioButton.getProgress() != 1.0)
    animatedRadioButton.playAnimation();
else
    animatedRadioButton.setProgress(0.0f);
```

**دنبال کردن انیمیشن:** ما میتونیم هم **مراحل** و هم **روند** انیمیشنمون رو دنبال کنیم. برای مثال من در مورد کیس دکمه قطع صدا، میخواستم وقتی که انیمیشن تموم شد یه Toast نشون بدم و به کاربر بگم که صدا تموم شد. برای همین متد `addAnimatorListener` رو برای ویوومون تعریف کردم که به ما ۴تا متد دیگه میده:

*   `onAnimationStart` هنگام شروع انیمیشن

*   `onAnimationEnd` هنگام پایان انیمیشن

*   `onAnimationCancel` هنگام لغو شدن انیمیشن

*   `onAnimationRepeat` هنگام تکرار انیمیشن

پس من هم از `onAnimationEnd` استفاده کردم و موقعی که انیمیشن تموم میشه به کاربر میگم که صدا قطع شد یا وصل شد.

```java
//Animator Listener
animatedMuteButton.addAnimatorListener(new Animator.AnimatorListener() {
    @Override
    public void onAnimationStart(Animator animation) { ... }

    @Override
    public void onAnimationEnd(Animator animation) {
        Toast.makeText(InteractionAnimation.this, isMute? "Sound is mute." : "Sound isn't mute.", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onAnimationCancel(Animator animation) { ... }

    @Override
    public void onAnimationRepeat(Animator animation) { ... }
});
```

ایطوری میتونید مراحل و مقاطع انیمیشن رو دنبال کنید. خب یه وقتایی هم هست که نیازه تا روند اپلیکیشن رو دنبال کنیم. برای اینکه این قضیه رو واستون روشن کنم از‌ انیمیشن یه ساعت استفاده کردم، میخوام به فلان تایم یا فلان درصد از پراگرس که رسید، رنگش عوض بشه. وقتی هم که زمان تموم شد، یه اسنک نشون بده که زمانت تموم شده. برای این لازمه که هرلحظه بدونم در چه درصدی از انیمیشن قرار داریم. واسه پیاده کردن این موضو از متدی به اسم `addAnimatorUpdateListener` برای ترک کردن هربار آپدیت شدن یا تغییر کرد یکی از مشخصه های انیمیشن استفاده میکنیم (که ساده‌ترینش همین تغییر پراگرس هست). یه سری **if** هم گذاشتم و با `getAnimatedValue()` چک کردم که اگه در فلان بازه ای قرار گرفت، رنگش تغییر کنه یا اسنک نشون بده. که نهایتا شد این:

```java
//Animator Update Listener
animatedWatch.addAnimatorUpdateListener(new ValueAnimator.AnimatorUpdateListener() {
    @Override
    public void onAnimationUpdate(ValueAnimator animation) {
        if((Float)animation.getAnimatedValue() < 0.25f){
            animatedWatch.addColorFilter( new PorterDuffColorFilter(Color.RED, PorterDuff.Mode.SRC) );
        }else if((Float)animation.getAnimatedValue() > 0.2 && (Float)animation.getAnimatedValue() < 0.5){
            animatedWatch.addColorFilter( new PorterDuffColorFilter(Color.MAGENTA, PorterDuff.Mode.SRC) );
        }else if((Float)animation.getAnimatedValue() > 0.5 && (Float)animation.getAnimatedValue() < 0.75){
            animatedWatch.addColorFilter( new PorterDuffColorFilter(Color.CYAN, PorterDuff.Mode.SRC) );
        }else{
            animatedWatch.addColorFilter( new PorterDuffColorFilter(Color.BLUE, PorterDuff.Mode.SRC) );
        }
        if( (Float)animation.getAnimatedValue() == 0.93f ){
            Snackbar.make(findViewById(R.id.container),  "Oh My Lottie, your time is finished!", Snackbar.LENGTH_LONG).show();
        }
    }
});
```

خب فکر میکنم تمام چیزهایی که در این بخش لازم بود رو گفتم. حالا میتونید باقی سناریوهارو بر اساس همین‌ تمرین پیاده کنید.

![Lottie Interaction With User Demo](/assets/img/post/2017-08-10/lottie-anim-2.gif)


و آدرس تمامی کدهای و نمونه‌هایی که در این قسمت پیاده کردیم:

{% ltr %}

**Get it from github:** [Class](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/java/com/isapanah/lottieeexampleproject/InteractionAnimation.java) / [Layout](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/res/layout/interaction_animation.xml)

**JSON Animations:**

*   [radio_button](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/radio_button.json)

*   [switch](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/switch.json)

*   [hamburger](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/hamburger.json)

*   [mute](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/mute.json)

*   [watch](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/watch.json)

{% endltr %}

---

<h3 id="lottie-animated-font">5.  پیاده سازی فونت انیمیشنی</h3>

فونت انیمیشنی، یکی از چیزهای جالبی که لاتی داشت و بنده خیلی درد کشیدم تا پیادش کنم! قبل از شروع این قسمت دعوت میکنم با دیدن انیمیشن زیر، با این پدیده آشنا بشید:

![Lottie Animation Font Demo](/assets/img/post/2017-08-10/lottie-anim-3.gif)

اما واقعا چطوری یه همچین چیزیو میشه درست کرد؟ اجازه بدید تا تکنیک این بخش رو تشریح کنم.

مایه پوشه داریم که درون این پوشه به ازای هر حرف از حروف الفبا، یه انیمیشن وجود داره، مثلا یه انیمیشنی که انیمیت میشه تا حرف A رو نشون بده. ازونور ما گوش میدیم و هروقت که یه حرف از حروف الفبا تایپ شد، ما هم انیمیشنش رو پیدا کرده و به متن نوشته شده قبلی ( درواقع انیمیشن های بهم چسبیده قبلی) اضافه میکنم. یه انیمیشن هم واسه cursor داریم که مثلا نشون میده نشانه نوشتار ما الان کجاست. به همین سادگی.

خب، اول از همه نیازه که یه کلاس ایجاد کنیم به اسم **LottieFontViewGroup** که از FrameLayout اکستند شده و نگهدارنده انیمیشن‌های ماست. این کلاس برای ما ۳تا کار انجام میده:

*   ایجاد ویوو برای ادیتور متن

*   ثبت کردن اکشن ها به عنوان انیمیشن (مثل نشانگر، حروف و خط فاصله)

*   نگهدارندی و کنترل کردن انیمیشن ها

نمونه ای که الان در گیتهاب خود Lottie هست، با زبان کاتلین نوشته شده [LottieFontViewGroup.kt](https://github.com/airbnb/lottie-android/blob/master/LottieSample/src/main/kotlin/com/airbnb/lottie/samples/LottieFontViewGroup.kt) و من همون نمونه رو به جاوا کمی تغییر دادم و سایز فونت‌هارو اصلاح کردم و نهایت گذاشتمش توی گیتهاب همین پروژه که از اینجا میتونید [LottieFontViewGroup.java](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/java/com/isapanah/lottieeexampleproject/LottieFontViewGroup.java) دریافتش کنید.

خب، فقط کافیه که ویوو مربوطه رو در لایه ای که مد نظرتون هست قرار بدید، بدون اینکه نیاز باشه با چیز دیگه‌ای درگیر بشین.

```xml
<com.example.yourproject.LottieFontViewGroup
    android:id="@+id/fontView"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>
```

ممکنه بپرسین این فونت انیمیشنی به چه دردی میخوره؟ شاید خود ادیتورش بدردتون نخوره، ولی میتونید ازش استفاده کنید و متنی که دلتون میخواد (مثلا اسم شرکت یا پروژه) رو بصورت انیمیشنی به کاربر نمایش بدید.

میتونید از فونت دیگه ای هم استفاه کنید؟ صد در صد، فقط باید زحمت طراحی انیمیشن برای تمامی حروف رو خودتون بکشید :)) چون غیر از همین نمونه ای که روی وب بود، چیز دیگه ای پیدا نکردم.

و آدرس تمامی کدهای و نمونه‌هایی که در این قسمت پیاده کردیم:

{% ltr %}
**Get it from github:** [LottieFontViewGroup](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/java/com/isapanah/lottieeexampleproject/LottieFontViewGroup.java) / [Class](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/java/com/isapanah/lottieeexampleproject/AnimatedFont.java) / [Layout](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/res/layout/activity_typography_demo.xml) / [Animation Font Folder](https://github.com/sadra/LottieExampleProject/tree/master/app/src/main/assets/Mobilo)
{% endltr %}

----

<h3 id="lottie-intro">6.  طراحی صفحه خوش‌آمد گویی با انیمیشن</h3>

و تمرین آخر، در این قسمت میخواهیم یک صفحه خوش‌آمدی گویی، Intro یا OnBoarding بسازیم.

اول بیایم منطق قضیه رو باهم بررسی کنیم. در این پروژه به یک فایل انیمیشن که شامل تمامی مراحل Intro باشه نیاز داریم. هر مرحله یک آغاز و پایانی داره و ما باید زمان شروع و پایان تمامی مراحل رو در بیاریم، برای مثال صفحه دوم Intro از پراگرس 0.25 شروع و در 0.42 تموم میشه. حالا موقعی که کاربر Swipe میکنه یا روی دکمه ‘بعدی' کلیک میکنه ما هم همگام با اسکرول شدن صفحه، پراگرس انیمیشن رو به همون نسبت جلو میبریم.

در این تمرین برای صفحه خوش‌امدگویی از لایبرری [SlidingIntroScreen](https://github.com/MatthewTamlin/SlidingIntroScreen) و انیمیشن [services_intro](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/services_intro.json) استفاده کردم. و زمان تمامی مراحل انیمیشن رو به ترتیب زیر لیست کردم:

```java
private static final float[] ANIMATION_TIMES = new float[]{
    0.06f,
    0.25f,
    0.42f,
    0.57f,
    0.71f,
    0.9f,
    1,
    1
};
```

توجه کنید که ۲ مقدار پایانی باید با پراگرس آخری یکی باشن، تا موقع اسکرول کردن آرایه سرریز نکنه.

و بعدش هم به تعداد صفحاتی که قرار اسکرول کنیم نمونه ساختم:

```java
@Override
protected Collection<? extends Fragment> generatePages(Bundle savedInstanceState) {
    return new ArrayList<EmptyFragment>() { {

        int pages = 7;
        while (pages > 0){
            add(EmptyFragment.newInstance());
            pages--;
        }

    }};
}
```

هرموقع که صفحه خوش‌آمدگویی درحال اسکرول شد، متد setAnimationProgress صدا میزنم، در این متد مقدار پاگرس فعلی و بعدی رو میگیرم و مقدار اسکرول رو هم داریم و میزان پراگرس رو به انیمیشنمون اضافه میکنم:

```java
private void setAnimationProgress(int position, float positionOffset) {

    float startProgress = ANIMATION_TIMES[position];
    float endProgress = ANIMATION_TIMES[position + 1];
    animationView.setProgress(lerp(startProgress, endProgress, positionOffset));

}
```

برای اینکه انیمیشنمون تمیز و زیبا انجام بشه از متدی به نام lerp استفاده میکنیم. این متد بهمون کمک میکنه که زمان انیمیشنمون رو متناسب به مقدار اسکرولی که انجام شده جلو ببریم و این تغییر انیمیشن‌ها با نرمی بیشتری انجام بشه:

```java
private float lerp(float startValue, float endValue, float f) {
    return startValue + f * (endValue - startValue);
}
```

خب تمومه. حالا یه صفحه خوش‌امد گویی ترو تمیز داریم. و اینم کاریه که انجام دادیم:

![Lottie Intro Animation Demo](/assets/img/post/2017-08-10/lottie-anim-4.gif)

از همین متد میتونید توی بقیه لایبرری هایی که کار Intro یا onBoarding رو انجام میدن استفاده کنید.

و آدرس تمامی کدهای و نمونه‌هایی که در این قسمت پیاده کردیم:

{% ltr %}
**Get it from github:** [AppIntroActivity](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/java/com/isapanah/lottieeexampleproject/AppIntroActivity.java) / [app_intro_animation_view](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/res/layout/app_intro_animation_view.xml) / [fragment_empty](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/res/layout/fragment_empty.xml) / [JSON Animation](https://github.com/sadra/LottieExampleProject/blob/master/app/src/main/assets/services_intro.json)
{% endltr %}

---

<h3 id="lottie-tips">7.  نکات مهم</h3>

در ادامه مطلب قصد دارم نکاتی درباره استفاده از لایبرری Lottie به شما یادآور بشم:


**استفاده از انیمیشن‌های آماده:** همونطور که در بخش‌های ابتدایی ذکر کرده بودم، شما متیونید از انمیمیشن‌های آماده در پروژتون استفاده کنید. توجه کنید که بعضی از این اینیمیشن‌ها ناقص هستند یا مشکلی دارند. فقط چند مورد مثال میزنم.

**فضای خالی دور انیمیشن:** بعضی از انیمیشن ها مثل [این](https://www.lottiefiles.com/425-bold-button)، [این](https://www.lottiefiles.com/422-onoff-switch-2) و [این](https://www.lottiefiles.com/416-thumbs-up) حدودا به اندازه ۵۰۰پیکسلِ مربع فضای خالیه اطرافشون! خیلی سعی کردم با خود فایل JSON ور برم و از فضای خالیش کم کنم، اما نشد که نشد. وقتی ازینها در پروژه استفاده می‌کنید ممکنه بیش از حد کوچیک به نظر بیان. تنها راه حلی که به ذهنم رسید این بود که ویوو انیمیشن رو اسکیل بدم. متاسفانه این اسکیل دادن در بعضی مواقع باعث میشه که انیمیشن پیکسله بشه.


```xml
<com.airbnb.lottie.LottieAnimationView
    android:id="@+id/animatedView"
    android:scaleX="1.5"
    android:scaleY="1.5"
    android:layout_width="60dp"
    android:layout_height="60dp" />
```

**تکرار بی‌جهت انیمیشن:** در بعضی انیمیشن‌ها مثل [این](https://www.lottiefiles.com/334-bamburge) و [این](https://www.lottiefiles.com/444-mute) دیده شده که انیمیشن بعد از پایان، دوباره تا چند فریم حرکت اضافی داره! دو راه پیش پای ماست، یا اینکه رنج شروع و پایان برای انیمیشن تعریف کنیم. یا اینکه در فایل JSON انیمیشن دست ببریم. اما چطوری. هر فایل JSON انیمیشنی رو که باز کنید، دارای دو پارامتر ip و op هستند. ip نشون دهنده فریم شروع کننده انمیشین و op نشون دهنده فریم پایانی انیمیشن هست. با تغییر این دو فاکتور در فایل JSON میتونید شروع و پایان انیمیشنتون رو دستکاری کنید.

```json
{
    ...
    "ip":3,
    "op":27.05,
    ...
}
```

**استفاده از AnimatedVectorDrawable:** همین چند روز پیش بود که نیک بوچر در [وبلاگش نوشت](https://medium.com/google-design/bodymovin-to-android-6e53e5f7a96) که با استفاده از نسخه ۴ پلاگین BodyMovin میتونین برای AVD مستقیما خروجی بگیرین. باین اوصاف یعنی دیگه نیازی به Lottie نیست؟ خیر، شما فعلا فقط میتونید اون خروجی رو نمایش بدید. اما این دلیل نمیشه که تمام امکاناتی که Lottie داره، AVD هم داشته باشه. سعی میکنم در یه پست جداگانه نحوه استفاده از AVD رو هم آموزش بدم اما الان فقط میخوام به خواص هرکدوم اشاره میکنم:

خوبی‌های Lottie:

*   بیشتر از هر لایبرری و پلاگین دیگه از انیمیشن‌های افترافکت پشتیبانی میکنه

*   شما دسترسی کاملا دستی و Manual به انیمیشن دارید و میتونید eventها و کلیک‌هارو مدیریت کنید

*   میتونید خود فایل رو مستقیما از اینترنت دریافت کرده و نمایش بدید

*   میتونید بصورت برعکس پخش کنید و سرعتشو کنترل کنید

*   با در اختیار گذاشتن پراگرس شما میتونید حتی نحوه پخش انیمیشن رو هم مدیریت کنید

خوبی AVD:

*   انیمیشن با سرعت و پرفرمنس بهتری در [Render Thread](https://medium.com/@workingkills/understanding-the-renderthread-4dc17bcaf979) نسبت به Main Thread اجرا میشه.

**پشتیبانی از AfterEffect:** لایبرری لاتی یه [لیست](http://airbnb.io/lottie/supported-features.html) از انیمیشن‌ها و افکت‌هایی از افترافکت که پشتیبانی می‌کنه آماده کرده. قبل از طراحی انیمیشن در AfterEffect حتما این [فیچر‌ها](http://airbnb.io/lottie/supported-features.html) رو بررسی کنید تا خدای نکرده انیمیشنتون ناقص اجرا نشه.

**سایز انیمیشن:** اگه براتون سوال بوجود اومد که سایز انیمیشن هارو چطوری ست کنم؟ بهتون پیشنهاد میکنم این [چیت شیت](https://material.io/devices/) از متریال رو مطالعه کنید تا دستتون بیاد که چه سایز px رو باید برای انیمیشنهاتون تا در اندروید با سایز dp همخونی داشته باشه.

**کش کردن انیمیشن:** ممکنه بعضی از انیمیشن‌ها به کَرّات استفاده بشه. برای اینکار حتما برای انیمیشنتون CacheStartegy رو فعال کنید. CacheStrategy رو بر اساس میزان استفاده‌تون میتونید روی ۳ حالت `Strong` ، `Weak` و `None` قرار بدید.

```java
lottieView = (LottieAnimationView) findViewById(R.id.simpleAnimation_lottieView);
lottieView.setAnimation("gift.json", LottieAnimationView.CacheStrategy.Strong);
```

**رنگ دادن به یک لایه خاص از انیمیشن**: مشابه مثالی که در بخش اول زدم، ممکنه شما بخوایید رنگ یک لایه خاص از انیمیشنتون رو تغییر بدید. مثلا در همون مثال ما رنگ بدنه و درپوش جعبه کادو رو تغییر دادیم. اما برای این کار، اگر انیمیشنتون رو خودتون طراحی کردین، میدونید که اسم لایه‌هاتون چیه و اسم لایه مورد نظر رو میبرید و رنگ بهش الصاق میشه. اما اگر از فایل آماده برای انیمیشنتون استفاده کردین، باید فایل JSON رو باز کرده و ببنید کدوم پارامتر‌ها با لیبل `nm` مشخص شدن و دونه دونه اونهارو سعی و خطا تست کنید تا معلوم بشه کدومشون لایه مورد نظر شماست. برای مثال همین جعه دو لایه به نام های `body Konturen` و `top Konturen` اشاره به درپوش و بدنه جعبه داشت که پیدا کرده و رنگ رو بهش الصاق کردیم.

```json
//gift.json
{"ddd":0,"ind":3,"ty":4,"nm":"body Konturen", ...

{"ddd":0,"ind":4,"ty":4,"nm":"top Konturen", ...
```

**زمان بندی در انیمیشن خوش‌آمدگویی:** اگه یادتون باشه در اون بخش گفتم که انیمیشن به نسبت اسکرول جلو و عقب میره. میدونیم که میزان فاصله دو صفحه از یک Viepager همیشه یکتا و بین همه صفحات مساویه. پس شما هم سعی کنید در انیمیشنی که طراحی میکنید این قانون رو نظر داشته باشید. اگه به همین انیمیشن دقت کنید  در بعضی بخشها سریع و در بعضی دیگه کند به نمایش درمیومد، دلیلش هم عدم توازن زمانی بین دو تغییر انیمیشن بود.

**آپدیت: این بخش در صورت مواجه شدن با مسايل جدید ممکنه به‌روزرسانی بشه.**

---

<h3 id="lottie-final">8.  صحبت پایانی</h3>

این بلندترین پستی بود که تا به امروز نوشتم. چیزی نزدیک به 29هزار کَرکتر. امیدوارم این پست بدردتون خورده باشه. متن خیلی طولانیه، برای همین در بالای صفحه فهرستی از عنوانها آماده کردم تا شما به راحتی تونید به بخش‌های که میخوایید مراجعه کنید.

اگه قصد داشتین از این پست در وبلاگتون استفاده کنید، درخواست میکنم حتما به همین پست و بخش مربوطه رفرنس بدید ^_^

و در آخر من کامنت‌های وبلاگ رو بستم و دوست دارم با شما در شبکه‌های اجتماعی تعامل داشته باشم. اگر سوال یا موردی بود در [توییتر](https://twitter.com/sadra_amlashi) مطرح کرده و من رو با آیدی [@sadra_amlashi](https://twitter.com/sadra_amlashi) منشن کنید. متشکرم.