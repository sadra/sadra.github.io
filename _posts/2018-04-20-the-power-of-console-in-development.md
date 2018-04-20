---
layout: blog_post_rtl
title:  "قدرت پنهان console در توسعه جاوا اسکریپت"
description: "در این پست به امکانات و ابزاری که console جهت توسعه و دیباگ بهتر javascript به ما داده صحبت می‌کنم."
date: '2018-04-20'

tags:
- JavaScript
- console
- ES6

categories:
- جاوا اسکریپت
- کاربردی

cover: /assets/img/post/2018-04-20/javascript_console.png

author: Sadra
---


وقتی شروع به توسعه در یک تکنولوژی یا زبان خاص می‌کنید، در اغلب موارد غرق در ابزارهای مختلفی میشیم که اون بیرون بهمون پیشنهاد میشه یا باهاش مواجه میشیم(البته ابزارهایی که برای برای راحتی و سرعت بخشیدن به توسعه در همون اسکوپ ایجاد شدن). حتی درگیر جنگ با خودم و اون ابزارها میشم تا پیدا کنم کدومشون واقعا به درد کارم میخوره. در نهایت وقتی کارم تموم میشه، میفهمم کلی ابزار مختلف رو تست کردم، که هیچکدوم یا توی پروژه استفاده نشده، یا استفاده درست و کاملی ازشون نکردم، در عوضش پروژه رو هم نتونستم به TimeBox برسونم!

در طی این چندسالی که عمیقا به برنامه نویسی علاقه‌مند شدم، با ابزراهای مختلفی روبرو شدم که برای مدتها اونهارو نادیده میگرفتم، ابزاری ضروری، ساده و قدرمند، که در داخل همون تکنولوژی‌ها ایمپلمنت و امبد شده بود.

یکی از اون ابزارها که همه برنامه نویسها حتما یکبار باهاش روبرو شدن، و برنامه نویسای وب، که ابزار کاری هرروزه‌شونه، چیزی نیست جز **JavaScript Console** یا راحت‌تر بگیم `console.log()`. من باهاش کاملا آشنام، شما چطور؟

> در این پست قصد دارم در رابطه با امکانات و ابزارهایی که کنسول جاوااسکریپت بهمون میده صحبت کرده و باهم بررسیشون کنیم.

## کنسول یا console چیست؟

کنسول یه فیچر یا ابزار ساخته شده در دل جاوا اسکریپته که امروزه همه مرورگرها از اون به عنوان یه ابزار توسعه ضروری پشتیبانی میکنن. این ابزار کاربردی جاوااسکریپت با رابط کاربری‌ **shell** مانندی، به توسعه‌دهندگان این اجازه رو میده تا:

- خطا یا اخطاری که در  وب پیج بوجود اومده رو ببینن
- بتونن از طریق کامند‌ها و دستورات جاوااسکریپت با اون صفحه وب تعامل داشته باشن
- اپلیکیشن‌ها رو دیباگ کنن، مستقیما بتونن DOM هارو از طریق مرورگر بررسی کنن
- بتونن فعالیت شبکه رو تجزیه تحلیل کنند

بطور کلی، به ما کمک میکنه تا بتونیم در داخل خود مرورگر جاوا اسکریپت رو بنویسیم، مدیریت کرده و در نهایت اون رو مانیتور کنیم.

## استفاده از Console در مرورگر

می‌تونید با استفاده از کلیدها میانبری که در ادامه بهش اشاره میکنم‌، برای بالا آوردن کنسول در مرورگرتون استفاده کنین:

- برای Mozilla Firefox

{% ltr %}
  > **For MAC users:** *COMMAND + OPTION + K*
  >
  > **For Windows and Linux users:** *CTRL + SHIFT + K*
{% endltr %}

  - در Google Chrome

{% ltr %}
  > **For MAC users:** *COMMAND + OPTION + J*
  >
  > **For Windows and Linux users:** *CTRL + SHIFT + J*
  >
  > **For Windows users:** *F12*
{% endltr %}

  - در Safari

{% ltr %}
  > **For MAC users:** *COMMAND + OPTION + C*
{% endltr %}

  - در Opera mini

{% ltr %}
  > **For MAC users:** *COMMAND + OPTION + I*
  >
  > **For Windows and Linux users:** *CTRL + SHIFT + I*
{% endltr %}

  وقت که کنسول رو باز می‌کنید، با چیزی شبیه این که از پایین ابز شده باید مواجه بشید:

![Screaming from js](/assets/img/post/2018-04-20/console-0.png)

## بررسی APIهای ابزار کنسول

