#!/bin/sh

# Проверка наличия утилиты neofetch
if ! command -v neofetch >/dev/null; then
    read -p "Утилита neofetch не установлена. Хотите установить? (y/n): " answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
        sudo pacman -S neofetch
    fi
fi

# Показать информацию о системе
neofetch

# Запрос на обновление пакетов системы
read -p "Вы хотите обновить пакеты системы? (y/n): " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    # Обновление системы
    sudo pacman -Syyu
fi

# Установка Sublime Text
echo "Установка Sublime Text:"
curl -O https://download.sublimetext.com/sublimehq-pub.gpg
sudo pacman-key --add sublimehq-pub.gpg
sudo pacman-key --lsign-key 8A8F901A
rm sublimehq-pub.gpg

# Канал для использования stable x86_64
echo -e "\n[sublime-text]\nServer = https://download.sublimetext.com/arch/stable/x86_64" | sudo tee -a /etc/pacman.conf

# Установка Sublime Text
read -p "Установить Sublime Text? (y/n): " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    sudo pacman -Syu sublime-text
fi

# Установка Google Chrome
read -p "Установить Google Chrome? (y/n): " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    pamac build google-chrome
fi

read -p "Установить VSCode? (y/n): " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    pamac build visual-studio-code-bin
fi

read -p "Установить Telegram? (y/n): " answer
if [ "$answer" != "${answer#[Yy]}" ]; then
    wget https://telegram.org/dl/desktop/linux?beta=1 -O telegram.tar.xz
    tar xf telegram.tar.xz
    sudo mv Telegram /opt/telegram
    sudo ln -s /opt/telegram/Telegram /usr/bin/telegram
    rm telegram.tar.xz
fi

# Установка зависимостей
sudo pacman -S base-devel multilib-devel gcc repo git gnupg gperf sdl wxgtk2 squashfs-tools curl ncurses zlib schedtool perl-switch zip unzip libxslt bc rsync ccache lib32-zlib lib32-ncurses lib32-readline lib32-gcc-libs flex bison android-tools android-udev libxcrypt-compat

# Сборка и установка пакетов
git clone https://aur.archlinux.org/ncurses5-compat-libs.git && cd ncurses5-compat-libs/ && makepkg -si --skippgpcheck && cd .. && git clone https://aur.archlinux.org/lib32-ncurses5-compat-libs.git && cd lib32-ncurses5-compat-libs/ && makepkg -si --skippgpcheck && cd .. && git clone https://aur.archlinux.org/aosp-devel && cd aosp-devel && makepkg -si --skippgpcheck && cd .. && git clone https://aur.archlinux.org/xml2 && cd xml2 && makepkg -si --skippgpcheck && cd .. && git clone https://aur.archlinux.org/lineageos-devel && cd lineageos-devel/ && makepkg -si --skippgpcheck && cd ..

# Установка необходимых пакетов Java
sudo pacman -S jdk8-openjdk jdk11-openjdk

# Установка imagemagick, pngcrush и lzop
sudo pacman -S imagemagick pngcrush lzop

echo "Финиш"

clear && clear