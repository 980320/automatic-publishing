<script setup>
import zhCN from 'ant-design-vue/es/locale/zh_CN'
import dayjs from 'dayjs'
import 'dayjs/locale/zh-cn'

dayjs.locale('zh-cn')
</script>

<template>
  <a-config-provider :locale="zhCN">
    <main font-sans p="x-4 y-10" text="center gray-700 dark:gray-200">
      <RouterView />
      <TheFooter />
    </main>
  </a-config-provider>
</template>

<style>
:where(.css-dev-only-do-not-override-16pw25h).ant-btn-primary {
  background-color: #1677ff !important;
}
</style>
