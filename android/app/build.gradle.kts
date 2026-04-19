plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.local_notifications"

    compileSdk = 36 // версия андроид API для сборки проекта (доступ к новым возможностям системы)

    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.local_notifications"
        minSdk = 24 // минимальная версия андроид, на которой апп может установиться и работать
        targetSdk = 36 // версия андроид, под поведение которой оптимизировано апп (новейшая версия)
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        multiDexEnabled = true // вкл поддержку MultiDex для обхода лимита методов андроид
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("androidx.window:window:1.0.0")
    implementation("androidx.window:window-java:1.0.0")
}

flutter {
    source = "../.."
}