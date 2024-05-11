const { log } = require('node:console')
const Koa = require('koa')
const router = require('koa-router')()
const exec = require('node:child_process').exec

const adminShellBaseURL = '/Users/wangchao/i/automatic-publishing/packages/service/build_dev_to_linux_local.sh'

const reStartPro = adminShellBaseURL

// 初始化Koa实例
const app = new Koa()

// 允许跨域请求
app.use(require('koa2-cors')())

// 对exec进行一个简单的封装，返回的是一个Promise对象，便于处理。
function doShellCmd(cmd) {
  const str = cmd
  const result = {}
  return new Promise((resolve, reject) => {
    exec(str, (err, stdout) => {
      if (err) {
        console.log('err')
        result.errCode = 500
        result.data = '操作失败！请重试'
        reject(result)
      }
      else {
        console.log('stdout ', stdout)// 标准输出
        result.errCode = 200
        result.data = '操作成功！'
        resolve(result)
      }
    })
  })
}

router.get('/action/OwnRestartServer', async (ctx, next) => {
  log('[restartServer] 请求发布项目')
  const result = await doShellCmd(reStartPro)// 调用exec
  console.log('[restartServer] ', result)
  ctx.response.status = result.errCode
  ctx.response.body = result.data
})
app.use(router.routes())
// 监听3000端口
app.listen(3000, () => {
  console.log('Server is running on http://localhost:3000')
})
