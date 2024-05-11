<script setup lang="ts" generic="T extends any, O extends any">
import axios from 'axios'

defineOptions({
  name: 'IndexPage',
})

axios.defaults.baseURL = 'http://localhost:3000'
axios.defaults.timeout = 1000000

const loading = ref(false)

const columns = [
  {
    title: '项目名称',
    dataIndex: 'name',
    key: 'name',
  },
  {
    title: '发布环境',
    dataIndex: 'env',
    key: 'env',
  },
  {
    title: '发布状态',
    dataIndex: 'status',
    key: 'status',
  },
  {
    title: '操作',
    dataIndex: 'operation',
  },
]

const data = [
  {
    key: '1',
    name: '运营后台',
    env: '测试',
    status: '1',
  },
  {
    key: '1',
    name: 'H5-新版',
    env: '测试',
    status: '1',
  },
]

function handlePublish(name: string) {
  loading.value = true
  console.log(name)
  axios.get('/action/OwnRestartServer').then((res: any) => {
    console.log(res, '===get===')
    loading.value = false
  }).catch((err: any) => {
    console.log(err, '===err===')
    loading.value = false
  })
}
</script>

<template>
  <div>
    <div i-carbon-campsite inline-block text-4xl />
    <div py-4 />
    <div>
      <a-table :columns="columns" :data-source="data" class="my-table">
        <template #bodyCell="{ column, text, record }">
          <template v-if="column.dataIndex === 'name'">
            <a>{{ text }}</a>
          </template>
          <template v-else-if="column.dataIndex === 'operation'">
            <a-button type="link" :loading="loading" @click="handlePublish(record)">
              发布
            </a-button>
          </template>
        </template>
      </a-table>
    </div>
  </div>
</template>

<style scoped>

</style>
