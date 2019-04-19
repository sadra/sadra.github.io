---
layout: blog_post_rtl
title:  "امن کردن mongo در دو گام"
description: "در این پست سعی کردم در چند گام عملی مواردی رو ذکر کنم که بتونید بواسطه‌ی اونها دیتابیس Mongo خودتون رو امن‌تر کنید."
date: '2019-04-19'

tags:
- Mongo
- NodeJs
- Mongoose
- Security
- Docker
- داکر

categories:
- Mongo
- Database
- Docker

cover: /assets/img/post/2019-04-19/secure-mongo-cover.png

author: Sadra
---

## مقدمه

بعد از اتفاقی که دیروز برای [TAP30](https://tap30.ir/) اتفاق افتاد، تصمیم گرفتم برم سراغ دیتابیسای مونگوی خودم و اونارو بررسی کرده و کردنشیال هاشون رو ست کنم. (البته نگران نباشین، دیتاهای موجود روی دیتابیس من اصلا چیز قابل داری نبوده و همه‌ش دیتای تست واسه کارای تستیه 😬)

اگه نمیدونین چه اتفاقی رخ داده، خب منم حوصله‌شو ندارم براتون توضیح بدم، فقط بگم که ماجرا از لو رفتن نزدیک به ۶ میلیون دیتاسِت از یکی از دیتابیس‌هایی در ایران بوده که پورتش باز بوده و موتورهای جستجوگر دیتابیس اون رو ایندکس کرده بودن که [آقای باب دیاچنکو در این توییت](https://twitter.com/MayhemDayOne/status/1118764251051626501) ماجرای پیدا کردن اونارو توضیح داده:

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">More than 6.7M Iranian IDs exposed: names, SSN, phone numbers. Reported to Iranian CERT, but if you have a better contact please let me know. <a href="https://t.co/seZA4O7Aeu">pic.twitter.com/seZA4O7Aeu</a></p>&mdash; Bob Diachenko (@MayhemDayOne) <a href="https://twitter.com/MayhemDayOne/status/1118764251051626501?ref_src=twsrc%5Etfw">April 18, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

اطلاعات کامل راجع به این قضیه رو از  [این رشته توییت نیما اکبر پور](https://twitter.com/nima/status/1118814696017211392) هم می‌تونید دنبال کنید:

<blockquote class="twitter-tweet" data-lang="en"><p lang="fa" dir="rtl">اطلاعات بیش از ۶.۷ میلیون شناسه ایرانی شامل نام، شماره ملی و شماره تلفن منتشر شده. <a href="https://t.co/pIm7R4zNrO">https://t.co/pIm7R4zNrO</a></p>&mdash; Nima Akbarpour نیما (@nima) <a href="https://twitter.com/nima/status/1118814696017211392?ref_src=twsrc%5Etfw">April 18, 2019</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

از خود ماجرا که بگذریم بهتره بریم سراغ بحث خودمون. اولین اشتباهی که که سهوی هم بوده (انشالله)، قطعا این بوده که پورت مربوط به دیتابیس مورد نظر رو همینجوری باز گذاشته بودن! 😑

![secure-mongo-8](/assets/img/post/2019-04-19/secure-mongo-8.gif)

اولین گام اینه که پورت دیتابیستون رو قبل از هرچیزی ببندین لطفا. (مگر اینکه زمان خاصی بخواین روی کلاینت GUI دسکتاپی چیزی بخواین بهش وصل بشین، فقط تو همون بازه‌ی زمانی بزارین باز بمونه). پس:

## گام اول: بستن پورت‌های دیتابیس

برای اینکر فقط کافیه فایروال سرور لینوکسیتون رو فعال کرده و با دستور زیر پورت مورد نظر رو ببندین:

```shell
sudo ufw enable
sudo ufw deny 27017 #or any other port
```

اگه خواستین پورت رو برای دقایقی باز کنین، فقط کافیه اجازه دسترسی بدین بهش با همین نیم خط دستور:

```shell
sudo ufw allow 27017
```

## گام دوم: ایجاد سطح دسترسی با احراض هویت به دیتابیس

کار دومی که باید بکنین اینه که برای دیتابیستون در سطوح مختلف `یوزر` با نقش‌های مرطبت و لازمه ایجاد کنید. این کارو در چند مرحله انجام باهم انجامش میدم. قبل از شروع بگم که این آموزش رو بر اساس راه اندازی یک دیتابیس Mongo روی Docker قراره انجام بدیم:

### مرحله اول: راه اندازی کانترینر Mongo بر مبنای auth

اگر کانتینر مونگو رو با استفاده از تگ `--auth` راه اندازه کنید، این امکان رو میده به مونگو که خودشو آماده کنه برای سکیور شدن. پس، از دستور زیر استفاده می‌کنیم:

```shell
docker run -d --name CONTAINER_NAME -v VOLUME:/data/db -p PORT:27017 mongo --auth
```

و بعد، با دستوری پایین وارد شل mongo میشم که دستورات بعدی رو وارد کنیم:

```shell
docker exec -it CONTAINER_NAME mongo admin
```

### مرحله دوم: ایجاد کاربر admin

در این مرحله باید دیتابیسمون یه یوزر ادمین تعریف کنیم که دسترسی ادمینی به کل دیتابیس داره. اول از همه دیتابیس ادمین رو use می‌کنیم:

```shell
use admin
```

که بهمون جواب میده:

![secure-mongo-1](/assets/img/post/2019-04-19/secure-mongo-1.png)

و بعد بهش میگیم که یه یوزر admin با نقش `userAdminAnyDatabase` روی دیتابیس `admin` برامون ایجاد کن:

```shell
db.createUser(
	{
		user: "admin",
    	pwd: "PASS",
	    roles:[
	    	{
	    		role: "userAdminAnyDatabase",
	        db: "admin"
	    	}
	    ]
  	}
);
```

و حتما جواب میده که:

![secure-mongo-2](/assets/img/post/2019-04-19/secure-mongo-2.png)

که اوکی من یوزر ادمین رو براتون ساختم. بعدش باید بریم تست کنیم که ما میتونیم با این یوزر ادمینی که تعریف کردیم به سیستم وارد شیم. برای این کار کافیه از دستور `db.auth` استفاده کنیم:

```shell
db.auth("admin","PASS")
```

و اگه مشخصات رو درست وارد کرده باشیم، اونم در جواب باید بگه `1` که یعنی بفرمایین تو سرور من 😈:

![secure-mongo-3](/assets/img/post/2019-04-19/secure-mongo-3.png)

بعد از اینکه اینکارارو انجام دادیم. با دستور `exit` میایم بیرون از شل، و یه بار کانتیرنر رو ری استارت می‌کنیم تا با یوزر ادمین خودشو سینک کنه و بیاد بالا. دوباره بعد دوباره با همون دستوری که در مرحله اول گفتم وارد شل مونگو میشیم تا کارای بعدی رو انجام بدیم.

### مرحله سه: ایجاد کاربر با دسترسی محدود روی یک دیتابیس خاص

حالا وقتشه که یه کاربر با دسترسی `Read.write`برای اون دیتابیس مورد نظرمون ایجاد کنیم.

ابتدا ادمین رو use کنیم:

```shell
use admin
```

بعد با ادمین خودمون رو احراز هویت کنیم برای مونگو:

```shell
db.auth("admin","PASS")
```

حالا باید دیتابیس مورد نظرمون رو use کنم (مهم نیست که دیتابیس قبلا بوده یا قراره بعدا ساخته شه، فقط مطئن شین اسم دیتابیس مورد نظر رو درست وارد می کنین):

```shell
use my_database
```

دقیقا همینجا باید یه کاربر بسازیم برای این دیتابیس که به این دیتایس دسترسی داره و نقش اون هم در همون حد `Read/Write` هست. برای اینکار مثل تعریف یوزرِ ادمین عمل می‌کنیم:

```shell
db.createUser(
	{
		user: "USE_NAME",
	    pwd: "USER_PASS",
	    roles:[
	    	{
	    		role: "readWrite", #pay attention to role
	        db: "DATABASE_NAME"
	    	}
	    ]
  	}
);
```

و جواب شل هم به ما این خواهد بود عزیزان:

![secure-mongo-4](/assets/img/post/2019-04-19/secure-mongo-4.png)

و بعدش هم یه بار تست می‌کنیم تا مطسمئن شیم که یوزرمون به درستی مشخصاتش ست شده:

```shell
db.auth("my_user", "my_user_pass")
```

و نتیجه موفقت آمیز احراز هویتمون:

![secure-mongo-5](/assets/img/post/2019-04-19/secure-mongo-5.png)

خب حالا یه یوزر ساختیم که به دیتابیس `my_database` تنها و تنها دسترسی `Read/Write` داره، اون هم با کردنشیالی که براش ست کردیم.

### مرحله چهار: وصل شدن به دیتابیس mongo با استفاده از کاربر تعریف شده

از حالا به بعد حتی اگه پورت هم باز باشه، برای وصل شدن به دیتابیس باید از کردنشیال مورد نظر استفاده کرد، وگرنه حق دسترسی به دیتابیس رو ندارید.

برای تست این موضوع من از لایبرری [mongoose](https://www.npmjs.com/package/mongoose) استفاده کردم.

خب توی پروژه مورد نظر بعد از install کردن لایبرری توسط `npm` یا `yarn` اون رو به پروژه ایمپورت کنید:

```js
// Using Node.js `require()`
const mongoose = require('mongoose');
 
// Using ES6 imports
import mongoose from 'mongoose';
```

و بعدش باید برای وصل شدن به دیتابیس با استفاده از الگوی زیر از متد mongo.connect استفاده کنید:

```js
'mongodb://$USERNAME:$PASSWORD@localhost:$PORT/$DB_NAME?authMechanism=$HASH_MECHANISM'
```

یا:

```js
('mongodb://localhost:$PORT/$DB_NAME?authMechanism=$HASH_MECHANISM', {
	username: "$USERNAME",
  password: "$PASSWORD"
})
```

که من خودم حالت اول (که بهش میگن `string` مود) رو ترجیح میدم.

حتما حتما حتما، هواستون باشه که مکانیسم هش کردن مشخصات auth رو باید ست کنین. در حالت پیشفرض از مکانیسم `SCRAM-SHA-1` استفاده میشه مگه اینکه توی تنظیمات مونگوتون تغییراتی ایجاد کرده باشین. اگه اینکار رو نکنید قطعا با خطای معروف زیر برخورد می‌کنید:😱

```shell
MongoError: Authentication failed.
```

در نهایت کدی که مارو وصل میکنه به دیتابیس مونگومون اینه:

```js
mongoose.Promise = global.Promise;

async function run()
{
    await mongoose.connect('mongodb://my_user:my_user_pass@localhost:27017/my_db?authMechanism=SCRAM-SHA-1', 
    {
        useNewUrlParser: true,
        keepAlive: true,
        connectTimeoutMS: 15000, // Give up initial connection after 10 seconds
        socketTimeoutMS: 15000, // Close sockets after 45 seconds of inactivity
    });
    
    const Test = mongoose.model('Test', new mongoose.Schema({ name: String }));
    const doc = await Test.create({ name: 'Val' });
    console.log('Mongo connection Result: '+doc);
}

run().catch(error => console.error(error.stack));
```

و فقط کافیه کد اجرا بشه و ما با دیدن پیام زیر متوجه میشیم که اتصال امن به دیتابیسمون با موفقیت انجام شده (البته بدون یوزر پسورد هم می‌تونید تست کنید تا مطمئن بشید که بدون کردنشیال امکان اتصال بهش وجود نداره):

![secure-mongo-6](/assets/img/post/2019-04-19/secure-mongo-6.png)

و تِمااااام🧐

![secure-mongo-7](/assets/img/post/2019-04-19/secure-mongo-7.gif)

### راه ساده‌تر

ممکنه بپرسین راه ساده‌تری هم هست؟

باید بگم که راه‌های مختلفی رو تست کردم، ولی بهترین و مطمئن‌ترین راه (که فارغ از ورژن مونگو داکر و مونگوز باشه) همین راهی بود که بهتون گفتم. منتهی خود مونگو یه راه دیگه برای تعریف کاربر در هنگام اجرا گفته که متاسفانه من هروقت اجرا کردم نتونستم به دیتابیس وصل شم و مدام خطای  `uthenticaiton failed` میگرفتم. خب، راهی که مونگو پیشنهاد میده اینه:

```shell
$ docker run -d --network some-network --name some-mongo \
    -e MONGO_INITDB_ROOT_USERNAME=mongoadmin \
    -e MONGO_INITDB_ROOT_PASSWORD=secret \
    mongo

$ docker run -it --rm --network some-network mongo \
    mongo --host some-mongo \
        -u mongoadmin \
        -p secret \
        --authenticationDatabase admin \
        some-db
> db.getName();
some-db
```

ممنون میشم تست کنید و اگه به جوابی رسیدید تو کامنتا نتیجه‌تون رو اعلام کنید.

## منابع برای مطالعه بیشتر

اگه دوس دارین در مورد امنیت مونگو و حفظ اطلاعاتتون بیشتر بدونید تا می‌تونید لینک‌های زیر رو مطالعه کنید:

- پابلیشر [mongoaudit](https://medium.com/mongoaudit) کلی مقاله خوب و مفید درباره امنیت مونگو داره
- امنیت در دیتابیس مونگو هست: [لینک ۱](https://docs.mongodb.com/manual/security/)، [لینک ۲](https://docs.mongodb.com/manual/administration/security-checklist/)، [لینک ۳](https://medium.com/@matteocontrini/how-to-setup-auth-in-mongodb-3-0-properly-86b60aeef7e8)، [چک لیست](https://medium.com/@htayyar/mongodb-security-checklist-9938cc5f07c9) امنیت مونگو که باید رعایت بشه
- سطوح کاربری و اصولا کار کردن با کاربر: [لینک ا](https://docs.mongodb.com/manual/core/security-users/)، [لینک ۲](https://docs.mongodb.com/manual/tutorial/manage-users-and-roles/)
- امنیت در مونگوی داکر: [لینک ۱](https://medium.com/@MaxouMask/secured-mongodb-container-6b602ef67885)
- فایروال‌ها در لینکوس: [لینک۱](https://www.cyberciti.biz/faq/how-to-setup-a-ufw-firewall-on-ubuntu-18-04-lts-server/)، [لینک ۲](https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-ubuntu-18-04)

## جمع بندی

این پست جمع بندی خاصی نداره، جز اینکه هواستون باشه پورت‌هاتون رو بی دلیل باز نگذارید 🤦‍♂️ و دیتابیس با اطلاعات مهم رو روی تنظیمات پیشفرض بالا نیارین! حتما موارد امنیتی رو رعایت کرده و کردنشیال‌ها رو اعمال کنید.

لطفا اگه راه بهتر یا روش‌های دیگه‌ای بلدین، در کامنت‌ها با بقیه به اشتراک بگذارین 🙏

اگه سوال یا موردی بود، مثل همیشه در توییتر یا در تلگرام میتونیم باهم در ارتباط باشیم. 😉🍷
