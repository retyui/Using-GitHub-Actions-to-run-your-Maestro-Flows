# Using GitHub Actions to run your Maestro Flows

> **UPD:** no only GitHub Actions :)

## `MyApp` React Native

Maestro was included in a straightforward React Native app I made.

<table>
<tbody>
<tr>
<td>Info</td>
<td>iOS</td>
<td>Android</td>
</tr>
<tr>
<td>

- Minimal android API version is `21` (Android 5.0).
- Minimal iOS version is `12.4`
- New Arch: `No`
- React Native version: `0.72.3`

</td>
<td>

https://github.com/retyui/Using-GitHub-Actions-to-run-your-Maestro-Flows/assets/4661784/db4c951c-fed4-40f8-929b-ef8bd78494fb

</td>
<td>

https://github.com/retyui/Using-GitHub-Actions-to-run-your-Maestro-Flows/assets/4661784/5802b93f-d021-417c-9d74-7ca8b3f46345

</td>
</tr>
</tbody>
</table>

## GitHub Actions (`ubuntu-latest`, `ubuntu-*`, ...)

Using a linux runner actually is not a good idea for Android e2e tests. For a longer answer please refer
to [this issue](https://github.com/ReactiveCircus/android-emulator-runner/issues/46).

- Config [`android-github-actions-ubuntu.yaml`](.github/workflows/android-github-actions-ubuntu.yaml) include Android
  e2e workflows
- Limitations:
    - very slow (the fastest run took about 10 min);
    - android API `30` (Android 11) and higher is not supported;
    - flaky tests results;

> ⚠️ Warn: Maestro `1.30.x` supports only Android API `26` (Android 8.0) and higher.

## [Genymotion SaaS](https://cloud.geny.io/)

Using Genymotion SaaS you can create a remote adb connection to a virtual device and run your Maestro E2E tests on it.

- Config: [`android-genymotion-cloud.yaml`](.github/workflows/android-genymotion-cloud.yaml) Android only
- Price: [`$0.05` per minute](https://docs.genymotion.com/saas/03_1_Pricing/#pay-as-you-go) _Pay as you Go_ plan
- `2` concurrent devices
- First run can take up to `5` minutes

| version     | time   | cost  | 
|-------------|--------|-------|
| Android 13  | 2m 04s | ~$0.1 | 
| Android 12  | 2m 04s | ~$0.1 |
| Android 11  | 1m 46s | ~$0.1 |
| Android 10  | 2m 30s | ~$0.1 |
| Android 9   | 2m 10s | ~$0.1 |
| Android 8.1 | 2m 18s | ~$0.1 |
| Android 8   | 2m 05s | ~$0.1 |

On dashboard ^^^ all runs above took `10min` and cost `$0.5`

> ⚠️ Warn: Maestro `1.30.x` supports only Android API `26` (Android 8.0) and higher.

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

| platform   | `instance_type` | cpu                          | ram  | time   | price                                                    | 
|------------|-----------------|------------------------------|------|--------|----------------------------------------------------------|
| Android 11 | `linux`         | (4) x64 Intel(R) Xeon(R) CPU | 16GB | 4m 13s | [$0.015/min](https://docs.codemagic.io/billing/pricing/) | 
| iPhone 14  | `mac_mini_m1`   | (4) arm64 Apple M1 (Virtual) | 8GB  | 3m 49s | [$0.095/min](https://docs.codemagic.io/billing/pricing/) | 

On billing details page: ^^^ two runs above took `9min` and cost `$0.45` (ios: `$0.38`, android: `$0.07`)

## Nice to know:

- Samsung Remote Test Lab
- BrowserStack App Automate

---

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
