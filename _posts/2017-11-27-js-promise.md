---
layout: blog_post_rtl
title:  "Promise تابحال هیچوقت انقدر آسون نبوده"
description: "در این پست قصد دارم به ساده‌ترین روش ممکن راجع به Promiseها و اینکه واقعا چطوری باید ازشون استفاده کرد صحبت کنم."
date: '2017-11-27'

tags:
- Prmise
- RxJs
- JavaScript
- ES6

categories:
- جاوا اسکریپت
- آموزش

cover: /assets/img/post/2017-11-27/js-promise-cover.png

author: Sadra
---

## مقدمه

خیلی وقت پیش در حین انجام یک پروژه در NodeJs نیاز پیدا کردم که چندتا متد رو بصورت متوالی و nested استفاده کنم، و متد ها هم به این صورت بود که باید صبر میکردن تا داخلی ترین متد انجام بشه و بعد متد خارجی با استفاده از نتیجه متد داخلی وظیفه خودش رو انجام بده، و این توالی تا آخرین متد خارجی ادامه داشت. (تا جایی که یادم میاد تا ۴ مرحله نست شده بود.)

![Nested Blocks](/assets/img/post/2017-11-27/js-promise-nested-blocks.jpg)

جدا از این مورد، مشکل دیگه ای که وجود داشته این بود که اولا این متد‌ها Async بودن، و دوما اینکه ممکن بود نتیجه sucessfull یا failed بشه. خلاصه به هر کثافتی که بود کارو انجام دادم.
چند وقت بعد [مهدی](http://moshtaghi.ir/) بهم گفت که میتونی از **Promise** برای این معضل استفاده کنی. و اینجوری بود که زندگی زیبا می‌شود!

![Yes](/assets/img/post/2017-11-27/js-promise-yeah.gif)

از چندتا از دوستان شنیدم که هنوز پرامیس رو درک نکردن و نمیدونن که فرقش با چیزای دیگه مثل Callback چیه. در این پست قصد دارم به ساده‌ترین روش ممکن راجع به Promiseها و اینکه واقعا چطوری باید ازشون استفاده کرد صحبت کنم. پس حرف رو کوتاه کنیم و بریم سر اصل مطلب.

در ادامه فهرستی از سرفصل مطالبی که میخوام در این پست صحبت کنم با لینک به همون تیتر قرار دادم.

*   [شرح](#subject)
*   [ساختن یک Promise](#how-to-create-a-Promise)
*   [استفاده از Promise](#how-to-user-promise)
*   [زنجیره Promiseها](#chain-of-promises)
*   [پرامیس‌ها Asynchronous هستند](#asynchronous-promise)
*   [پرامیس در ES5، ES6, ES7](#promises-in-variety-of-js)
    *   [ES5 - در اکثر مرورگرها پشتیبانی میشه](#promise-in-es5)
    *   [ES6 - در مرورگرهای مدرن، و NodeJs v6 پشتیبانی میشه](#promise-in-es6)
    *   [ES7 - استفاده از Async Await سینتکس رو قابل خوندن میکنه](#promise-in-es7)
*   [چرا و چه موقع از Promise استفاده کنیم؟](#when-and-why-promises)
*   [دنیا قبل از پرامیس: Callback](#callback)
*   [فرار از Callback Hell](#scape-from-callback-hell)
*   [عضو جدید این خانواده: Observables](#observable)
*   [نتیجه‌گیری](#conclusion)

<h2 id="subject">شرح</h2>

بزارین همین اول کار، پرامیس رو با طرح یک مثال براتون ساده کنم:

> فرض کنید یه **بچه** هستید. و **مادرتون** بهتون **قول میده** که هفته دیگه یه **گوشی جدید** براتون بخره.

شما اولا نمی‌دونید که آیا هفته دیگه یه گوشی براتون میخره یا نه؟ ثانیا اینکه آیا واقعا مادرتون برای شما یه گوشی جدید میخره؟ ثالثا ممکنه اصلا اون هفته از دستتون ناراحت باشه و کلا بیخیال خرید گوشی بشه!

این کامل‌ترین مثالی بود که از Promise می‌تونستم بزنم. هر پرامیس ۳وضعیت داره:

1. پرامیس در حال بررسیه **Pending**: شما نمی‌دونید که آیا هفته دیگه براتون گوشی میخره یا نه.
2. پرامیس حل شده **Resolved**: مادرتون واقعا یه گوشی جدید براتون خریده.
3. پرامیس رد شده **Rejected**: مادرتون براتون گوشی جدید نخریده، چون واقعا از دستتون ناراحت بوده.

حالا که با مفهوم و حالت‌های پرامیس آشنا شدید، بریم ببینم که چجوری میشه ازش استفاده کرد.

<h2 id="how-to-create-a-Promise">ساختن یک Promise</h2>

اجازه بدید در همین اولین قدم، چیزهایی که بالا گفتیم رو به کد جاوا اسکریپت تبدیل کنیم.

```javascript
/* ES6 */
let isMomHappy = false;

//Promise
let willGetNewPhone = new Promise(
  function(resolve, reject) {
    if(isMomHappy) {
      let phone = {
        brand: 'iPhone X',
        color: 'gray'
      };
      resolve(phone); //fulfilled
    } else {
      let reason = new Error('Mom is angry.')
      reject(reason); //reject
    }
  }
);
```

فکر میکنم که خودش به اندازه کافی گویا هست.

1. ما یک متغییر بولین بنام `isMomHappy` داریم، که برامون مشخص میکنه آیا مامان OK هست واسه خریدن یا نه.

2. یه پرامیس هم بنام `willGetNewPhone` داریم. که این پارمیس، هم میتونه حل `Resolved` بشه (مامان برات یه گوشی جدید بخره)، هم میتونه رد `Rejected` بشه (مامان از دستت عصبانیه، و عمرا برات گوشی جدید بخره).

   یک syntax استاندارد برای نوشتن `Promise` جدید وجود داره که بر اساس [داکیومنت MDN](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Promise)، این سینتکس اینجوریه:

```javascript
//Promise syntax looks like this
new Promise( /* executor */ function(resolve, reject) { ... } );
```

   تنها چیزهایی که لازمه بخاطر بسپارین این که، وقتی نتیجه کار موفقیت‌آمیزه، باید متد `resolve(your_success_value)` رو فراخوانی کرده، و به هر دلیلی اگه نتیجه موفقیت‌آمیز نیست، باید متد `reject(your_fail_value)` رو فراخوانی کنید. هردوی اینها باید در داخل متد `Promise` انجام بشه.
   همونطور هم که در مثال می‌بینید ازونجایی که مامان عصبانی بود، ما مجبور شدیم درخواست رو رد کرده و با فرواخوانی متد `reject(reason)` و پاس کردن مقدار reason این مقوله رو به سرانجام برسونیم. البته، اگرهم مامان اوکی بود و گوشی جدید رو خرید، با فراخوانی متد `resolve` به همراه مقدار JSON از مشخصات گوشی خریداری شده، نتیجه **قول** رو اعلام می‌کردیم.

<h2 id="how-to-user-promise">استفاده از Promise</h2>

حالا که فهمیدیم چطوری میشه یه پرامیس ساخته، بهتره نحوه استفاده کردن ازش رو هم یاد بگیریم.

```javascript
/* ES6 */
...
// call our promise
let askMom = function () {
    willGetNewPhone
		.then( function (fulfilled) {
			//yay, you got a new phone
			console.log(fulfilled);
			//output: { brand: 'iPhone X', color: 'gray' }
		}).catch( function (error) {
			//oops, mom don't buy it
			console.log(error.message);
			//output: 'Mom is angry.'
		});
}

askMom();
```

در اینجا ما متد `askMom` رو فراخونی میکنیم. و در داخل اون، متد پرامیسی که ساخته بودیم، یعنی `willGetNewPhone`، رو صدا میزنیم.

ما میخواییم وقتی که پرامیس بهمون جواب میده بتونیم اکشن مناسب رو نشون بدیم. برای مواقعی که پاسخ **resolve** هست متد `then` استفاده میشه؛ و برای مواقعی که پاسخ **reject** هست، متد `catch` صدا میشه.

در این مثال، در داخل `.then` ما متد `function(fulfilled) {…}` رو داریم. مقدار این متغییرِ `fulfilled` چیه؟ دقیقا همون چیزیه که شما در متد `resolve(your-success_value)` پاس کردین. که در اینجا همون مشخصات گوشی جدیده ست.

همینطور در داخل `.catch‍` هم متد `function(error) {…}` رو داریم. که مقدار `error` برابر با مقداری هست که ما با `reject(your_fail_value)` پاسش کردیم. در این مثال مقدار error برابر بود با دلیل ریجکت شدن درخواست.

اجازه بدید کدهایی که تا الان زدیم رو اجرا کنیم و نتیجه کار رو ببینیم.
اجرای دمو از [این لینک](https://jsbin.com/luceriy/4/edit?js,console).

![Mom Promise Demo](/assets/img/post/2017-11-27/js-promise-mom-promise-demo.gif)

<h2 id="chain-of-promises">زنجیره Promiseها</h2>

پرامیس‌ها قابلیت زنجیره (متوالی) شدن رو دارند.

برای مثال، فرض کنید شما همون کودک مثال قبل هستید. حالا به دوستتون **قول می‌دید** که وقتی مامان واستون گوشی جدید رو خرید، بهش **نشون بدید.**

خب، پس بریم پرامیس بعدی رو بنویسیم.

```javascript
...

// 2nd promise
let showNewPhone = function (phone) {
	return new Promise(
		function (resolve, reject){
			let message = 'Hey friend, I have a new ' + phone.color + ' ' + phone.brand + '.';
			resolve (message)
		}
	);
}
```

**نکات:**

در این مثال احتمالا متوجه شدید که ما از `reject` استفاده نکردیم. خب این متد یه چیز optional و انتخابیه، فقط موقعی که نیاز هست ازش استفاده کنید.

ما حتی میتونیم با استفاده از `Promise.solve` این متد رو ساده‌تر هم بنویسیم .

```javascript
// shorten it
...

// 2nd promise
let showNewPhone = function (phone) {
	let message = 'Hey friend, I have a new ' + phone.color + ' ' + phone.brand +'.';
	return Promise.resolve(message)
}
```

خب، حالا وقت زنجیر کردن پرامیس‌هاست. شما - اون بچه داستان - فقط وقتی می‌تونید به دوستتون اون گوشی جدید رو نشون بدید `showNewPhone`، بعد از اینکه مامان اون گوشی رو واستون خریده باشه `willGetNewPhone`.

```javascript
...

// call our promise
let askMom = function () {
	willGetNewPhone
		.then(showNewPhone) // chain it here
		.then( function (fulfilled) {
			//yay, you got a new phone
			console.log(fulfilled);
			//output: 'Hey friend, I have a new gray iPhone X.'
		}).catch( function (error) {
			//oops, mom don't buy it
			console.log(error.message);
			//output: 'Mom is angry.'
		});
}
```

به همین راحتی می‌تونید پرامیس‌ها رو به همن زنجیر کنید.

<h2 id="asynchronous-promise">پرامیس‌ها Asynchronous هستند</h2>

این خیلی واضحه که پرامیس‌ها آسنکرون هستن. اصلا اجازه بدید برای اثبات این موضوع چندتا لاگ بندازیم.

```javascript
// call our promise
let askMom = function () {
    console.log('before asking Mom'); // log before
    willGetNewPhone
		.then(showNewPhone)
		.then(function (fulfilled) {
			console.log(fulfilled);
		}).catch(function (error) {
			console.log(error.message);
		});
    console.log('after asking mom'); // log after
}
```

فکر می‌کنید نتیجه‌ چی میشه؟ احتمالا انتظار دارید همچین چیزی دریافت کنید:

```Log
1. before asking Mom
2. Hey friend, I have a new black Samsung phone.
3. after asking mom
```

ولی چیزی که واقعا دریافت میکنیم اینه:

```Log
1. before asking Mom
2. after asking mom
3. Hey friend, I have a new black Samsung phone.
```

![Chain Demo](/assets/img/post/2017-11-27/js-promise-chain-demo.gif)

**چرا؟ چون زندگی (یا JS) منتظر هیچ کسی نمی‌مونه**

شما، یا درواقع همون بچه، از بازی کردن دست نمی‌کشید موقعی که منتظرید تا مامانتون به قولش (خریدن موبایل جدید) عمل کنه؛ غیر از اینه؟ این همون چیزیه که ما بهش میگیم asynchronous، کد کاملا اجرا میشه، بدون اینکه سرویسمون رو بلاک کنه یا منتظر جواب بشه. هرموقع جواب رسید، بهش واکنش مناسب رو نشون میده. هرکاری که قراره موقع عمل کردن مامان به قولش  انجام بدید، فقط کافیه بزارینش داخل `.then` 😉 .

<h2 id="promises-in-variety-of-js">پرامیس در ES5، ES6, ES7</h2>

<b id="promise-in-es5">ES5 - در اکثر مرورگرها پشتیبانی میشه</b>

سرویسی که نوشتیم در اکثر مرورگرها و البته در NodeJs قابل استفاده است. البته در ES5 این ابزار همینجوری قابل استفاده نیست و برای استفاده ازش باید از لایبرری [Bluebird](http://bluebirdjs.com/docs/getting-started.html) استفاده کنید. البته لایبرری معروف دیگه‌ای هم برای اینکار هست به اسم [Q](https://github.com/kriskowal/q) که توسط Kris Kowal توسعه داده شده.

<b id="promise-in-es6">ES6 - در مرورگرهای مدرن، و NodeJs v6 پشتیبانی میشه</b>

سرویسی که نوشتیم بصورت نیتیو در ES6 اجرا میشه و احتیاج به هیچ لایبرری خارجی وجود نداره. البته ما در ES6 میتونیم با استفاده از `fat arrow =>` فاکنکشن‌ها کدمون رو ساده‌تر هم بنویسیم.

```javascript
/* ES6 */
let isMomHappy = true;

//Promise
const willGetNewPhone = new Promise(
  (resolve, reject) => { //fat arrow
    if(isMomHappy) {
      let phone = {
        brand: 'iPhone X',
        color: 'gray'
      };
      resolve(phone);
    } else {
      let reason = new Error('Mom is angry.')
      reject(reason);
    }
  }
);

const showNewPhone = function (phone) {
	let message = 'Hey friend, I have a new ' + phone.color + ' ' + phone.brand +'.';
	return Promise.resolve(message)
}

// call our promise
const askMom = function () {
	willGetNewPhone
        .then(showNewPhone)
        .then(fulfilled => console.log(fulfilled)) // fat arrow
        .catch(error => console.log(error.message)); // fat arrow
}

askMom();
```

اگه با ES6 آشنایی ندارید، توجه کنید که من همه متغیر هایی که قابل تغییر بودند رو با `let` مشخص کردم و اونهایی رو هم که immutable و بدون تغییر هستند رو با `const` مشخص کردم. همه فانکشنهایی هم که بصورت `function(arguments)` بود رو به `(argument) =>` تغییر دادم. برای آشنایی بیشتر با ES6 می‌تونید لینک‌های زیر رو مطالعه کنید:

- [JavaScript ES6 Variable Declarations with let and const](https://strongloop.com/strongblog/es6-variable-declarations/)

- [An introduction to Javascript ES6 arrow functions](https://strongloop.com/strongblog/an-introduction-to-javascript-es6-arrow-functions/)

<b id="promise-in-es7">ES7 - استفاده از Async Await سینتکس رو قابل خوندن میکنه</b>

اگه قرار باشه این سرویس رو با ES7 بنویسیم، میتونیم با استفاده از تگ های `async` و `await` کدمون رو تمیزتر کنیم. اینطوری میتونیم `then` و `catch` رو از کدمون حذف کنیم.

پس چیزی که درنهایت بازنویسی میکنیم در ES7 میشه این:

```javascript
/* ES7 */
let isMomHappy = true;

//Promise
const willGetNewPhone = new Promise(
  (resolve, reject) => { //fat arrow
    if(isMomHappy) {
      let phone = {
        brand: 'iPhone X',
        color: 'gray'
      };
      resolve(phone);
    } else {
      let reason = new Error('Mom is angry.')
      reject(reason);
    }
  }
);

//2nd promise
async showNewPhone = function (phone) {
	return new Promise(
        (resolve, reject) => {
            let message = 'Hey friend, I have a new ' + phone.color + ' ' + phone.brand +'.';
			return Promise.resolve(message)
        }
    );
}

//call our promise
async askMom = function () {
	try {
        console.log('before asking Mom');

        let phone = await willIGetNewPhone;
        let message = await showNewPhone(phone);

        console.log(message);
        console.log('after asking mom');
    }
    catch (error) {
        console.log(error.message);
    }
}

(async () => {
    await askMom();
})();
```

1. هرموقع که نیاز داشتید یه پرامیس return کنید، فقط کافیه متد مورد نظر رو با `async` نشانه گذاری کنید.
برای مثال:
   `async function showNewPhone(phone)`
2. هرموقع که احتیاج داشتید پرامیس رو فراخوانی کنید، کافیه قبلش با `await` نشانه‌گذاری کنید. برای مثال:
   `let phone = await willIGetNewPhone;` و `let message = await showNewPhone(phone);`.
3. و در نهایت با استفاده از `try { ... } catch(error) { … }` میتونید قضیه **resolved** و **rejected** پرامیس رو هم هندل کنید.

<h2 id="when-and-why-promises">چرا و چه موقع از Promise استفاده کنیم؟</h2>

واقعا چرا به پرامیس احتیاج داریم؟ دنیا قبل از پرامیس چه شکلی بود؟ بزارید قبل از جواب دادن به این سوال ها، کمی برگردیم عقب و ببینیم قبلا اوضاع رو چجوری هندل می‌کردیم.

**متد معمولی برای جمع دو عدد**

```javascript
// add two numbers normally
function add (num1, num2) {
    return num1 + num2;
}

const result = add(1, 2); // you get result = 3 immediately
```

**متد Async برای جمع دو عدد**

```javascript
// add two numbers remotely
// get the result by calling an API
const result = getAddResultFromServer('http://www.example.com?num1=1&num2=2');
// you get result  = "undefined"
```

اگه شما عددهارو با متد معمولی جمع بزنید، همون لحظه جوابشو می‌گیرید. اما برعکس،‌ وقتی میخوایید به یک API ریکوئست بزنید که این دوتا عدد رو براتون جمع بزنه، اونموقع باید صبر کنید تا جواب برگرده،‌و نمی‌تونید همون لحظه به جوابتون برسید.

مورد دیگه‌ای هم وجود داره، اگه شما به این شکل بخواهید جوابتون رو بگیرید، معلوم نیست که جواب سرور چیه، و ممکنه حتی سایت دان باشه، یا سرعت پاسخگویی خیلی کم باشه، یا هر مشکل دیگه‌ای. و اینو هم میدونیم که شما قرار نیست کل سرویستون رو بلاک یا فریز کنید و منتظر وایستید تا بلکه بلاخره جوابی برسه.

فراخوانی APIها، دانلود کردن فایل، خواندن فایل و چیزهایی مثل این، مواردی هستند که باید با استفاده از متد های Async باهاشون کار کرد.

<h2 id="callback">دنیا قبل از پرامیس: Callback</h2>

آیا حتما باید از پرامیس برای فراخوانی متدهای Async استفاده کنیم؟ خیر. قبل از پرامیس، ما از callback استفاده می‌کردیم.
فانکشن callback فقط برای مواقعی که میخواهیم نتیجه بازگشتی رو دریافت کنیم به کار میره. اجازه بدید با توجه به چیزی که حالا راجع به کال‌بک میدونیم، متد قبلی رو بازنویسی کنیم.

```javascript
// add two numbers remotely
// get the result by calling an API

function addAsync (num1, num2, callback) {
    // use the famous jQuery getJSON callback API
    return $.getJSON('http://www.example.com', {
        num1: num1,
        num2: num2
    }, callback);
}

addAsync(1, 2, success => {
    // callback
    const result = success; // you get result = 3 here
});
```

خب، با این توصیف، پس دیگه به پرامیس چه احتیاجی داریم؟

**اگر قرارباشه یکسری اکشن‌های متوالی آسنکرون انجام بدید، چیکار می‌کنید؟**

خب بزارید ببینیم چی داریم، قرار حالا بجای اینکه یه بار عمل جمع رو انجام بدیم، ۳بار اینکارو انجام بدیم. با کد زدن معمولی همچین چیزی میشه:

```javascript
// add two numbers normally

let resultA, resultB, resultC;

 function add (num1, num2) {
    return num1 + num2;
}

resultA = add(1, 2); // you get resultA = 3 immediately
resultB = add(resultA, 3); // you get resultB = 6 immediately
resultC = add(resultB, 4); // you get resultC = 10 immediately

console.log('total' + resultC);
console.log(resultA, resultB, resultC);
```

حالا اگه بخواهیم همون کارو با callback انجام بدیم چطور؟

```javascript
// add two numbers remotely
// get the result by calling an API

let resultA, resultB, resultC;

function addAsync (num1, num2, callback) {
    // use the famous jQuery getJSON callback API
    return $.getJSON('http://www.example.com', {
        num1: num1,
        num2: num2
    }, callback);
}

addAsync(1, 2, success => {
    // callback 1
    resultA = success; // you get result = 3 here

    addAsync(resultA, 3, success => {
        // callback 2
        resultB = success; // you get result = 6 here

        addAsync(resultB, 4, success => {
            // callback 3
            resultC = success; // you get result = 10 here

            console.log('total' + resultC);
            console.log(resultA, resultB, resultC);
        });
    });
});
```

این syntax اصلا یوزرفرندلی نیست. خیلی دیگه بخواییم خوشبین باشیم، مثل اهرام ثلاثه شده! 😒 اما توسعه دهنده‌های خارجی به همچین چیزی میگن <Callback Hell>، بخاطر اینکه هر کال‌بک در داخل شکم کال‌بک دیگه‌ای قرار گرفته. تصور کنید که ۱۰تا کال‌بک دارید، کدتون ۱۰ بار نِست می‌شد!

<h2 id="scape-from-callback-hell">فرار از Callback Hell</h2>

و در این لحظه بود که قهرمان داستان ما، Promise وارد شد 👨🏻‍🎤. بزارید ببینیم کدمون حالا چطوری میشه.

```javascript
// add two numbers remotely using observable

let resultA, resultB, resultC;

function addAsync(num1, num2) {
    // use ES6 fetch API, which return a promise
    return fetch(`http://www.example.com?num1=${num1}&num2=${num2}`)
        .then(x => x.json());
}

addAsync(1, 2)
    .then(success => {
        resultA = success;
        return resultA;
    })
    .then(success => addAsync(success, 3))
    .then(success => {
        resultB = success;
        return resultB;
    })
    .then(success => addAsync(success, 4))
    .then(success => {
        resultC = success;
        return resultC;
    })
    .then(success => {
        console.log('total: ' + success)
        console.log(resultA, resultB, resultC)
    });
```

با استفاده از پرامیس‌ها، ما بجای callback از `.then` کمک می‌گیریم. در همین نگاه اول متوجه میشیم که چقدر کدهامون با حذف کال‌بک‌های nested یا تودرتو تروتمیزتر شده. البته که با استفاده از سینکتس `asyn` و `await` کدهامون بازم ساده‌تر و تروتمیزتر از چیزی که الان هست میشه. دیگه مثال این رو هم میزارم به عهده خودتون 😬🖐.

![Relaxing](/assets/img/post/2017-11-27/js-promise-relaxing.gif)

<h2 id="observable">عضو جدید این خانواده: Observables</h2>

قبل از اینکه خیلی با پرامیس حال کرده و کف خون قاطی کنید، این رو باید اضافه کنم، یه چیزی وجود داره که قضیه مدیریت فانکشن‌های async رو از اینی که هست هم آسونتر کرده، و بهش میگن `Observable`.

واضحترین تعریفی که میتونم راجع به Observabale بهتون بگم اینه:

> قابل‌مشاهده یا Observable یک جریانی از رویداد‌های تنبله که میتونه میتونه صفر یا بی‌نهایت رویداد رو منتشر کنه، و این قضیه میتونه پایانی داشته یا نداشته باشه.

و اگه بخوام ساده‌ترش کنم:

> فانکشن Observable از خودش مقادیری رو منتشر میکنه، و با یک **Observer** یا مشاهده‌گر میتونیم بشینیم و این مقدار رو رَصَد کنیم. در نتیجه هرموقع این Observabale از خودش چیزی منتشر کرد، سریع متوجه میشیم و متناسب با این مقدار، ری‌اکشن موردنظر رو نشون بدیم.

فانکشن یا مقادیر Observable از مفهوم  ReactiveX Programming اومده و در همه زبان‌هایی که از RX پشتیبانی میکنن وجود داره، در جاوا اسکریپت بهش میگیم RxJs. برای اطلاعات بیشتر لینک‌های زیر مطالب خوب و کاملی دارند:

- [ReactiveX](http://reactivex.io/)
- [RxJS v4.0](https://xgrommx.github.io/rx-book/index.html)
- [Building realtime applications with CycleJS and RxJS](https://blog.pusher.com/building-realtime-applications-with-cyclejs-and-rxjs/)

و برای آشنایی بیشتر با Observable پیشنهاد میکنم لینک‌های زیر رو مطالعه کنید:

- [Observable](http://reactivex.io/documentation/observable.html)
- [Observable object](https://xgrommx.github.io/rx-book/content/observable/index.html)
- [Introducing the Observable](https://egghead.io/lessons/javascript-introducing-the-observable)
- [Stream: Reactive Programming](https://cycle.js.org/streams.html)
- [Learning Observable By Building Observable](https://medium.com/@benlesh/learning-observable-by-building-observable-d5da57405d87)

اما برگردیم سر بحث خودمون. یکسری تفاوت‌ها بین Observable و Promise وجود داره:

- Observable قابلیت لغو شدن داره (Cancellable)
- Observable اصولا تنبله (Lazy)

نترسین، در ادامه یه مثال درباره اینکه از آبزروبل چطوری میتونم استفاده کنیم آوردم. در مثال زیر من از قابلیت‌های RxJs برای پیاده کردن Observable استفاده کردم.

```javascript
let Observable = Rx.Observable;
let resultA, resultB, resultC;

function addAsync(num1, num2) {
    // use ES6 fetch API, which return a promise
    const promise = fetch(`http://www.example.com?num1=${num1}&num2=${num2}`)
        .then(x => x.json());

    return Observable.fromPromise(promise);
}

addAsync(1,2)
  .do(x => resultA = x)
  .flatMap(x => addAsync(x, 3))
  .do(x => resultB = x)
  .flatMap(x => addAsync(x, 4))
  .do(x => resultC = x)
  .subscribe(x => {
    console.log('total: ' + x)
    console.log(resultA, resultB, resultC)
  });
```

نکته:

- متد `Observable.fromPromise` مقدار Promise ما رو به یه استریم از observable تبدیل می‌کنه.
- اوپراتورهای `.do` و `.flatMap` به ما در مدیریت رویداد‌های منتشره از Observable کمک می‌کنند.
- استریم‌های Observable تنبل یا lazy هستند. متد `addAsync` موقعی اجرا میشه که ما بهش `.subscribe` کرده باشیم.

فانکش‌های Observable امکانات باحالتری هم به ما می‌دن. مثلا در مثال زیر من با استفاده از اوپراتور `delay` بهش گفتم در اجرای فانکشن ۳۰۰۰میلی‌ثانیه تاخیر ایجاد کنی و بعد کارتو انجام بده.

```javascript
...
addAsync(1,2)
  .delay(3000) // delay 3 seconds
  .do(x => resultA = x)
...
```

تا همین‌جارو داشته باشین، و اجازه بدین راجع به Observable در یه پست دیگه مفصل‌تر صحبت کنم.

<h2 id="conclusion">نتیجه گیری</h2>

سعی کنید با انجام مثال‌های بیشتر یا مطالعه مقاله‌های دیگه با Promiseها و Callbackها بیشتر آشنا بشید. اونهارو کامل درک کنید و واقعا در پروژه‌هاتون استفاده کنید. درباره Observable هم نگران نباشید، این یه موضوع جدیده و حالا حالا وقت هست واسه اینکه توش مهارت پیدا کنید.
دوباره تکرار میکنم، با هرسه این مفاهیم و ابزارها آشنا بشید و ببینید واقعا کجا بدردتون میخوره، تا متناسب با اون ازشون استفاده کنید.

می‌تونید از لینک‌های زیر هم مثالی که درباره `Mom Promise to buy new phone` رو ببینید:

- [Mom Promise in ES5](https://gist.github.com/sadra/60429ffd4d5f1d8e7b0533c66d7f510d#file-mom-promise-in-es5-js)
- [Mom Promise in ES6](https://gist.github.com/sadra/60429ffd4d5f1d8e7b0533c66d7f510d#file-mom-promise-in-es6-js)
- [Mom Promise in ES7](https://gist.github.com/sadra/60429ffd4d5f1d8e7b0533c66d7f510d#file-mom-promise-in-es7-js)

خب همش همین بود. امیدوارم مبحث Promise رو ساده توضیح داده باشم و شما هم راحت درک ‌باشینش. اگه سوال یا موردی بود، مثل همیشه در [توییتر](https://twitter.com/sadra_amlashi) یا در [تلگرام](https://t.me/amlashi) میتونیم باهم در ارتباط باشیم. 😉🍷
