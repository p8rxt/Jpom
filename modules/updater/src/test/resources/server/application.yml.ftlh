jpom:
  # jpom 数据存储路径, 如果调试模式运行默认路径为【${user.home}/jpom/】,安装运行默认为jar包文件的父级
  path: ${jpom.path!''}
  node:
    # 节点心跳监控时间 （需要大于零） 单位秒 最小配置 5秒
    heart-second: ${system.nodeHeartSecond!30}
    # 上传文件的超时时间 单位秒,最短5秒钟
    upload-file-timeout: ${node.uploadFileTimeOut!300}
  system:
    # cron 定时器是否开启匹配秒
    timer-match-second: ${system.timerMatchSecond!false}
    # 旧包文件保留个数
    old-jars-count: ${system.oldJarsCount!2}
    # Check the url for the new version
    remote-version-url: ${system.remoteVersionUrl!''}
    # 系统日志编码格式
    log-charset: UTF-8
    # 控制台编码格式
    console-charset: ${consoleLog.charset!''}
  user:
    # 用户连续登录失败次数，超过此数将被限制登录
    always-login-error: ${user.alwaysLoginError!5}
    # IP连续登录失败次数，超过此数将被限制登录
    always-ip-login-error: ${user.alwaysIpLoginError!10}
    # 当ip连续登录失败，锁定对应IP时长，5h、1d
    ip-error-lock-time: ${user.ipErrorLockTime!'5h'}
    # 是否强制提醒用户开启  mfa
    force-mfa: ${user.forceMfa!false}
    #登录token失效时间(单位：小时),默认为24
    token-expired: ${jpom.authorize.expired!24}
    #登录token失效后自动续签时间（单位：分钟），默认为60，不自动续签
    token-renewal: ${jpom.authorize.renewal!60}
    # jwt 签名(加密)的key 长度建议控制到 16位
    token-jwt-key:${jpom.authorize.key!''}
  web:
    # 前端接口 超时时间 单位秒(最小 5 秒)
    api-timeout: ${jpom.webApiTimeout!20}
    # 系统名称
    name: ${jpom.name!''}
    # 副标题
    sub-title: ${jpom.subTitle!''}
    # 登录页名称
    login-title: ${jpom.loginTitle!''}
    # logo 文件路径（绝对路径、http） 文件限制后缀:jpg、png、gif
    logo-file: ${jpom.logoFile!''}
    # icon 文件路径（绝对路径、http），建议规格 12×12、16×16、24×24、32×32、48×48 , 文件限制后缀 ico、png
    icon-file: ${jpom.iconFile!''}
    # 禁用页面引导导航
    disabled-guide: ${jpom.disabledGuide!false}
    # 禁用登录图形验证码 （一般用于服务器没有字体或者开启了两部验证后才关闭图形验证码）
    disabled-captcha: ${jpom.disabledCaptcha!false}
    # 前端消息弹出位置，可选 topLeft topRight bottomLeft bottomRight
    notification-placement: ${jpom.notificationPlacement!''}
  # 查看日志时初始读取最后多少行（默认10，0不读取）
  init-read-line: ${log.intiReadLine!10}
  db:
    # 日志存储条数，将自动清理旧数据,配置小于等于零则不清理
    log-storage-count: ${db.logStorageCount!10000}
    # 数据库账号 默认 jpom
    user-name: ${db.userName!'jpom'}
    # 数据库密码 默认 jpom 如果自行配置请保证密码强度
    user-pwd: ${db.userPwd!'jpom'}
    # h2 数据库缓存大小  kilobyte 1KB 1,024 megabyte 1MB 1,048,576
    cache-size: ${db.cacheSize!'50MB'}
    # 自动备份间隔天数 小于等于 0 不自动备份
    auto-backup-interval-day: ${db.autoBackupIntervalDay!'1'}
    # 自动备份保留天数 小于等于 0，不自动删除自动备份数据
    auto-backup-reserve-day: ${db.autoBackupReserveDay!'5'}
    # 数据库连接池相关配置
    max-active: ${db.maxActive!100}
    initial-size: ${db.initialSize!10}
    max-wait: ${db.maxWait!10}
    min-idle: ${db.minIdle!1}
  # 构建相关配置
  build:
    # 最多保存多少份历史记录
    max-history-count: ${build.maxHistoryCount!1000}
    # 单个最多保存多少份历史记录
    item-max-history-count: ${build.itemMaxHistoryCount!50}
    # 构建命令是否检查 存在删除命令
    check-delete-command: ${build.checkDeleteCommand!true}
    # 构建线程池大小,小于 1 则为不限制，默认大小为 5
    pool-size: ${build.poolSize!5}
    # 构建任务等待数量，超过此数量将取消构建任务，值最小为 1
    pool-wait-queue: ${build.poolWaitQueue!10}

server:
  #运行端口号
  port: 2122
  servlet:
    session:
      cookie:
        name: JPOMID-SERVER
      timeout: 1H
    encoding:
      charset: UTF-8
      force: true
      enabled: true
      forceRequest: true
      forceResponse: true
  compression:
    # gzip 压缩
    enabled: true
    #mime-types: application/json,application/xml,text/html,text/xml,text/plain,application/javascript,image/png
    min-response-size: 2048
  tomcat:
    uri-encoding: UTF-8
spring:
  web:
    resources:
      static-locations: classpath:/dist/
  mvc:
    throw-exception-if-no-handler-found: true
    log-request-details: true
  servlet:
    multipart:
      # 上传文件大小限制
      max-request-size: ${max-request-size!'2GB'}
      max-file-size: ${spring.servlet.multipart.max-file-size!'1GB'}
  h2:
    console:
      # 是否开启 web 访问数据库（url: http://${ip}:${port}/h2-console）
      enabled: ${spring.h2.console.enabled!true}
      # 是否允许远程访问（开启此配置有安全风险），默认为 false（当部署到服务器上之后，是否可以通过其他浏览器访问数据库）
      settings:
        web-allow-others: ${spring.h2.console.settings.web-allow-others!false}
