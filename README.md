# Run Maestro Flows on CI

In this repo you can find examples of how to run your Maestro Flows on CI using:

- GitHub Actions
    - [`ubuntu-latest`](#github-actions-ubuntu-latest-ubuntu--) android
    - [`macos-12`](#github-actions-macos-12) android & ios
- [BuildJet](#buildjet) android
- [Genymotion](#genymotion-saas) android
- [Codemagic](#codemagic) android & ios
- [Maestro Cloud](#maestro-cloud) android & ios

## `MyApp` React Native

I created a [simple React Native](MyApp) and added a few Maestro [Flows](.maestro) to it.

> ⚠️ Warn: Maestro `1.30.x` supports only Android API `26` (Android 8.0) and higher.

<table>
<tbody>
<tr>
<td>Info</td>
<td>iOS</td>
<td>Android</td>
</tr>
<tr>
<td>

- Minimal Android API version is `21` (Android 5.0).
- Minimal iOS version is `12.4`
- React Native version: `0.72.3`
- New Arch: `No`

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


---

## GitHub Actions (`macos-12`)

- Config [`android-and-ios-github-actions-macos.yaml`](.github/workflows/android-and-ios-github-actions-macos.yaml)
  include Android & iOS e2e workflows
- Good choice for open-source projects (as is free for public repos)
- `macos-12` can be used for Android and iOS
- Limitations:
    - price: `$0.08`
    - `5` concurrent jobs
    - slow android runs but much stable than `ubuntu-latest`

| iOS ver. | time       |
|----------|------------|
| iOS 16   | **6m 15s** |

| Android API & Arch | default    | google_apis | google_apis_playstore |
|--------------------|------------|-------------|-----------------------|
| 26 x86             | 5m 44s     | 8m 29s      | 11m 39s               | 
| 26 x86_64          | 6m 3s      | 8m 6s       |                       |
| 27 x86             | 6m 47s     | 8m 40s      | 12m 4s                |
| 27 x86_64          | 5m 42s     |             |                       |
| 28 x86             | 6m 10s     | 9m 8s       | **8m 9s**             |
| 28 x86_64          | 4m 46s     | 10m 15s     | 10m 23s               |
| 29 x86             | **4m 40s** | 9m 10s      | 12m 2s                |
| 29 x86_64          | 7m 19s     | **7m 31s**  | 9m 30s                |
| 30 x86             |            | 8m 46s      | 14m 8s                |
| 30 x86_64          | **6m 17s** | 13m 46s     | 16m 21s               |
| 31 x86_64          | 6m 58s     | **9m 42s**  | 13m 12s               |
| 32 x86_64          |            | 16m 19s     | 16m 53s               |
| 33 x86_64          |            | 14m 1s      | 25m 57s               |
| 34 x86_64          |            | 13m 53s     | **12m 47s**           |

See [here](https://github.com/retyui/Using-GitHub-Actions-to-run-your-Maestro-Flows/actions/runs/5794918234/job/15710054746)
all runs above.

## GitHub Actions (`ubuntu-latest`, `ubuntu-*`, ...)

Using a linux runner actually is not a good idea for Android e2e tests. For a longer answer please refer
to [this issue](https://github.com/ReactiveCircus/android-emulator-runner/issues/46).

- Config [`android-github-actions-ubuntu.yaml`](.github/workflows/android-github-actions-ubuntu.yaml) include Android
  e2e workflows
- Limitations:
    - very slow (the fastest run took about 10 min);
    - android API `30` (Android 11) and higher is not supported;
    - flaky tests results;

I [tried to run all combinations](https://github.com/retyui/Using-GitHub-Actions-to-run-your-Maestro-Flows/actions/runs/5798798519)
of android api, arch & target but only several of them was successful :(

### List of "stable" combinations:

| api level | arch   | target      | time        |
|-----------|--------|-------------|-------------|
| 26        | x86    | default     | 16m 45s     |
| 26        | x86    | google_apis | 25m 45s     |
| 26        | x86_64 | default     | 13m 45s     |
| 27        | x86    | default     | 13m 38s     |
| 27        | x86_64 | default     | **12m 28s** |
| 28        | x86    | default     | 17m 54s     |
| 28        | x86_64 | default     | **12m 45s** |

All runs above cost: `113min` * `$0.008` = `$0.904`

### List of errors that you may get:

**Launch emulator:**

- Error: Timeout waiting for emulator to boot

**Maestro errors:**

- java.io.IOException: pm list packages --user 0 dev.mobile.maestro.test
- java.util.concurrent.TimeoutException: Maestro instrumentation could not be initialized
- java.util.concurrent.TimeoutException: Maestro Android driver did not start up in time

**`adb` commands:**

- adb: failed to install app-release.apk: cmd: Failure calling service package: Broken pipe (32)
- adb: failed to install app-release.apk: Performing Streamed Install

**GitHub Actions `timeout-minutes: 90`:**

- Error: The operation was canceled.

## [BuildJet](https://buildjet.com/for-github-actions)

A custom ubuntu runners much faster and cheaper than GitHub Actions. Also, KVM virtualization is enabled 🎉

- Config [`android-buildjet-ubuntu-amd64.yaml`](.github/workflows/android-buildjet-ubuntu-amd64.yaml) Android only
- 2 vCPU runner powerful enough to run your Maestro E2E tests
- Ubuntu 2vCPU/8GB price: [`$0.004`/ min](https://buildjet.com/for-github-actions/docs/about/pricing)
- `$5` free credits each month
- Concurrency limit of 64 AMD vCPUs, you can run:
    - 32 x 2 vCPU runners in parallel
    - 16 x 4 vCPU runners in parallel
    - 8 x 8 vCPU runners in parallel
    - [Which runner should I use?](https://buildjet.com/for-github-actions/docs/guides/which-runner-should-i-use)

| Android API & Arch | default    | google_apis | google_apis_playstore |
|--------------------|------------|-------------|-----------------------|
| 26 x86             | 2m 11s     | **2m 30s**  | 2m 50s                | 
| 26 x86_64          | **1m 56s** | 2m 39s      |                       |
| 27 x86             | 2m 4s      | 2m 48s      | **2m 48s**            |
| 27 x86_64          | **1m 57s** |             |                       |
| 28 x86             | 2m 4s      | 2m 58s      | 2m 51s                |
| 28 x86_64          | 2m 15s     | 3m 0s       | 2m 56s                |
| 29 x86             | 1m 50s     | 2m 36s      | 2m 48s                |
| 29 x86_64          | 8m 28s     | 3m 31s      | 3m 45s                |
| 30 x86             |            | **2m 37s**  | **3m 16s**            |
| 30 x86_64          | 2m 35s     | 3m 19s      | 5m 46s                |
| 31 x86_64          | **2m 12s** | 2m 59s      | 4m 51s                |
| 32 x86_64          |            | 3m 27s      | 3m 56s                |
| 33 x86_64          |            | 3m 21s      | 3m 28s                |
| 34 x86_64          |            | 3m 1s       | 4m 28s                |

All [35 runs](https://github.com/retyui/Using-GitHub-Actions-to-run-your-Maestro-Flows/actions/runs/5794918229)
above cost me `$0.62` and took `154min` using 2vCPU (_info from billing portal page_)

## [Genymotion SaaS](https://cloud.geny.io/)

Using Genymotion SaaS you can create a remote adb connection to a virtual device and run your Maestro E2E tests on it.

- Config: [`android-genymotion-cloud.yaml`](.github/workflows/android-genymotion-cloud.yaml) Android only
- Price: [`$0.05` per minute](https://docs.genymotion.com/saas/03_1_Pricing/#pay-as-you-go) _Pay as you Go_ plan
- `2` concurrent devices
- First run can take up to `5` minutes

| version     | time   | 
|-------------|--------|
| Android 13  | 2m 04s | 
| Android 12  | 2m 04s |
| Android 11  | 1m 46s |
| Android 10  | 2m 30s |
| Android 9   | 2m 10s |
| Android 8.1 | 2m 18s |
| Android 8   | 2m 05s |

On
dashboard [7 all runs](https://github.com/retyui/Using-GitHub-Actions-to-run-your-Maestro-Flows/actions/runs/5799031874)
above took `10min` and cost `$0.5`

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

On billing details page: two runs above took `9min` and cost `$0.45` (ios: `$0.38`, android: `$0.07`)

## [Maestro Cloud](https://cloud.mobile.dev/)

- Config [android-and-ios-maestro-cloud.yaml](.github/workflows/android-and-ios-maestro-cloud.yaml) include Android &
  iOS e2e workflows
- [Price](https://console.mobile.dev/pricing-calculator): 1 Flow Run `$0.10`
- [Limits](https://cloud.mobile.dev/reference/limits):
    - **iOS:** ~7min flow runtime, ~7min video output
    - **Android:** ~7min flow runtime, ~3min video output
    - [Limited amount](https://cloud.mobile.dev/reference/device-configuration) of Android & iOS versions

| platform       | time       |
|----------------|------------|
| Android API 29 | 1m 10s     |
| Android API 30 | 1m 21s     |
| Android API 31 | **1m 8s**  |
| Android API 33 | 1m 10s     |
| iOS 15         | **0m 49s** |
| iOS 16         | 1m 9s      |

More
info
about [runs above...](https://github.com/retyui/Using-GitHub-Actions-to-run-your-Maestro-Flows/actions/runs/5790998389)

## Nice to know:

- Samsung Remote Test Lab
- BrowserStack App Automate
