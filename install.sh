#!/bin/bash
# Kiểm tra quyền root
if [ "$EUID" -ne 0 ]; then
    echo " Hãy chạy script với quyền root hoặc sudo."
    exit 1
fi

# Kiểm tra hệ điều hành
if [ -f /etc/os-release ]; then
    source /etc/os-release
    OS=$ID
elif [ -f /etc/system-release-cpe ]; then
    OS=$(awk -F: '{print $3}' /etc/system-release-cpe)
else
    echo " Không thể xác định hệ điều hành"
    exit 1
fi

# Hàm kiểm tra và cài đặt gói cần thiết trên CentOS
install_centos_dependencies() {
    if ! command -v git &> /dev/null; then
        clear
        echo " Cài đặt git"
        yum install -y git
    fi

    if ! command -v screen &> /dev/null; then
        clear
        echo " Cài đặt screen"
        yum install -y screen
    fi

    if ! command -v go &> /dev/null; then
        clear
        echo " Cài đặt go v1.19"
        curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
        source ~/.gvm/scripts/gvm
        gvm install go1.19
        gvm use go1.19 --default
    fi

    if ! command -v zmap &> /dev/null; then
        clear
        echo " Cài đặt zmap"
        yum install -y zmap
    fi
    # Thêm các lệnh cài đặt khác cho CentOS tại đây
}

# Hàm kiểm tra và cài đặt gói cần thiết trên Ubuntu
install_ubuntu_dependencies() {
    if ! command -v git &> /dev/null; then
        clear
        echo " Cài đặt git"
        apt install -y git
    fi

    if ! command -v screen &> /dev/null; then
        clear
        echo " Cài đặt screen"
        apt install -y screen
    fi

    if ! command -v go &> /dev/null; then
        clear
        echo " Cài đặt go v1.19"
        curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
        source ~/.gvm/scripts/gvm
        gvm install go1.19
        gvm use go1.19 --default
    fi

    if ! command -v zmap &> /dev/null; then
        clear
        echo " Cài đặt zmap"
        apt install -y zmap
    fi
    # Thêm các lệnh cài đặt khác cho Ubuntu tại đây
}

# Hàm tắt tường lửa trên CentOS
disable_firewall_centos() {
    sudo service iptables stop
    sudo chkconfig iptables off
    sudo systemctl stop firewalld
    sudo systemctl disable firewalld
}

# Hàm tắt tường lửa trên Ubuntu
disable_firewall_ubuntu() {
    # Thêm lệnh tắt tường lửa cho Ubuntu tại đây
    ufw disable
}

clear
# Thông báo tên hệ điều hành và đợi 3 giây
echo ""
echo " Hệ điều hành: $OS"
sleep 5

# Kiểm tra hệ điều hành và cài đặt gói cần thiết
if [ "$OS" == "centos" ]; then
    install_centos_dependencies
    disable_firewall_centos
elif [ "$OS" == "ubuntu" ]; then
    install_ubuntu_dependencies
    disable_firewall_ubuntu
else
    echo " Hệ điều hành không được hỗ trợ: $OS"
    exit 1
fi
clear
# Thông báo phiên bản các chương trình đã cài và đợi 3 giây
echo ""
echo " Phiên bản git: $(git --version)"
echo " Phiên bản screen: $(screen --version)"
echo " Phiên bản go: $(go version)"
echo " Phiên bản zmap: $(zmap --version)"
sleep 5

# Clone và chạy ứng dụng
rm -rf ScanProxies
git clone https://github.com/DauDau432/ScanProxies/
cd ScanProxies
go build
pkill screen
screen -S ScanProxy -dm sh scan.sh
screen -r ScanProxy
