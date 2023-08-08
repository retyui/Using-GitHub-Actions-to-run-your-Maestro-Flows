# Using-GitHub-Actions-to-run-your-Maestro-Flows

## `MyApp` React Native

I created a simple React Native app and add Maestro to it.

- Minimal android API version is `21` (Android 5.0).
- Minimal iOS version is `12.4`
- New Arch: `No`
- React Native version: `0.72.3`

## GitHub Actions (`ubuntu-latest`, `ubuntu-*`, ...)

Using a linux runner actually is not a good idea for Android e2e tests. For a longer answer please refer
to [this issue](https://github.com/ReactiveCircus/android-emulator-runner/issues/46).

- Config [`android-github-actions-ubuntu.yaml`](.github/workflows/android-github-actions-ubuntu.yaml) include Android
  e2e workflows
- Limitations:
    - very slow (the fastest run took about 10 min);
    - android API `30` (Android 11) and higher is not supported;
    - flaky tests results;
    - Maestro `1.30.x` supports only android API `26` (Android 8.0) and higher.

## [Codemagic](https://codemagic.io)

- Config [codemagic.yaml](codemagic.yaml) include Android & iOS e2e workflows
- Provide [`500` free build minutes](https://docs.codemagic.io/billing/pricing/#1-free-plan) per month on macOS M1
  Standard VM (`instance_type: mac_mini_m1`)
  standard VM
- To use `instance_type: linux` you need to add credit card
- The [Codemagic annual plan](https://docs.codemagic.io/billing/pricing/#2-fixed-annual-plan) gives you a fixed-price
  plan with the following benefits:
    - **3 concurrencies** (with access to Mac mini M2, macOS M1 & Intel, Linux, and Windows instances)
    - **Unlimited build minutes** 😱

| platform   | `instance_type` | cpu                          | ram  | time  | price                                                    | 
|------------|-----------------|------------------------------|------|-------|----------------------------------------------------------|
| Android 11 | `linux`         | (4) x64 Intel(R) Xeon(R) CPU | 16GB | ~4min | [$0.015/min](https://docs.codemagic.io/billing/pricing/) | 
| iPhone 14  | `mac_mini_m1`   | (4) arm64 Apple M1 (Virtual) | 8GB  | ~6min | [$0.095/min](https://docs.codemagic.io/billing/pricing/) | 

---

Nice to know:

- Samsung Remote Test Lab
- BrowserStack App Automate

TODO:

- [ ] Sauce Labs
- [ ] Firebase Test Lab
- [ ] AWS Device Farm
- [ ] Perfecto
- [ ] TestingBot
- [ ] CrossBrowserTesting
- [ ] LambdaTest
- [ ] TestingWhiz
- [ ] Kobiton
- [ ] Experitest
- [ ] HeadSpin
- [ ] pCloudy
- [ ] TestObject
- [ ] BitBar
- [ ] TestFairy
- [ ] Xamarin Test Cloud
- [ ] Testdroid
- [ ] SeeTest
- [ ] Ranorex
- [ ] Eggplant
- [ ] Telerik
- [ ] Katalon
- [ ] Ranorex
- [ ] TestComplete
- [ ] TestCraft
