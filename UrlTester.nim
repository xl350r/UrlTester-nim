import httpclient, asyncdispatch, os, threadpool

if paramCount() == 0:
    echo("no arguements passed for ", paramStr(0))
    quit()

var file = paramStr(1)

if not existsFile(file):
    echo(file, "does not exist!")
    quit()

var dat = open(file)

var prox: Proxy
if paramCount() == 2:
    prox = newProxy(paramStr(2))
else:
    prox = nil

proc get(url: string; prox: Proxy = nil): Future[AsyncResponse] = 
    var client = newAsyncHttpClient(proxy = prox) 
    client.headers = newHttpHeaders({"User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36"})
    let content = client.get(url) # returrns Response or Future[AsyncResponse]
    client.close()
    result = content # result is a magic return var

proc pget(url: string; prox: Proxy = nil) =
    try:
        var requrl: string
        if url[0..3] != "http": 
            requrl = "http://" & url
        else:
            requrl = url
        let response = waitfor get(requrl, prox = prox)
        echo url & "\t" & response.status 
    except:
        echo(url & "\t" & "Error: " & " Something Went Wrong Suppressing stacktraces") #& getCurrentExceptionMsg()) # async generates FAT stacktraces

for url in dat.lines:
    try: 
        spawn pget("http://" & url, prox = prox)
        spawn pget("https://" & url, prox = prox)
        sleep(200)
    except:
        echo(url & "\t" & "Error" )#& getCurrentExceptionMsg())
        continue

sync()
