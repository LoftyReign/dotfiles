### for the ftp mout thing:
- put this in /etc/fstab:
'''
curlftpfs#<host>/<path> <mount/path> fuse auto,rw,user,uid=1000,allow_other,_netdev,nofail 0 0
'''
- put this in /root/.netrc
'''
machine <host>
login <username>
password <password>
'''