در مسیر توسعه، خیلی مهمه که هر توسعه‌دهنده‌ای با تمام زیبایی‌ها و قدرت کنسول آشنا شده باشه و حتما اونها رو در روند دیباگ کردن بکار ببنده. خب پس اجازه بدین یه سری از این امکانات و APIهای ضروری که کنسول در اختیارمون میگذاره بررسی کنیم.

### Console.log

احتمالا این پرکاربردترین چیزیه که تاحالا از کنسول دیده باشین. این API بهمون کمک میکنه تا رشته متنی که مد نظرمون هست رو به راحتی چاپ کنیم. به ازای هر آبجکتی که در log قرار میدین (و بینیشون `,` هست)، یه فاصله یا **space** چاپ میکنه.

```javascript
console.log( "The current time is:", Date.now());
```

اگه کنسول رو باز کنید و این تکه کد رو باهاش تست کنین، جوابی که میگیرن حتما چیزی مثل این خواهد بود:

![Screaming from js](/assets/img/post/2018-04-20/console-1.png)

این API عملکردش مثل `console.debug()` هست.

### Console.group

این متد بهمون کمک میکنه تا یه گروه از لاگ ساخته و بعد چاپ کنید. گروهی که میسازین همیشه باید بین `console.group()` و `console.groupEnd()` قرار بگیره. برای مثال اینطوری میتونین یه گروه از لاگ‌ها ایجاد کنین.

```javascript
function name(obj) {
      console.group('Country Profile');
      console.log('name: ', obj.name);
      console.log('continent: ', obj.continent);
      console.log('type: ', obj.type);
      console.groupEnd();
 }

name({"name":"Nigeria","continent":"Africa","type":"Democratic"});
```

و چیزی که در کنسول میبینید شبیه اینه:

![Screaming from js](/assets/img/post/2018-04-20/console-2.png)

وقتی که یه گروه لاگ داشتید که کلی آبجکت داره، میتونید بجای `console.group()` از `console.groupCollapsed()` استفاده کنید تا چیزی که لاگ میگیرید بصورت collapse یا بسته شده چاپ بشه. نتیجه‌ش میشه این.

![Screaming from js](/assets/img/post/2018-04-20/console-3.png)

### Console.trace

