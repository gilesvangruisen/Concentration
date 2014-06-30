Concentration
=============

A game of connections and networking

## To play

Clone repo
```
git clone git@github.com:gilesvangruisen/Concentration.git
cd Concentration
```
Make sure cocoapods is installed. If not do:
```
gem install cocoapods
```
Install dependencies
```
pod install
```
Now open the workspace project
```
Open Concentration.xcworkspace
```

This should run fine in simulator but you'll likely have to change bundle identifier and/or provisioning profiles to run on device.

This has been tested primarily on an iPhone 5. As of now, there's a bit of autolayout work required to get things to play well with the shorter screens.

