# UrlTester-nim

Gets status of urls over Async http(s) and returns response type. Reads urls from list.

On older versions of nim getCurrentException() generates large stack traces for async errors. Comment out if it's annoying.

Urls in list must not be prefaced with "http://" or "https://"

Compile with `nim c UrlTester.nim`. The nim compiler should look at UrlTester.nim.cfg for compiler options (ssl and threads).

Binary can be striped afterwards to reduce size.

```sh
Usage: UrlTester.exe urls.lst some-proxy:8080
```
example output:
```sh
PS > .\UrlTester.exe .\urls.lst
http://google.com       200 OK
https://google.com      200 OK
http://msn.com  200 OK
https://msn.com 200 OK
https://serebii.net     200 OK
http://gambling.com     200 OK
https://gambling.com    200 OK
http://serebii.net      200 OK
http://httpvshttps.com  200 OK
https://youtube.com     200 OK
http://youtube.com      200 OK
https://httpvshttps.com 200 OK
http://office.com       200 OK
https://office.com      200 OK
http://catalog.update.microsoft.com     200 OK
https://catalog.update.microsoft.com    200 OK
https://gmail.com       200 OK
http://hotmail.com      200 OK
https://hotmail.com     200 OK
http://gmail.com        200 OK
https://mail.google.com 200 OK
http://mail.google.com  200 OK
https://gamespot.com    200 OK
http://gamespot.com     200 OK
```
