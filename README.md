# Zmap-ProxyScanner

* cách nhanh chóng để tìm proxy. Tìm 2000-5000 proxy http,socks4,socks5 đang hoạt động trong một lần quét.

![379e86d10c8e05e9d21a20647d37c70ea0d5e976c72a44a2a5506c88d31e5cf3](https://user-images.githubusercontent.com/65712074/195901928-721235f2-163e-4266-ae4e-d7c76b2626d2.png)

# Config
  ```json
   {
    "check-site": "https://google.com",
    "proxy-type": "http",

    "http_threads": 2000,
    "headers": {
      "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/102.0.5005.115 Safari/537.36",
      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8"
    },
    "print_ips": {
      "enabled": true,
      "display-ip-info": true
    },
    "timeout": {
      "http_timeout": 5,
      "socks4_timeout": 5,
      "socks5_timeout": 5
    }
  }
  ```
# Flag Args
  ```shell
-p <port> - Cổng bạn muốn quét.
-o <proxies.txt> - Ghi lượt truy cập proxy vào tập tin.
-input <proxies.txt> - Tải danh sách proxy và kiểm tra nó.
-url https://api.com/proxies - Tải proxy từ api và kiểm tra nó.
  ```


# Đặc trưng
  * Quét toàn bộ thế giới để tìm proxy http, socks4 và socks5.
  * Trình quét proxy tệp sẵn có + (từ url)
  * Hiển thị ISP, Quốc gia
  
# Build
  > yêu cầu go v1.19+

  > zmap

  > screen

  ***cài đặt trên centos***
  ```
  yum install -y screen
  yum install -y zmap
  curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
  source ~/.gvm/scripts/gvm
  gvm install go1.19
  gvm use go1.19 --default
  ```
  ***cài đặt trên ubuntu***
  ```
  apt install -y screen
  apt install -y zmap
  curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
  source ~/.gvm/scripts/gvm
  gvm install go1.19
  gvm use go1.19 --default
  ```
  ***cài đặt chương trình***
  ```shell
  git clone https://github.com/DauDau432/ScanProxies
  cd ScanProxies
  go build
  ```
  ***kiểm tra đã cài đầy đủ yêu cầu hay chưa***
  ```
  bash <(curl -Ls https://raw.githubusercontent.com/DauDau432/ScanProxies/main/check.sh)
  ```

# Ví dụ chạy
  ***Hãy chắc chắn sử dụng Dịch vụ lưu trữ cho phép Portscan giống như*** https://pfcloud.io
  ```shell
  zmap -p 8080 | ./ZmapProxyScanner -p 8080
  ```
  ```
  screen -S ScanProxies -dm sh scan.sh
  screen -r ScanProxies
  ```
  ***hết session scan thì copy all proxy qua file phụ***
  ```shell
  cat output.txt >> proxy.txt
  ```
# Nguồn [https://github.com/Yariya/Zmap-ProxyScanner.git](https://github.com/Yariya/Zmap-ProxyScanner.git)
