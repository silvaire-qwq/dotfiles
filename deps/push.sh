#!/usr/bin/bash

function git-three(){
    sudo git add .
    case $? in
        "0")
            sleep 0
            ;;
        *)
            echo -e "\e[31m==>\e[0m 运行失败。"
            exit 1
            ;;
    esac
    sudo git commit -m "Updated by push.sh"
    case $? in
        "0")
            sleep 0
            ;;
        *)
            echo -e "\e[31m==>\e[0m 运行失败。"
            exit 1
            ;;
    esac
    sudo git push -uf origin main
    case $? in
        "0")
            sleep 0
            ;;
        *)
            echo -e "\e[31m==>\e[0m 运行失败。"
            exit 1
            ;;
    esac
}

echo -e "\e[34m==>\e[0m 尝试推送至 Git 远程仓库"
git-three
case $? in
        "0")
            echo -e "\e[32m==>\e[0m 成功。"
            ;;
        *)
            echo -e "\e[31m==>\e[0m 运行失败。"
            exit 1
            ;;
    esac

