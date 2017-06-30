---
layout: blog_post_rtl
title:  "پست صفرم - دوم چون نهد معمار کج، تا ثریا می‌رود دیوار کج!"
date: '2015-05-08'
tags:
    - iOS
    - Programming
    - هالو مارین
categories:
    - Jeykill
author: sadra
---

## Tables

{% table dir-rtl pos-right %}
| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |
{% endtable %}

{% table dir-ltr pos-center %}
| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |
{% endtable %}

{% table dir-rtl pos-left %}
| Option | Description |
| ------ | ----------- |
| data   | path to data files to supply the data that will be passed into templates. |
| engine | engine to be used for processing templates. Handlebars is the default. |
| ext    | extension to be used for dest files. |
{% endtable %}




# Awesome Android Spinner
[![](https://jitpack.io/v/amlashi-sadra/AwesomeSpinner.svg)](https://jitpack.io/#amlashi-sadra/AwesomeSpinner)
[![License](https://img.shields.io/badge/licence-MIT-lightgrey.svg?style=flat)](https://github.com/amlashi-sadra/AwesomeSpinner/blob/master/LICENSE)
[![Dependencies](https://img.shields.io/badge/dependencies-non-yellow.svg?style=flat)](#)
[![Gitter](https://img.shields.io/badge/gitter-join%20chat-%23E91E63.svg?style=flat)](https://gitter.im/AwesomeSpinner)
[![Minimum Android SDK Version](https://img.shields.io/badge/Minimum%20Android%20SDK-14-blue.svg)](#)

With **Awesome Spinner** you can implement a material spinner with access to define **direction layout** and **hint text**.

![](https://github.com/amlashi-sadra/AwesomeSpinner/blob/master/art/awesome_spinner_rtl.gif)
![](https://github.com/amlashi-sadra/AwesomeSpinner/blob/master/art/awesome_spinner_ltr.gif)


## Including the library


![Alt this is the al of this emage](/assets/img/post/post-2.jpg "This is caption")

{% include func/image.html
            img="/assets/img/post/post-2.jpg"
            title="title for image"
            caption="caption for image"
            url="/assets/img/post/post-2.jpg" %}










**Step 1.** Add it in your root build.gradle at the end of repositories:
```groovy
allprojects {
	repositories {
		...
		maven { url 'https://jitpack.io' }
	}
}
```

**Step 2.** Add the dependency:
```groovy
compile 'com.github.amlashi-sadra:AwesomeSpinner:1.0.7'
```

## How To Use

**Step 1.** From very firts, you should add the **Awsome Spinner** component inside of your layout:
```xml
<com.isapanah.awesomespinner.AwesomeSpinner
    android:id="@+id/my_spinner"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"/>
```

- If you want to add a default value for hint just add the `spinnerHint` into your component
- The default spinner has `RTL` direction, if you want to declare the direction of spinner just add the `spinnerDirection` to **RTL** or **LTR**
so the complete example with **LTR** direction and hint text to **Select a category** is:

```xml
<com.isapanah.awesomespinner.AwesomeSpinner
    android:id="@+id/my_spinner"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    app:spinnerDirection="ltr"
    app:spinnerHint="Select a category" />
```

**Step 2.** Define the component class into your activity:

```java
AwesomeSpinner my_spinner = (AwesomeSpinner) findViewById(R.id.my_spinner);
```

Then Create your adapter. For now, there is two way to define apadter:
- With String List, define a `List<String>` in your activity and the attach that with your adapter:

```java
List<String> categories = new ArrayList<String>();
categories.add("Automobile");
categories.add("Ariplane");

ArrayAdapter<String> categoriesAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, categories);

my_spinner.setAdapter(categoriesAdapter);
```

- With String-Array, define a `string-array` in your `strings.xml` file and attach that with your adapter:

```java
ArrayAdapter<CharSequence> provincesAdapter = ArrayAdapter.createFromResource(this, R.array.iran_provinces, android.R.layout.simple_spinner_item);

spinnerRTL.setAdapter(provincesAdapter, 0);
```

**Step 3.** For final step, you can create a **Listener** for listening on item selection:

```java
my_spinner.setOnSpinnerItemClickListener(new AwesomeSpinner.onSpinnerItemClickListener<String>() {
    @Override
    public void onItemSelected(int position, String itemAtPosition) {
        //TODO YOUR ACTIONS
    }
});
```

### Additional controls
there is some controls for your spinner:



{% table dir-ltr pos-left %}

| Control | Requierement | Info |
| :------------- |:-------------:| :-----|
| getSelectedItem() | - | result = `String`: returns the selected item |
| isSelected() | - | result = `boolean`: returns **true** if any item selected, and vice versa |
| setSelection(NUMBER) | `int` position | you should pass the **position of item** to select the item programatically |
| setSelection(TEXT) | `String` value | you should pass the **item value** to select the item programatically |

{% endtable %}



You can see the [EXAMPLE PROJECT](https://github.com/amlashi-sadra/AwesomeSpinner/tree/master/app/src/main) for more infromation.

## License

The MIT License (MIT): [https://github.com/amlashi-sadra/AwesomeSpinner/blob/master/LICENSE](https://github.com/amlashi-sadra/AwesomeSpinner/blob/master/LICENSE)

Copyright (c) 2017 Sadra Isapanah Amlashi

Website: [isapanah.com](http://isapanah.com)

Twitter: [@sadra_amlashi](https://twitter.com/sadra_amlashi)