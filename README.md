KURO-RS control panel
=====================
KURO-RS Web Interface.

<img src="http://shokai.org/archive/file/983470b269ddfd9317400801bc410dfe.png">

Dependencies
------------

* Ruby 1.8.7
* MongoDB 2.0+
* Sinatra 1.3+
* [KURO-RS](http://www.kuroutoshikou.com/modules/display/?iid=928) or [PC-OP-RS1](http://buffalo.jp/products/catalog/item/p/pc-op-rs1/)
* kuro-rs (RubyGem)


Install RubyGems
--------------------

    % gem install kuro-rs
    % bundle install


Config
------

    % cp sample.config.yaml config.yaml

edit "config.yaml".


Run
---

start kuro-rs-server on port 8786

    % kuro-rs-server /dev/tty.usbserial-00012a34b5 --port 8786

start Sinatra app

    % ruby development.ru

open [http://localhost:8787](http://localhost:8787)



Deploy
------

use Passenger with "config.ru"
