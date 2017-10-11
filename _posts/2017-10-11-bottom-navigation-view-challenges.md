---
layout: blog_post_rtl
title:  "بهبود رابط کاربری با BottomNavigationView"
date: '2017-10-11'

tags:
    - Android
    - UI
    - BottomNavigationView

categories:
    - چالش
    - رابط کاربری
    - متریال دیزاین

cover: /assets/img/post/2017-10-11/bottom-navigation-menu-cover.jpg

author: Sadra
---

اگر پست “[جایگزینی برای منوی همبرگر](http://dcamp.ir/hamburger-menu-alternative)” شایان رو خونده باشید حتما متوجه شدید که ما در پروژمون بجای همبرگر منو از [BottomNavigationView](https://developer.android.com/reference/android/support/design/widget/BottomNavigationView.html) استفاده کردیم.

در این پست قراره به چالش هایی که در روند پیاده سازی این مقوله برخوردیم اشاره کنم و اینکه به چه روشی اونهارو حل کردیم.

خوشحال میشم اگه شما روش بهتری برای رفع این چالشها داشتین با ما به اشتراک بگذارین.

اگه دنبال این هستین که چطوری میتونید BottomNavigationView رو در پروژه‌تون پیاده کنید تنها کافیه تو گوگل سرچ کنید کلی آموزش فارسی و انگلیسی پیدا میشه. با اینحال بنظرم کامل‌ترین آموزش برای این قضیه [پست Joe Brich](https://medium.com/@hitherejoe/exploring-the-android-design-support-library-bottom-navigation-drawer-548de699e8e0) هست، البته اگه دنبال یه آموزش ویدئویی هستین بنظرم [این ویدئو در یوتیوب](https://www.youtube.com/watch?v=wcE7IIHKfRg) هم گزینه خوبیه.

## چالش اول: حالت ShiftMode منوی انتخابی

اولین چالشی که باهاش مواجه شدیم این بود که موقع کلیک روی یک منو در **BottomNavigationView** اون منو به اصطلاح مَگنیفاید یا بزرگ شده و متن زیرش پنهان میشد، که به این حالت `ShiftMode` میگن . مثل انیمیشن پایین:

![Bottom Navigation View](/assets/img/post/2017-10-11/bottom-navigation-menu-0.gif)

در نظر داشتیم تا همه آیکون و متن منو در زیر نشون داده بشه. تمایلی هم به بزرگ شدن آیکون ها نداشتیم، فقط کافی بود که رنگ آیتم انتخاب شده تغییر کنه و فقط آیکون کمی بالا بیاد که نشون بده انتخاب شده.

خب برای اینکار اول از همه یه کلاس `BottomNavigationViewHelper` درست کردم. در این کلاس با کمک متد **disableShiftMode** قابلیت ShiftingMode رو از تک تک منو ها گرفته، سپس حذف و جایگزین می‌کنیم.

```java
public class BottomNavigationViewHelper {
    public static void disableShiftMode(BottomNavigationView view) {
        BottomNavigationMenuView menuView = (BottomNavigationMenuView) view.getChildAt(0);
        try {
            Field shiftingMode = menuView.getClass().getDeclaredField("mShiftingMode");
            shiftingMode.setAccessible(true);
            shiftingMode.setBoolean(menuView, false);
            shiftingMode.setAccessible(false);
            for (int i = 0; i < menuView.getChildCount(); i++) {
                BottomNavigationItemView item = (BottomNavigationItemView) menuView.getChildAt(i);
                //noinspection RestrictedApi
                item.setShiftingMode(false);
                // set once again checked value, so view will be updated
                //noinspection RestrictedApi
                item.setChecked(item.getItemData().isChecked());
            }
        } catch (NoSuchFieldException e) {
            Log.e("BNVHelper", "Unable to get shift mode field", e);
        } catch (IllegalAccessException e) {
            Log.e("BNVHelper", "Unable to change value of shift mode", e);
        }
    }
}
```

کلاس BottomNavigationViewHelper رو به پروژه‌تون اضافه کنید. حالا کافیه بعد از کست کردن BottomNavigationView مون، اون رو به کلاس هلپر معرفی کرده تا قابلیت ShiftMode شدن رو ازش صلب کنه.

```java
BottomNavigationView bottomNavigationView = (BottomNavigationView) findViewById(R.id.bottomNavigationView);
BottomNavigationViewHelper.disableShiftMode(bottomNavigationView);
```

## چالش دوم: تغییر رنگ آیکون انتخاب شده

ما میخواستیم موقع انتخاب شدن آیتم، آیکون‌ش به شکل یا رنگ خاصی تبدیل بشه. اما این امکان درحال عادی وجود نداشت. پس چیکار کردیم؟

من یکبار قبل شروع همه چیز برای همه آیتم ها یک آیکون پیشرفض تعریف کرده،‌ سپس یک متد به نام `changeIcon` ایجاد کردم، تا هربار که کاربر آیتمی رو انتخاب میکنه این متد صدا زده بشه. این متد ابتدا آیکونِ همه‌ی آیتم‌هارو روی پیشفرض قرار میده و سپس بر اساس `ID` آیتم انتخاب شده، آیکون پیشفرض‌ش رو با آیکون اَکتیو شده، تعویض میکنه.

```java
private void changeIcon(int itemIndex){

    bottomNavigationView.getMenu().getItem(0).setIcon(R.mipmap.bnv_menu_ic_home);
    bottomNavigationView.getMenu().getItem(1).setIcon(R.mipmap.bnv_menu_ic_news);
    bottomNavigationView.getMenu().getItem(2).setIcon(R.mipmap.bnv_menu_ic_support);
    bottomNavigationView.getMenu().getItem(3).setIcon(R.mipmap.bnv_menu_ic_profile);

    switch (itemIndex){
        case 0:
            bottomNavigationView.getMenu().getItem(0).setIcon(R.mipmap.bnv_menu_ic_home_active);
            break;
        case 1:
            bottomNavigationView.getMenu().getItem(1).setIcon(R.mipmap.bnv_menu_ic_news_active);
            break;
        case 2:
            bottomNavigationView.getMenu().getItem(2).setIcon(R.mipmap.bnv_menu_ic_support_active);
            break;
        case 3:
            bottomNavigationView.getMenu().getItem(3).setIcon(R.mipmap.bnv_menu_ic_profile_active);
            break;
    }

}
```

بعدش، یک **listener** برای bottomNavigationView مون تعریف کردم که هرموقع آیتمی انتخاب شد، این متد رو صدا بزنه تا آیکونش به آیکون مورد نظر ما تغییر کنه.

```java
bottomNavigationView.setOnNavigationItemSelectedListener(new BottomNavigationView.OnNavigationItemSelectedListener() {
    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {

        switch (item.getItemId()) {
            case R.id.action_mainFragments_home:
                changeIcon(0); break;
            case R.id.action_mainFragments_news:
                changeIcon(1); break;
            case R.id.action_mainFragments_support:
                changeIcon(2); break;
            case R.id.action_mainFragments_profile:
                changeIcon(3); break;
        }

        return true;
    }
});
```

و در نهایت با توجه به برداشتن حالت مگنیفای و تغییر آیکون چیزی که انتظار داشتیم این شکلی شد:

![Bottom Navigation View](/assets/img/post/2017-10-11/bottom-navigation-menu-1.gif)

## چالش سوم: قرار دادن Badge در هنگام دریافت ناتیفیکیشن

یکی از پر دردسرترین چیزهایی که باهاش روبرو شدیم، بَج گذاشتن کنار یکی از آیتم‌های BNV بود. در اولین تلاش یه shape قرمز رنگ از نوع oval ساختم، بعدش به این فکر کردم که میخوام برای آیتم دومی یه بج نشون بدم، پس عرض صفحه رو گرفته، تقسیم بر ۴ کرده و سپس صربدر ۲.۵ میکردم تا بیافته در مرکز آيتممون! در نهایت هم ویوو مربوطه رو به BNV اضافه میکردم. همه چی درست کار می‌کرد تا موقعی که قرار نبود در سایزهای غیر موبایلی (مثل تبلت) نشون داده بشه، اونموقع دیگه مثل سابق جاش اونجایی نبود که باید باشه و روی هر اسکرین چندین پیکسل جابجا می‌شد.

در اقدام بعدی برای حل این مشکل یه کلاس `BadgeView` درست کردم که از نوع AppCompatTextView هست، و تمام حالات ممکن رو براش پیاده کردم تا روی اسکرین های مختلف مشکلی نداشته باشیم، حتی مشکل حالت count یا empty بج رو هم براش در نظر گرفتم. لازم نیست خودتون رو درگیر این اینکه این کلاس چطوری کار میکنه بکنید، فقط کافیه کلاس رو [از اینجا](https://gist.github.com/sadra/d13b354d6205360fc03c80aa2d3fd32b) دریافت کرده و به پروژتون اضافه کنید.

حالا برای اضافه کردن Badge اول از همه آیتم منوی مورد نظرتون رو باید انتخاب کنید.

```java
BottomNavigationMenuView menuView = (BottomNavigationMenuView) bottomNavigationView.getChildAt(0);
View targetView = menuView.getChildAt(1); //I' select second menu item
```

سپس، از BadgeView یه نمونه ایجاد کرده و آیتم منوی مورد نظر رو براش تعریف می‌کنیم.

```java
badgeView = new BadgeView(this);
badgeView.setTargetView(targetView);
```

اگه میخوایین Badge تون شماره داشته باشه (مثلا تعداد پیام‌های دریافتی)، متد `setBadgeCount` رو صدا کرده و داخلش مقدار مورد نظرتون رو وارد کنید. اگر نه مثل اینستاگرام یه نقطه کوچیک خالی کنار آیتم مورد نظر خواستین فقط کافیه متد `setEmptyBadge` و یا حتی برای سایز کوچیکتر `setEmptySmallerBadge` رو صدا کنید.

بطور پیشفرض بَج در بالا سمت راست قرار میگیره. برای اینکه بَج مورد نظر در همه سایز ها و اسکرین ها یکسان و در یک جا قرار داشته باشه (سمت راست آیتم با فاصله ۵ پیکسل از سمت چپ) اول از همه باید اون رو در مرکز آیتم قرار بدیم، بعدش با استفاده از متد `setBadgeMargin` مقدار لازمه رو برای فاصله گرفتن از مرکز به سمت بالا سمت راست، یا هرجایی که شما دوست داشتین وارد می‌کنیم.

خب درنهایت، چیزی نوشتیم برای یه _بج empty_ اینه:

```java
private void insertBadge(){
	BottomNavigationMenuView menuView = (BottomNavigationMenuView) bottomNavigationView.getChildAt(0);
	View targetView = menuView.getChildAt(1);

	badgeView = new BadgeView(this);
	badgeView.setTargetView(targetView);
	badgeView.setEmptyBadge();
	badgeView.setBadgeGravity(Gravity.CENTER);
	badgeView.setBadgeMargin(0, 24, 13, 0);
}
```

اگر از Badge با شمارنده استفاده کردین، برای افزایش مقدار داخل بَج هم میتونید بصورت دستی مقدار جدید بهش بدید، و هم میتونید با صدا زدن متد `incrementBadgeCount` یا `decrementBadgeCount` اون رو کم یا زیاد کنید.

برای حذف کردن بج از روی منوی آیتم فقط کافیه متد `removeBadge` رو صدا بزنید.

در نهایت چیزی که انتظارشو داشتیم، به همین سادگی به همین خوشمزگی :)

![Bottom Navigation View](/assets/img/post/2017-10-11/bottom-navigation-menu-2.png)

![Bottom Navigation View](/assets/img/post/2017-10-11/bottom-navigation-menu-3.png)

![Bottom Navigation View](/assets/img/post/2017-10-11/bottom-navigation-menu-4.png)

## نتیجه گیری

نتیجه اینکه کس نخوارد پشت من جز ناخن انگشت من! به هرحال این بندگان خدا در شرکت google خودشون رو به هر دری میزنن تا راه توسعه رو برای ما هموارتر کنن ولی خوب نمیشه در هرچیزی کمال مطلق آفرید، ابزارها آفریده میشن،‌و تکمیل کردنشون وظیفه ما توسعه دهنده‌هاست، مثل همین چالش‌هایی که در این مقوله پیش اومد.

اگر شما تو استفاده از این BottomNavigationView به چالشی برخوردید و حلش کردید یا برای همین موارد پیش اومده پیشنهاد بهتری داشتین ممنون میشم اگه روی [توییتر](https://twitter.com/sadra_amlashi) یا [تلگرام](https://t.me/Amlashi) با من درمیون بگذارید.