<template>
  <a-layout id="app-layout">
    <a-layout-sider
      v-model="collapsed"
      :trigger="null"
      collapsible
      :class="`${fullScreenFlag ? 'sider-scroll' : 'sider-full-screen'}`"
    >
      <a-tooltip placement="right" title="点击可以折叠左侧菜单栏">
        <div class="logo" @click="changeCollapsed()">
          <img :src="logoUrl || defaultLogo" alt="logo" />
          {{ subTitle }}
        </div>
      </a-tooltip>
      <side-menu class="side-menu" :mode="mode" />
    </a-layout-sider>
    <a-layout>
      <a-layout-header class="app-header">
        <content-tab :mode="mode" />
      </a-layout-header>
      <a-layout-content
        :class="`layout-content ${fullScreenFlag ? 'layout-content-scroll' : 'layout-content-full-screen'}`"
      >
        <keep-alive>
          <router-view />
        </keep-alive>
      </a-layout-content>
    </a-layout>
  </a-layout>
</template>
<script setup lang="ts">
import SideMenu from './side-menu'
// import UserHeader from "./user-header";
import ContentTab from './content-tab'
import { checkSystem, loadingLogo } from '@/api/install'
import { useAppStore } from '@/stores/app'
import { useGuideStore } from '@/stores/guide'
import defaultLogo from '@/assets/images/jpom.png'

defineProps({
  mode: {
    type: String,
    required: true
  }
})

const collapsed = ref(false)
const subTitle = ref('项目运维')
const logoUrl = ref('')
const fullScreenFlag = ref(false)
const appStore = useAppStore()
const guideStore = useGuideStore()
onMounted(() => {
  checkSystemHannder()

  collapsed.value = appStore.getCollapsed
})

const router = useRouter()
const route = useRoute()

// 检查是否需要初始化
const checkSystemHannder = () => {
  checkSystem().then((res) => {
    if (res.data) {
      jpomWindow.routerBase = res.data.routerBase || ''
      if (res.data.subTitle) {
        subTitle.value = res.data.subTitle
      }

      // 禁用导航
      guideStore.commitGuide({
        disabledGuide: res.data.disabledGuide ? true : false,
        extendPlugins: res.data.extendPlugins as string[]
      })

      $notification.config({
        placement: res.data.notificationPlacement ? res.data.notificationPlacement : 'topRight'
      })
    }
    if (res.code !== 200) {
      $notification.warn({
        message: res.msg
      })
    } else {
    }
    if (res.code === 999) {
      router.push('/system/ipAccess')
    } else if (res.code === 222) {
      router.push('/install')
    }
  })

  loadingLogo().then((res) => {
    logoUrl.value = res.data || ''
  })
}
const changeCollapsed = () => {
  collapsed.value = !collapsed.value
  appStore.collapsed(collapsed.value)
}
</script>
<style scoped>
#app-layout {
  min-height: 100vh;
}

#app-layout .icon-btn {
  float: left;
  font-size: 18px;
  line-height: 64px;
  padding: 0 14px;
  cursor: pointer;
  transition: color 0.3s;
}

#app-layout .trigger:hover {
  color: #1890ff;
}

#app-layout .logo {
  width: 100%;
  cursor: pointer;
  height: 32px;
  margin: 20px 0 12px;
  font-size: 20px;
  color: #fff;
  font-weight: bold;
  overflow: hidden;
  padding: 0 16px;
}

#app-layout .logo img {
  height: 26px;
  vertical-align: sub;
  margin-right: 6px;
}

.app-header {
  display: flex;
  background: #fff;
  padding: 10px 10px 0;
  height: auto;
}

.sider-scroll {
  min-height: 100vh;
  overflow-y: auto;
}

.sider-full-screen {
  height: 100vh;
  overflow-y: scroll;
}

.layout-content-scroll {
  overflow-y: auto;
}

.layout-content-full-screen {
  height: calc(100vh - 120px);
  overflow-y: scroll;
}
</style>

<style>
.layout-content {
  margin: 0;
  padding: 15px 15px 0;
  background: #fff;
  /* min-height: 280px; */
}

.drawer-layout-content {
  min-height: calc(100vh - 85px);
  overflow-y: auto;
}
</style>
