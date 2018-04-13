---
layout: blog_post_rtl
title:  "دسترسی به Nested Objectها در JavaScript"
description: "دسترسی امن و راحت به Nested Objectها در زبان JavaScript"
date: '2017-11-27'

tags:
- JavaScript
- ES6

categories:
- جاوا اسکریپت
- آموزش

cover: /assets/img/post/2018-04-13/undefined_access.jpg

author: Sadra
---

همونطور که احتمالا خیلی‌هاتون بامن هم‌عقیده هستین، جاوا اسکریپت زبان در دسترس، جالب و گاهی اوقات فوق‌العاده‌ایه. اما بعضی چیزا توی جاوا اسکریپت هست که واقعا عجیبه و غریبه! یکی از اون چیزا، وقتیه که سعی میکنیم یه آبجک نستد شده رو بگیریم و یهو این خطا به ما برمیگرده:

> **Cannot read property 'foo' of undefined**

خیلی وقتایی که داریم در پروژه‌ جاوا اسکریپت کد میزینم، لازمه که از نستد آبجکت‌ها استفاده کرده و دیتا رو بطور امن دریافت کنیم، نه اینکه ازین خطاهای مزخرف بده و یکساعت بگردی ببینی کجای کارو اشتباه رفتی و چه مشکلی بوجود اومده.

میخوایم ببینیم برای حل این مشکل چه کارایی میشه انجام داد، بیایید با یه مثال بریم جلوو، فرض کنین همچین آبجکتی داریم:

```javascript
const user = {
    id: 101,
    email: 'sadra@dev.com',
    personalInfo: {
        name: 'Sadra',
        address: {
            line1: 'kakh square',
            line2: '5 azar st',
            city: 'gorgan',
            state: 'GOLESTAN'
        }
    }
}
```

برای دسترسی به اسم یا شهر userمون اینجوری مینویسیم:

```javascript
const name = user.personalInfo.name;
const userCity = user.personalInfo.address.city;
```

خب این ساده و مستقیمه.

اما یه موقع‌هایی اصلا آبجکت user فیلدی به نام personalInfo نداره.  (الالخصوص وقتی داری با دیتابیس‌های non-relational مثل mongo کار میکنی). اونوق آبجکتت این شکلی میشه:

```javascript
const user = {
    id: 101,
    email: 'jack@dev.com'
}
```

خب حالا وقتی تلاش میکنی که به مقدار name دسترسی پیدا کنی، با خطای *Cannot read property 'name' of undefined* مواجه میشی.

```javascript
const name = user.personalInfo.name; // Cannot read property 'name' of undefined
```

این برای اینه که سعی میکنیم به آبجکت `name` دسترسی پیدا کنیم، درحالی که حتی وجود خارجی نداره!

معمول‌ترین راه برای حل این مشکل که خیلی‌ها هم استفاده میکنن اینه:

```javascript
const name = user && user.personalInfo ? user.personalInfo.name : null;
// undefined error will NOT be thrown as we check for existence before access
```

خب اینم یه راهه، ولی تا موقعی که آبجکتت مثل چیزی که بالا مثال زدیم ساده باشه. اگه یه آبجکت تودرتو تا ۵ ۶ مرحله داشته باشیم، اونموقع دستور شرطی که مینوسیم یه چیز احمقانه و عجیب قریبی مثل این میشه:

```javascript
let city;
if (
    data && data.user && data.user.personalInfo &&
    data.user.personalInfo.addressDetails &&
    data.user.personalInfo.addressDetails.primaryAddress
   ) {
    city = data.user.personalInfo.addressDetails.primaryAddress;
}
```

اینجا چندتا راه حل هست تا بتونیم این قضیه رو به درستی هندل کنیم.

## الگوی دسترسی به نستد آبجکتِ Oliver Steele

