# dief-asf

[![Build Status](https://travis-ci.org/monome/diet-asf.svg?branch=master)](https://travis-ci.org/monome/diet-asf)

This tool is used to generate the `asf` folder for the [monome/libavr32][] repo. It removes files that we don't use and patches others. Currently that results in a size reduction from 1.6 *giga*bytes to 3.2 *mega*bytes. It's a very large repo (sorry GitHub!).

To run, execute:

```sh
git clone https://github.com/monome/diet-asf.git
cd diet-asf
./diet.sh
```

If you wish to reintroduce a file that was deleted from the stock `asf`, or patch it. Please edit `diet.sh` accordingly. Rerun, and copy the `asf` directory over to `libavr32`.

[monome/libavr32]: https://github.com/monome/libavr32:w
