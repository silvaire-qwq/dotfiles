# ✨ Silvaire's Dotfiles

## 🤔 这是什么？
这是我的 Dotfile（配置文件）仓库。

## 💻 主机
- 系统: Arch Linux
- 型号: HUAWEI Matebook X Pro (2018)
- CPU: Intel i7-8550U (8)
- 显卡: Intel UHD Graphics 620
- 内存: 8GB

## 🧐 位置
- 你可以在 /config 文件夹找到我 ~/.config 下的配置。
- 你可以在 /home 文件夹找到我 ~ 下的配置 (多为隐藏)。
- 你可以在 /etc 文件夹找到 /etc 下的配置 (目前没有)。
- 你可以在 /pkg.list 看到我安装了什么软件。

## ⌚ 重现
> [!CAUTION]
> 1. 请在使用前备份您已有的配置。
> 2. 如果配置文件有问题，作者不承担任何责任。
```bash
# 克隆仓库
git clone https://github.com/silvaire-qwq/dotfiles.git

# 进入仓库文件夹
cd ./dotfiles

# 安装所有软件
cat ./pkg.list | sudo pacman -S -

# 重现 ~/.config
sudo cp -rv ./config/* ~/.config
sudo cp -rv ./config/.* ~/.config # 大概率没有隐藏文件，如果没有可能会报错，但不会发生任何改变。

# 重现 ~
sudo cp -rv ./home/* ~ # 大概率没有非隐藏文件，如果没有可能会报错，但不会发生任何改变。
sudo cp -rv ./home/.* ~

# 重现 /etc
[[ ! -d ./etc ]] || sudo cp -rv ./etc/* /etc
[[ ! -d ./etc ]] || sudo cp -rv ./etc/.* /etc # 大概率没有隐藏文件，如果没有可能会报错，但不会发生任何改变。
```
