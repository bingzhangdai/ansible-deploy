alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"
# public ip over proxy
alias ipaddr='curl ipinfo.io/ip'
# real public ip
alias digip='dig +short myip.opendns.com @resolver1.opendns.com'
# always include the first line
alias ports='lsof -i | awk "NR==1 || /LISTEN/"'
