# fnOS app test report

- Generated: 2026-07-25 15:35:48
- VM `10.211.55.6` · volume `/vol1` · arch `x86` · filter `docker`

| App | download | install | register | start | port | volume | uninstall | result |
|-----|:--------:|:-------:|:--------:|:-----:|:----:|:------:|:---------:|:------:|
| it-tools | PASS | PASS | PASS | PASS:running | PASS | PASS | PASS | **PASS** |
| dpanel | PASS | PASS | PASS | PASS:running | PASS | PASS | PASS | **PASS** |
| homepage | PASS | FAIL:	/app/main.go:17 +0xda | FAIL:Not Installed | SLOW:noinstall | DOWN | FAIL: | PASS | **FAIL** |
| uptime-kuma | PASS | PASS | PASS | PASS:running | PASS | PASS | PASS | **PASS** |

## Summary

**Total 4 · PASS 3 · FAIL 1**

Failed: homepage
