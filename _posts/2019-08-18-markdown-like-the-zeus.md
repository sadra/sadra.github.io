---
layout: blog_post_rtl
title:  "مثل زئوس مارکداون بنویسیم"
description: "در این پست درباره چندتا تکنیک بدردبخور برای نوشتن مارکداون صحبت کردم که باعث میشه مثل یه خدا مارکداون بنویسید."
date: '2019-08-18'

tags:
- Markdown
- Editor
- مارکداون

categories:
- Tools

cover: /assets/img/post/2019-08-18/markdown-like-the-zeus-cover.jpg

author: Sadra
---

## مقدمه

اگه شما یه توسعه دهنده هستن، خب خداروشکر، پس تا الان حتما برای یک بار هم که شده با یکی از ادیتورهای Markdown کار کردین.

زبان (نوشتاری) مارکداون توسط Github، Medium، خیلی از سرویس‌های تیکتینگ، سرویس‌های وبلاگ‌دهی، ابزارهای کامنت گذاری (حتی توی همین وبلاگ) پشتیبانی میشه. دونستن سینتکس Markdown می‌تونه به شما در نوشتن (داکیومنت، کامنت یا هر مطلبی) کمک بزرگی کنه و کاری کنه که مثل یه توسعه دهنده‌ی حرفه‌ای بنظر بیایید.

روی اینترنت پره از بلاگ پست‌ها و چیت‌شیت‌های مختلف که شما می‌تونید با مطالعه اون‌ها در مارکداون نویسی مهارت خوبی پیدا کنید (مثلا این [لینک](https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet)). توی این پست وبلاگ قرار نیست راجع به اینا صحبت کنم، بلکه می‌خوام چندتا تکنیک کوچیک ولی باحال رو بهتون بگم که کمتر جایی روی وب پیداش می‌کنید و ممکنه بدردتون بخوره.