این متد کمک میکنه تا یه stack trace رو از نقطه‌ای که قرارش دادیم برامون چاپ کنه. این کد این امکان رو میده تا چیز‌های callشده یا execute میشن چاپ بشه، درواقع ایونت‌ها رو trackیا پیگری میکنه. اگه خواستین اطلاعات بیشتری راجع به console.trace کسب کنین، میتونین [این مقاله](https://hungryturtlecode.com/tips-tricks/console-trace/) رو مطالعه و یا [این وید](https://www.youtube.com/watch?v=QuO0UDkW2rk) رو مشاهده کنید. اما برای نمونه به این تکه کد نگاه کنید:

```javascript
function foo() {
    function bar() {
      console.trace();
    }
    bar();
}
foo();
```

و چیزی که درنهات برامون چاپ میشه خیلی جالبه:

![Screaming from js](/assets/img/post/2018-04-20/console-4.png)

### Console.table

یکی از جذابترین امکاناتی که من از کنسول دیدم، همین قضیه تیبل کردن لاگ‌هاست. این متد بهتون کمک میکنه تا یه object array رو بصورت تیبل نمایش بدید. به کد دقت کنید:

```javascript
let food = [
    { name: "Rice", class: "carbohydrate" },
    { class: "protein", name: "Beans" }
];
console.table(food);
```

 و این عصای جادویی، چیزی که در نهایت برامون چاپ خواهد کرد اینه:

![Screaming from js](/assets/img/post/2018-04-20/console-5.png)

### Console.error

این متد، رشته مارو بصورت یک error یا خطا نمایش میده. برخلاف console.log این متد، استایل و طرح متفاوتی شبیه error ها صفحهات وب داره (مثل اون خطاهای قرمز رنگ). همچنین هنگام چاپ اون پیام، استکی که اون پیام رو داره چاپ میکنه رو هم بهمون خبر میده. چرا زیاد حرف میزنم، بهتره خود مثال رو ببینیم:

```javascript
console.error("error: There is a terrifying error!");
```

و نتیجه:

![Screaming from js](/assets/img/post/2018-04-20/console-6.png)

متد `console.warn()` هم رفتار مشابه‌ای داره، با این تفاوت که استایل چاپ کردنش با error فرق میکنه و زرد رنگه.

![Screaming from js](/assets/img/post/2018-04-20/console-7.png)

### Console.count

این متد برای ما میشمره که که چندبار اون پیام (با لیبل مشابه) برامون چاپ شده. فرقی نمیکنه که این متد رو کجای کدتون و چندبار گذاشته باشین. هربار که لیبلی مشابه داشته باشه. برامون تعدادش رو چاپ میکنه. برای مثال:

```javascript
function printThe(city) {
    console.count(city + ' is printed.');
}
printThe("Tehran");
```

و نتیجه:

![Screaming from js](/assets/img/post/2018-04-20/console-8.png)

### Console.time و Console.timeEnd

با استفاده از متد `console.time()` ما میتونیم زمان اتفاق افتاده بین دو نقطه رو تریس کنیم و ببینیم چقدر طول کشیده. در یک صفحه میتونیم تا ۱۰هزار تایمر همزمان ایجاد کنیم. و از متد `console.timeEnd()` برای متوقف کردن تایمر و چاپ اون در لاگ استفاده میکنیم. توجه کنید که برای مشخص کردن تایمر، باید به عنوان پارامتر، یک لیبل یکتا پاس کنید. برای مثال توجه کنید به کد زیر:

```javascript
console.time('total');
console.time('init arr');
var arr = new Array(10000);
console.timeEnd('init arr');
for (var i = 0; i < arr.length; i++) {
  arr[i] = new Object();
}
console.timeEnd('total');
```

و نتیجه ای که در کنسول میبینیم:

![Screaming from js](/assets/img/post/2018-04-20/console-9.png)

### Console.clear

این هم که خیلی مشخصه، لاگ‌های پاک شده در کنسول رو پاک میکنه.

```javascript
clear();
```

با اینکه واضحه، ولی اینم نتیجه‌ش:

![Screaming from js](/assets/img/post/2018-04-20/console-10.png)

### Console.assert

این متد بهمون کمک میکنه تا یه جورای assert test بگیریم. شامل دو پارت میشه، اولی شرط ادعا و پارامترهای دوم و بعدی، متنی که قراره چاپ بشه. این متد موقعی اقدام به چاپ میکنه که شرط اداعای شما صحت نداشته باشه و درواقع نتیجه برابر `false` باشه. به این مثال زیبا توجه کنید:

```javascript
function lesserThan(a,b) {
  console.assert(a< b, {"message":"a is not lesser than b","a":a,"b":b});
}
lesserThan(5,6);
//and then
lesserThan(4,2);
```

نتیجه حاصل این میشه:

![Screaming from js](/assets/img/post/2018-04-20/console-11.png)

## دیگر امکانات معمولی که کنسول به ما می‌دهد

 کنسول کلی امکانات مختلف و جورواجور بهمون میده تا بتونیم تو جای جای مسیر توسعه ازش استفاده کنیم. چیزهایی مثل:

- Diagnosing and logging to console
- Time and monitor executions
- Handle exceptions and errors
- Monitor events
- Evaluate expressions
- Comparison of data objects

## در انتها

امکانات کاربرد یو بیشماری که کنسول بهمون میده، باعث میشه که همیشه از اون بعنوان یه ابزار مفید و صد البته ضروری در مسیر توسعه جاوا اسکریپت استفاده کنیم. بجای که اینکه با دهها ابزار که هیمنجوری در workspaceمون ریخته ور بریم، بهتره با چندتا ابزار کاربردی و قوی آشنا شده و توی اونها به قول معروف به درجه master برسیم.

اگه زیادی از اصطلاحات انگلیسی استفاده کردم که باعث شده خوندن در برخی جاها سخت بشه پوزش میخوام، ولی واقعا نمیشه برای بسیاری از این لغات تکنیکال معادل فارسی آورد،‌ و هیچی مثل خود همون عبارت انگلیسیش نمیتونه حق مطلب رو ادا کنه. شاید تو یه پست جدا گانه راجع به این موضوع صحبت کردم.

## منابع مفید

اگه دوست داشتین بیشتر راجع به امکانات و قدرت‌هایی که کنسول بهمون میده مطالعه کنید، در ادامه چندتا لینک آورد که امیدوارم بدردتون بخوره:

- [Google Developer Docs on Chrome Dev Tools](https://developers.google.com/web/tools/chrome-devtools/console/)
- [Mozilla Developer Network Web Docs](https://developer.mozilla.org/en-US/docs/Web/API/Console)
- [Digital Ocean Community Tutorials](https://www.digitalocean.com/community/tutorials/how-to-use-the-javascript-developer-console#working-with-the-console-in-a-browser)

اگه سوال یا موردی بود، مثل همیشه در [توییتر](https://twitter.com/sadra_amlashi) یا در [تلگرام](https://t.me/amlashi) میتونیم باهم در ارتباط باشیم. 😉🍷