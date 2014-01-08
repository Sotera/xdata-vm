# cdh4pseudo
This module is for Cloudera CDH4 on ubuntu 12.0.4+ platforms.

Installs Cloudera CDH4:
 * Hadoop Pseudo distributed mode
 * Hbase pseudo distributed mode
 * Zookeeper. 
 * Hbase thrift
 * Hbase Rest

## Usage
All you have to do is:
```
include cdh4pseudo
```
And you are ready to go!

### Requires
puppetlabs/stdlib >= 3.2.0

## Future development
Pseudo distributed mode is very practical for development on a VM and Vagrant VM unless you want to test load and locally install full blown solutions it will take it's load very fast. For any bigger usage then local development I suggest getting proper multinode installation and take advantage of the real power of distribution!

I will probably include Oozie, Hive and Hue in the near future, when I need them for development purposes.

Have fun!

> Copyright (c) 2013 Hans-Frederic Fraser hffraser@gmail.com
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
> 
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
> 
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 