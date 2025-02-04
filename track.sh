#!/bin/bash

function divider() {
  echo -e "\e[90m$(yes "\e[90m─\e[0m" | sed ''''$(stty size | awk '{print $2}')'''q' | tr -d '\n')\e[0m"
}

function red() {
  echo -e "\e[31m==>\e[0;1m $@\e[0m"
}
function yellow() {
  echo -e "\e[33m==>\e[0;1m $@\e[0m"
}
function green() {
  echo -e "\e[32m==>\e[0;1m $@\e[0m"
}
function blue() {
  echo -e "\e[34m==>\e[0;1m $@\e[0m"
}
function pink() {
  echo -e "\e[35m==>\e[0;1m $@\e[0m"
}
function choose() {
  echo -e -n "$@ \e[1m[\e[32mY\e[0;1m/\e[31mn\e[0;1m]\e[0m "
  read user_choice
  if [[ $(echo $user_choice | grep -i "n") ]]; then
    export return=1
  else
    export return=0
  fi
}

function try() {
  blue "$@"
  echo -e -n "\e[90m"
  eval "$@"
  case $? in
  "0")
    echo -e -n "\e[0m"
    ;;
  *)
    echo -e -n "\e[0m"
    yellow "执行失败"
    choose "要使用更高权限尝试执行吗？"
    case $return in
    "0")
      blue "sudo $@"
      echo -e -n "\e[90m"
      sudo $@
      case $? in
      "0")
        echo -e -n "\e[0m"
        ;;
      *)
        echo -e -n "\e[0m"
        red "失败"
        exit 1
        ;;
      esac
      ;;
    "1")
      red "用户已取消"
      ;;
    esac
    ;;
  esac
}

export dir="/home/$USER/Dotfiles"

if [[ $(id -u) -eq "0" ]]; then
  red "无法使用 root 权限执行"
  exit 1
fi

if [[ ! -d "$dir" ]]; then
  yellow "$dir 不存在，正在尝试创建"
  try mkdir $dir
fi

cd "$dir"

if [[ (! -d ".git" && ! -f .manager_lock) || ! -f .manager_lock || ! -d .git ]]; then
  yellow "Git 没有初始化或锁文件读取失败"
  choose "是否初始化 Git 仓库？"
  case $return in
  "1")
    red "用户已取消。"
    exit 1
    ;;
  "0")
    blue "开始初始化仓库"
    ;;
  esac
  try git init
  try git branch -M main
  read -p "请输入 GitHub 用户名: " username
  read -p "请输入 GitHub Token: " token
  read -p "请输入仓库链接 (带”.git“、没有“http(s)://”): " link
  export link="https://"$username":"$token"@"$link""
  try git remote add origin $link
  try touch .manager_lock
  green "已完成初始化"
fi

if [[ ! -f .gitignore ]]; then
  yellow "没有屏蔽锁文件，正在添加到 .gitignore"
  try "echo '/.manager_lock' | sudo tee -a .gitignore"
fi

case $1 in
"update")
  try "rm -rf ./pkg.list"
  try "pacman -Qq >> ./pkg.list"
  try git add .
  try git commit -m 'Auto'
  try git push -uf origin main
  ;;
"config")
  [[ -d config ]] || try mkdir config
  case $2 in
  "add")
    if [[ ! $3 ]]; then
      red "参数不足"
      exit 1
    fi
    for profile in "${@:3}"; do
      pink "准备追踪 $profile"
      if [[ ! -d ~/.config/$profile && ! -f ~/.config/$profile ]]; then
        red "不存在 $profile，跳过"
      else
        try mv -i ~/.config/$profile ./config
        try ln -s $dir/config/$profile ~/.config/$profile
      fi
    done
    unset profile
    ;;
  "rm")
    if [[ ! $3 ]]; then
      red "参数不足"
      exit 1
    fi
    for profile in "${@:3}"; do
      pink "准备删除 $profile"
      if [[ ! -d $dir/config/$profile && ! -f $dir/config/$profile ]]; then
        red "不存在 $profile，跳过"
      else
        try rm -rf ~/.config/$profile
        try mv -i $dir/config/$profile ~/.config/$profile
      fi
    done
    unset profile
    ;;
  esac
  ;;
"home")
  [[ -d home ]] || try mkdir home
  case $2 in
  "add")
    if [[ ! $3 ]]; then
      red "参数不足"
      exit 1
    fi
    for profile in "${@:3}"; do
      pink "准备追踪 $profile"
      if [[ ! -f ~/"$profile" && ! -d ~/"$profile" ]]; then
        red "不存在 $profile，跳过"
      else
        try mv -i ~/"$profile" ./home
        try ln -s $dir/home/"$profile" ~/"$profile"
      fi
    done
    unset profile
    ;;
  "rm")
    if [[ ! $3 ]]; then
      red "参数不足"
      exit 1
    fi
    for profile in "${@:3}"; do
      pink "准备删除 $profile"
      if [[ ! -f $dir/home/"$profile" && ! -d $dir/home/"$profile" ]]; then
        red "不存在 $profile，跳过"
      else
        try rm -rf ~/"$profile"
        try mv -i $dir/home/"$profile" ~/"$profile"
      fi
    done
    unset profile
    ;;
  esac
  ;;
"etc")
  [[ -d etc ]] || try mkdir etc
  case $2 in
  "add")
    if [[ ! $3 ]]; then
      red "参数不足"
      exit 1
    fi
    for profile in "${@:3}"; do
      pink "准备追踪 $profile"
      if [[ ! -f "/etc/$profile" && ! -d "/etc/$profile" ]]; then
        red "不存在 $profile，跳过"
      else
        try sudo mv -i /etc/"$profile" ./etc
        try sudo ln -s $dir/etc/"$profile" /etc/"$profile"
      fi
    done
    unset profile
    ;;
  "rm")
    if [[ ! $3 ]]; then
      red "参数不足"
      exit 1
    fi
    for profile in "${@:3}"; do
      pink "准备删除 $profile"
      if [[ ! -f $dir/etc/"$profile" && ! -d $dir/etc/"$profile" ]]; then
        red "不存在 $profile，跳过"
      else
        try sudo rm -rf /etc/"$profile"
        try sudo mv -i $dir/etc/"$profile" /etc/"$profile"
      fi
    done
    unset profile
    ;;
  esac
  ;;
esac
# Good bye, 2024 :(   (it is 2024/12/31 23:59:59 now!)