این یکی از محبوب‌ترین روش‌های دسترسی به یک شی نستد هست که کار رو کلی **ساده** و **تمیز** میکنه. من این راه حل رو خیلی وقت پیش توی  **[Stackoverflow](https://stackoverflow.com/a/4034468/5330668)** پیدا کرده بودم و بنظرم خیلی حرفه‌ای میومد.

```javascript
const name = ((user || {}).personalInfo || {}).name;
```

با این notationای که استفاده کردیم، عمرا دیگه به خطای *Cannot read property 'name' of undefined* بربخوریم 😬.

اگه بخوام روش کنم که دقیقا چیکار کردیم، باید بگم داریم چک میکنیم اگر آبجکت `user` وجود نداره یه آبجکت خالی همینجوری رو هوا بساز و اگه وجود داشت، مرحله مرحله جلو میریم تا به property مورد نظرمون برسیم. و این باعث میشه که **تاهیچوقتِ تاریخ، به خطایِ نبودنِ شیِ موردِ نظر** بر نخوریم!

اما خب، متاسفانه با این روش نمیتونین به **nester array object** دسترسی داشته باشین!

![Screaming from js](/assets/img/post/2018-04-13/screaming_from_js.gif)

## استفاده از Array Reduce برای دسترسی به آبجکتی از آرایه‌ی نستد شده!

متد Array Reduce یه راه قدرتمند و امن برای دسترسی به همچین مواردی هست. به مثال توجه کنید.

``` javascript
const getNestedObject = (nestedObj, pathArr) => {
    return pathArr.reduce((obj, key) =>
        (obj && obj[key] !== 'undefined') ? obj[key] : undefined, nestedObj);
}

// pass in your object structure as array elements
const name = getNestedObject(user, ['personalInfo', 'name']);

// to access nested array, just pass in array index as an element the path array.
const city = getNestedObject(user, ['personalInfo', 'addresses', 0, 'city']);
// this will return the city from the first address item.
```

## کتابخونه Typy

و در نهایت، این کتابخونه میتونه حلال همه مشکلاتتون باشه. 

این کتابخونه علاوه به اینکه بهتون کمک میکنه تا به راحتی و با خیال راحت به هر آبجکت نستدی دسترسی پیدا کنید، بلکه کلی امکانات دیگه هم در ختیارتن میگذاره. این ابزار کاربردی از طریق کتابخونه npm در دسترس شماست - [Typy](https://github.com/flexdinesh/typy)

خب، برای همون مثال بالا اگه بخواییم از Typy استفاده کنیم، اینجوری میشه

```javascript
import t from 'typy';

const name = t(user, 'personalInfo.name').safeObject;
const city = t(user, 'personalInfo.addresses[0].city').safeObject;
// address is an array
```

## کلام آخر

کلی راه حل مختلف برای حل این مشکل وجود داره که میتونید در [این کامنت](https://stackoverflow.com/a/41532415/5330668) ۱۰ تاشونو ببینین، ولی خب من سعی کردم به اون ۲ ۳ تایی که واقعا بدرد بخور بودن بپردازم.

البته یه سری لایبرری دیگه هم هستن که خیلی میتونن تو این قضیه کمکتون کنن، کتابخونه‌هایی مثل Lodash و Ramda.

اما در پروژه‌‌های که کدهاتون لازمه در سبک‌ترین حالت ممکنن قرار بگیره (مثلا پروژه‌های front-end) و الالخصوص جاهایی که به یکی دو تا ازین متد‌ها بیشتر احتیاج ندارین، سعی کنین شخصا کد و متد موردنیازتون رو بنویسین و خودتون رو همیشه از شر دیپندنسی‌هاو لایبررهای عجیب غریب همیشه در امان نگهدارید 😎.

اگه سوال یا موردی بود، مثل همیشه در [توییتر](https://twitter.com/sadra_amlashi) یا در [تلگرام](https://t.me/amlashi) میتونیم باهم در ارتباط باشیم. 😉🍷
