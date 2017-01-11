/*jshint multistr:true */

/*
Think about how you might fine-tune this program to make sure it only finds exact matches for your name.
Search the Internet to see if there are any built-in JavaScript string methods that can help!
*/

var text = "jwefbwebwefbyonatanwefbwibfibfweyfieyfrgyvbau\
evybakjshjbvkvbdsjvbyonatanaseoyvbowabviesyonatan vubarebv\
iwevr!#@$%$YRTHDv6u5yvtcB%YEVASHTyonatanmverinbaonvryonatu\
arngauern"

var myName = "yonatan"

var hits = []

for (i=0; i < text.length; i++) {
    if (text[i] === myName[0]){
        for (j = i; j < i + myName.length; j++) {
            hits.push(text[j])
        }
    }
}

if (hits.length > 0){
    console.log(hits)
}
else {
    console.log("Your name wasn't found!")
}
