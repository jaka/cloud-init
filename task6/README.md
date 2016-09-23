## Task 6: Puppet manifests and modules

Install **ntp**:
```
sudo puppet apply ntp.pp
```

Install **nginx** with geoip:
```
sudo puppet apply --modulepath=`pwd`/modules -e "include nginx"
```

Install **docker**:
```
sudo puppet apply docker.pp
```

Install **php5** with fastcgi:
```
sudo puppet apply --modulepath=`pwd`/modules -e "include php5"
```
