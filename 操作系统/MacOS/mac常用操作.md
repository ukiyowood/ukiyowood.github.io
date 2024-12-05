## 刷新dns
```Shell
sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder
```