من برای نوشتن مستندات Markdown از ادیتور Typora استفاده می‌کنم. قبلا در [توییتر](https://twitter.com/sadra_amlashi/status/1115300664865972224?s=20) گفته بودم که واسه Typora یه تم RTL به نام [Middle-East](http://theme.typora.io/theme/Middle-East/) توسعه دادم، می‌تونید از Typora بعنوان یه ادیتور آفلاین تروتمیز مارکداون استفاده کنید که هم RTL رو ساپورت می‌کنه هم می‌تونید با فرمت‌های مختلف (مثل PDF, HTML و حتی EPub) ازش خروجی بگیرید.

<blockquote class="twitter-tweet"><p lang="fa" dir="rtl">مایلم به اطلاعتون برسونم که بالاخره تم Middle-East مرج شد توی تم‌های <a href="https://twitter.com/Typora?ref_src=twsrc%5Etfw">@Typora</a>😍<br>از الان می‌تونید بصورت Makrdown با استایل <a href="https://twitter.com/BearNotesApp?ref_src=twsrc%5Etfw">@BearNotesApp</a> در تایپورا به <a href="https://twitter.com/hashtag/%D9%81%D8%A7%D8%B1%D8%B3%DB%8C?src=hash&amp;ref_src=twsrc%5Etfw">#فارسی</a> و <a href="https://twitter.com/hashtag/%D8%B1%D8%A7%D8%B3%D8%AA_%DA%86%DB%8C%D9%86?src=hash&amp;ref_src=twsrc%5Etfw">#راست_چین</a> رایگان، ساده و تمیز بنویسید😎<br>استار <a href="https://twitter.com/hashtag/%DA%AF%DB%8C%D8%AA%D9%87%D8%A7%D8%A8?src=hash&amp;ref_src=twsrc%5Etfw">#گیتهاب</a> و <a href="https://twitter.com/hashtag/%D8%B1%DB%8C%D8%AA%D9%88%DB%8C%DB%8C%D8%AA?src=hash&amp;ref_src=twsrc%5Etfw">#ریتوییت</a> مزید امتنان است🥰<a href="https://t.co/WggeJhVopb">https://t.co/WggeJhVopb</a></p>&mdash; Sadra Amlashi (@sadra_amlashi) <a href="https://twitter.com/sadra_amlashi/status/1115300664865972224?ref_src=twsrc%5Etfw">April 8, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## لیست ترتیبی یا همون Order List

همونطور که می‌دونید، لیست ترتیبی رو با سیسنتکس زیر می‌نویسیم:

```
1. Item One
2. Item Two
3. Item Three
```

که قائدتا باید همچین چیزی برامون چاپ بشه

1. Item One
2. Item Two
3. Item Three

و اما... تاحالا شده یه لیست خیلی بند بالا بنویسین و بعد یهو متوجه شید ای بابا یه آیتم رو اون وسطا جا انداختین!؟ حتما می‌تونید تصور کنید چقدر آزار دهنده‌ست که برگردین آیتم رو اضافه کنید و تموم شماره گذاری لیست رو دوباره در ادامه بازنویسی و مرتب کنید 😩

اما خب، شما اصلا مجبور نیستین اینکارو بکنید!!! مارکداون اصلا به شماره گذاری شما توجهی نمیکنه!

![markdown-like-the-zeus-1](/assets/img/post/2019-08-18/markdown-like-the-zeus-1.jpg)

تا موقعی که شما یه لیست داشته باشین و کنار آیتم‌های لیستتون شماره گذاری کرده باشین، موقع نمایش دادن متن خود مارکداون اون رو بصورت یه لیست بازشماری شده render کرده و نمایش میده.

لیست زیر رو ببینید:

```
1. Item One
2. Item Two
3. Item Three

1. Item One
8. Item Two
5. Item Three

1. Item One
2. Item Two
524. Item Three
```

فرقی نمی‌کنه چی نوشتین، در هر سه حالت چیزی که برامون چاپ می‌کنه اینه:

1. Item One
8. Item Two
52. Item Three

ازتون می‌خوام اگه فکر می‌کنید من حقه‌ي خاصی استفاده می‌کنم یا توی ترتیب شماره‌ها دستکاری کردم، برید و [فایل md همین پست](https://raw.githubusercontent.com/sadra/sadra.github.io/source/_posts/2019-08-18-markdown-like-the-zeus.md) رو ببینید. تنها چیزی که برای مارکداون مهمه اینه که آیتم اول حتما از **«یک»** شروع شده باشه.

بعضیا کلا برای همه آیتم‌ها عدد ۱ رو میگذارن. اما اگه شما خیلی روی ترتیب حساسین و اون اتفاق ناگوار براتون پیش اومده، فقط کافیه آیتم رو بهش اضافه کنید و همون عدد آیتم بعدی رو بهش بدید. (مثلا قبل آیتم شماره ۹ باید چیز دیگه‌ای اضافه می‌کردین، اوکی به این ترتیب لیست رو بازنویسی کنید: *۸. آیتم قبلی*، **۹. آیتم فراموش شده**، *۹. آیتم بعدی*).

## لیست وظایف

لیست وظافه یا همو Task Lists در مارکداون به شما کمک میتونه تا بتونین یه لیست به همراه چک باکس درست کنین. برای نوشتن یک چک لیست ابتدا باید یه دَش `-` و بعد یه براکت به همراه یک اسپس `[ ]` پشت هر آیتم لیستتون بگذارید. اگر اون آیتم لیستتون انجام شده بود باید یه `x` بین دو تا براکت بگذارید `[x]`.

مثلا این یه لیست وظیفه هست که باید [God](https://twitter.com/TheTweetOfGod) انجامشون بده:

```
- [x] Send an email to Hera
- [ ] Find Loki on earth
- [x] Help Thor to find his hammer
- [ ] Save the world
```

که در نهایت چیزی که باید در خروجی مارک داون چاپ شه به این صورت هست:


- [x] Send an email to Hera
- [ ] Find Loki on earth
- [x] Help Thor to find his hammer
- [ ] Save the world
{: style='list-style-type: none'}

البته امیدواریم زئوس تا قبل ددلاین به تسک‌هاش برسه 🤪

![markdown-like-the-zeus-2](/assets/img/post/2019-08-18/markdown-like-the-zeus-2.jpg)

## لینک دادن به سر تیترها

یکی از مواردی که خیلی به درد می‌خوره (علی الخصوص در داکیومنت نوشتن) لینک دادن به سر تیترهاست. پردازشگرهای مارکداون از custom IDها در سر تیترها پشتیبانی می‌کنن. البته اگه شما هیچ کاستم آی دی واسه اون سرتیتر تعریف نکرده باشین، خودش بصورت اتوماتیک یه ID واسش ایجاد می‌کنه. برای اینکه بتونید یه کاستم ID برای سر تیتر مورد نظرتون درست کنید، کافیه ID رو بین دوتا براکت (با رعایت اینکه تموم حروف کوچیک باشه و بین کلمات هم فقط از `-` استفاده شده باشه) به همراه یک `#` بنویسید.

```
### The Odin's Heading {#custom-odin-heading}
```

چیزی که ما در مرور گر میبینیم اینه:

### The Odin's Heading {#custom-odin-heading}

که بعد از چاپ شدن بصورت HTML همچین چیزی در سورس کد صفحه قرار گرفته میشه:

```html
<h3 id="custom-odin-heading">The Odin's Heading</h3>
```

خب حالا اگه بخوایم به این تیتر لینک بدیم چطور میشه؟ فقط کافیه موقع نوشتن یه لینک در مارکداون، بجای لینک در داخل پرانتزها، ID تیتر مورد نظر به همراه یک `#` رو بنویسیم. که اینجوری میشه:

```
[The Odin's Heading](#custom-odin-heading)
```

و چیزی که بصورت HTML پردازش میشه:

```html
<a href="#custom-odin-heading">The Odin's Heading</a>
```

و در نهایت چیزی که برای ما در مرورگر نمایش داده میشه اینه:

<a href="#custom-odin-heading">The Odin's Heading</a>

و اگه روش کلیک کنید، میبینید که میپرسه روی سر تیتری که در بالاتر چاپ کرده بودیم.

البته شما می‌تونید بصورت full URL هم به اون تیتر مورد نظر ارجاع بدید:

```
[The Odin's Heading](https://isapanah.com/2019-08-18-markdown-like-a-god#custom-odin-heading)
```

## پانویس

یکی از چیزهای که خیلی ها فکر می‌کنن مارکداون پشتیبانی کنه، استفاده از پانویس یا همون Footnote هست. پانویس‌ها بهتون اجازه می‌دن که به یه شرح یا توضیحی اجمالی در خارج از متن اصلی ارجاع داده بشه. این پا نویس‌ها عموما با شماره گذاری‌ها بصورت ترتیبی مشخص می‌شن.

برای اینکه بتونید یه پانویس بنویسید ابتدا لازمه در میانه‌ی پارگراف (اونجایی که میخواهید به پانویس ارجاع بدید) با استفاده از براکت که در داخل اون `^` و بعدش عدد رفرنس رو مشخص کردین لینک کنید `[^1]`.

نکته‌ای این قضیه اینجاست که می‌تونید بصورت ID هم به مرجع مورد نظرتون لینک کنید، یعنی بجای عدد از یه عبارت لاتین، با حروف کوچک و بدون هیچ اسپیس یا tab اضافی استفاده کنید `[^to-id]`.

در ادامه، هرجایی که دلتون خواست می‌تونید پانویس‌هاتون رو بنویسید (توجه کنید که لازم نیست پانویس‌ها در انتهای انتهای متنتون باشه). می‌تونید پانویس رو در انتهای یک سکشن، یا حتی یه پارگراف بیارید. 

برای ذکر کردن پانویس هم نیازه که در ابتدا عدد یا ID رنفرنس رو به همراه یک `^` نوشته بعدش با یه `:` شرح مورد نظرتون رو بنویسید.

به مثالی که در ادامه میاد توجه کنید:

```
Zeus (/zjuːs/;[^1] Ancient Greek: Ζεύς, Zeús [zdeǔ̯s])[^book] is the sky and thunder god in ancient Greek religion, who rules as king of the gods of Mount Olympus. His name is cognate with the first element of his Roman equivalent Jupiter. His mythologies and powers are similar, though not identical, to those of Indo-European deities such as Jupiter, Perkūnas, Perun, Indra and Thor.[^3]

[^1]: The sculpture was presented to Louis XIV as Aesculapius but restored as Zeus, ca. 1686, by Pierre Granier, who added the upraised right arm brandishing the thunderbolt. Marble, middle 2nd century CE. Formerly in the 'Allée Royale', (Tapis Vert) in the Gardens of Versailles, now conserved in the Louvre Museum (Official on-line catalog)

[^book]: Larousse Desk Reference Encyclopedia, The Book People, Haydock, 1995, p. 215.

[^3]: Oxford English Dictionary, 1st ed. "Zeus, n." Oxford University Press (Oxford), 1921.
```

و چیزی که چاپ میشه در نهایت اینه:

Zeus (/zjuːs/;[^1] Ancient Greek: Ζεύς, Zeús [zdeǔ̯s])[^book] is the sky and thunder god in ancient Greek religion, who rules as king of the gods of Mount Olympus. His name is cognate with the first element of his Roman equivalent Jupiter. His mythologies and powers are similar, though not identical, to those of Indo-European deities such as Jupiter, Perkūnas, Perun, Indra and Thor.[^3]

![markdown-like-the-zeus-3](/assets/img/post/2019-08-18/markdown-like-the-zeus-3.jpg)

[^1]: The sculpture was presented to Louis XIV as Aesculapius but restored as Zeus, ca. 1686, by Pierre Granier, who added the upraised right arm brandishing the thunderbolt. Marble, middle 2nd century CE. Formerly in the 'Allée Royale', (Tapis Vert) in the Gardens of Versailles, now conserved in the Louvre Museum (Official on-line catalog)

[^book]: Larousse Desk Reference Encyclopedia, The Book People, Haydock, 1995, p. 215.

[^3]: Oxford English Dictionary, 1st ed. "Zeus, n." Oxford University Press (Oxford), 1921.

البته شما نمی‌تونید لینک پانویس‌هایی که من اینجا در ادامه متن آورد رو ببینید، و پانویس‌ها در انتهای این پست بلاگ چاپ میشن.

نکته‌ای که باید به اون واقف باشید اینه که درسته که شما با ID به پانویس مورد نظر لینک میدید (مثل رفرنس دوم که به آی‌دی book بود) اما موقع رندر شدن صفحه چیزی که نمایش داده میشه عددِ ترتیبی که پانویس هست که در اینجا هم بصورت اتوماتیک خود مارکداون عدد‌های پانویس‌ها رو مرتب و چاپ می‌کنه. 

## هایلایت کدها‭

خب یکی از آیتم‌هایی که برنامه نویس‌ها خیلی خیلی در مارکداون استفاده می‌کنن اسنیپد کردن یه کد یا سینتکسه. خب برای اینکه یه تیکه کد رو اسنیپد کنیم اینجوری مینویسیم:

````
​```
hollyMotherFucntion(params)
{
	console.log("Shift it, shift it in Forward!")
}
​```
````

که نتیجتا چیزی که چاپ میکنه اینه:

```
hollyMotherFucntion(params)
{
	console.log("Shift it, shift it in Forward!")
}
```

امروز دیگه اکثر ادیتور ها از هایلایت کدها پشتیبانی می‌کنن. برای اینکه بتونیم یه کد خشگل توی پست داشته باشیم بعد از اون ۳تا backtick فقط کافیه اسم اون زبان رو بیاریم، مثلا در اینجا من باید بنویسم javascript:

````
​```javascript
hollyMotherFucntion(params)
{
	console.log("Shift it, shift it in Forward!")
}
​```
````

که باید همچین چیزی واسمون چاپ کنه:

```javascript
hollyMotherFucntion(params)
{
	console.log("Shift it, shift it in Forward!")
}
```

اما، آیا میدونستید که شما می‌تونید از عبارت `diff` هم برای زبان استفاده کنید!؟ حتما میپرسین به چه کاری میاد!

![markdown-like-the-zeus-4](/assets/img/post/2019-08-18/markdown-like-the-zeus-4.jpg)

تاحالا شده که بخواین توی پست یا داکیومنت نشون بدین که قبلا اینجوری بوده، این خط حذف شده و بجاش این اضافه  شده یا این تغییر در اون قطعه کد صورت گرفته؟

با استفاده از `diff` و دوتا علات **+**  و **-** پشت اون خط از کد مورد نظر، میتونید تغییرات یا همون different صورت گرفته رو نمایش بدید. اینجوری:

````
​```diff
hollyMotherFucntion(params)
{
-	console.log("Shift it, shift it in Forward!")
+	console.log("Shift it, shift it in Reverse!")
}
​```
````

که در نهایت این چاپ میشه:

```diff
hollyMotherFucntion(params)
{
-	console.log("Shift it, shift it in Forward!")
+	console.log("Shift it, shift it in Reverse!")
}
```

استفاده از خیلی بهتون در نوشتن داکیومنت یا پست‌های آموزشی کمک می‌کنه. باعث میشه که افراد بهتر بتونن کدهاتون رو دنبال کنن و ببینین واقعا چه اتفاقی یهویی وسط کدها پیش اومده. استفاده از `diff` رو هیچوقت فراموش نکنید.

## جمع بندی

این چندتا نکته و ترفند در استفاده از مارکداون بود که امیدوارم به تو نوشتن مطالب و داکیومنت‌ها کمکتون کنه و متن‌هاتون حرفه‌ای بنظر بیاد. یا همونی که در تیتر پست گفتم،‌ مثل زئوس مارکداون بنویسید 😇

اگر شما هم ترفندی یا نکته‌ای می‌دونید که شاید به درد کسی بخوره، می‌تونید در انتهای همین پست کامنت کنید.😍

اگه سوال یا موردی بود، مثل همیشه در توییتر یا در تلگرام میتونیم باهم در ارتباط باشیم. 😉🍷

**پانویس**
===