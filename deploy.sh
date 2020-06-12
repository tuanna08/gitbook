#! /bin/bash

# 提交到master
git add .                             # 将源文件暂存
git commit -a -m "commit master xxx"  # 提交到本地仓库

# 准备发布
git checkout gh-pages    # 检出pagss分支，首次命令git checkout -b gh-pages master
git reset --hard master  # 将gh-pages分支重置为与master分支内容一致

# 在gp-pages分支下，保留_book和node_modules目录和隐藏文件，其余内容全部删除
for file in `ls $1`  #注意此处这是两个反引号，表示运行系统命令。
do
    if [ $file = "_book" ] || [ $file = "node_modules" ]
    then
      echo "保留: $file"
    else
      rm -rf $file
    fi
done

cp -r _book/* .          # 将静态站点文件复制到gitbook根目录
git add .                # 将源文件暂存
git commit -a -m "commit gh-pages xxx"  # 提交到本地仓库

# 发布所有分支               # 码云刷新页面: https://gitee.com/uav360/gitbook/pages
git push -f --all origin    # 推送回远程代码仓库，如果没有更新，手动更新码云pages服务。

# 返回master分支
git checkout -f master    
