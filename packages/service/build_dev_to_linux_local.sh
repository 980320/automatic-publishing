#!/bin/bash

# 服务器用户
SSH_USER="root"
# 测试环境服务器地址
DEV_SERVER="47.236.178.102"
# 服务器部署目录路径
# REMOTE_PROJECT_PATH="/home/wwwroot/lnmp01/domain/admin.yungoubuy.com/web"
REMOTE_PROJECT_PATH="/Users/wangchao/home/web"
# 前端项目文件存放路径
FRONT_END_PATH="/Users/wangchao/i/automatic-publishing/packages/service/admin"
# 前端项目文件夹名称
FRONT_END_NAME="admin"
# 本地项目打包路径
LOCAL_PROJECT_PATH="./"
# 本地项目打包目录名称
LOCAL_PROJECT_NAME="dist"
# 本地重定向配置文件路径
LoCAL_CONF_PATH="./"
# 打包完成后的目录/文件名称
FILE_NAMES="assets index.html"
# 项目git仓库地址
GIT_REPO="http://47.76.239.164:3000/web/admin.git"
# 项目git分支
GIT_BRANCH="test"

clone_project() {
    echo "clone project..."
    # 删除本地项目
    rm -rf admin
    # 克隆项目到本地
    git clone -b $GIT_BRANCH $GIT_REPO
    echo "clone project done..."

    # 进入前端项目目录
    cd $FRONT_END_PATH
    echo "install depend..."
    # 安装依赖
    pnpm install
    echo "build dev..."
    # 打包测试环境
    pnpm build:dev

}


upload_project() {
    # 进入前端项目目录
    cd $FRONT_END_PATH
    echo "gtar file ..."
    # 压缩打包文件
    gtar -czvf $LOCAL_PROJECT_NAME.tar.gz $LOCAL_PROJECT_NAME
    echo "build dev done..."
    
    echo "remove old project file..."
    # 删除服务器文件
    cd $REMOTE_PROJECT_PATH && rm -rf *
    echo "remove old project file done..."
    sleep 3
    echo "upload new project file..."
    # 上传打包文件
    cd $FRONT_END_PATH
    # scp -r $LOCAL_PROJECT_NAME.tar.gz $SSH_USER@$DEV_SERVER:$REMOTE_PROJECT_PATH
    cp -r $LOCAL_PROJECT_NAME.tar.gz $REMOTE_PROJECT_PATH
    
    # 解压打包文件，移动文件到部署目录
    # ssh $SSH_USER@$DEV_SERVER "cd $REMOTE_PROJECT_PATH && tar -xzvf $LOCAL_PROJECT_NAME.tar.gz && cd $LOCAL_PROJECT_NAME && mv * ../"
    cd $REMOTE_PROJECT_PATH && tar -xzvf $LOCAL_PROJECT_NAME.tar.gz && cd $LOCAL_PROJECT_NAME && mv * ../
    # 删除压缩打包文件，解档剩余的空目录
    # ssh $SSH_USER@$DEV_SERVER "cd $REMOTE_PROJECT_PATH && rm -f $LOCAL_PROJECT_NAME.tar.gz && rm -rf $LOCAL_PROJECT_NAME"
    cd $REMOTE_PROJECT_PATH && rm -f $LOCAL_PROJECT_NAME.tar.gz && rm -rf $LOCAL_PROJECT_NAME
    # 删除本地的压缩打包文件
    rm -f $LOCAL_PROJECT_NAME.tar.gz
    echo "uplaod new project file done..."
}


# clone_project

upload_project

echo "script execution complated. press any key to exit..."
# 脚本执行完成 等待退出
# read -n 1 -s -p "press any key to continue..." key

# 退出
exit 0


