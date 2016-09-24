## Compile PHP5
Download source code and uncompress it.
```
wget http://si1.php.net/distributions/php-5.6.25.tar.xz
tar xJf php-5.6.25.tar.xz
```
Move ```debian``` directory inside ```php-5.6.25``` directory:
```
mv debian php-5.6.25/
```
Install PHP5 build dependencies.
```
sudo apt-get build-dep php5
```
Create .deb package
```
cd php-5.6.25/
fakeroot dpkg-buildpackage -b
```
