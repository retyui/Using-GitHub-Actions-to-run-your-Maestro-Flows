# Using-GitHub-Actions-to-run-your-Maestro-Flows

## Codemagic

- Config [codemagic.yaml](codemagic.yaml) include Android & iOS e2e workflows
- Provide [`500` free build minutes](https://docs.codemagic.io/billing/pricing/#1-free-plan) per month on macOS M1
  Standard VM (`instance_type: mac_mini_m1`)
  standard VM
- To use `instance_type: linux` you need to add credit card
- The [Codemagic annual plan](https://docs.codemagic.io/billing/pricing/#2-fixed-annual-plan) gives you a fixed-price
  plan with the following benefits:
    - `3` concurrencies (with access to Mac mini M2, macOS M1 & Intel, Linux, and Windows instances)
    - **Unlimited build minutes** 😱

| platform   | `instance_type` | cpu                          | ram  | time  | cost                                                     |
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
