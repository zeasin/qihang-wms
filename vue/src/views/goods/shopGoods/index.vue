<template>
  <div class="app-container">
    <el-tabs v-model="activeName" @tab-click="handleClick">
    <el-tab-pane v-for="item in typeList" :label="item.name" :key="item.id" :name="item.code" lazy>
      <goods-tao v-if="item.id === 100"></goods-tao>
      <goods-jd v-else-if="item.id === 200"></goods-jd>

      <goods-pdd v-else-if="item.id === 300"></goods-pdd>
      <goods-dou v-else-if="item.id === 400"></goods-dou>
      <goods-wei v-else-if="item.id === 500"></goods-wei>
<!--      <goods-kwai v-else-if="item.id === 600"></goods-kwai>-->
<!--      <goods-xhs v-else-if="item.id === 700"></goods-xhs>-->
      <ShopGoods v-else :shopType="item.id"></ShopGoods>
<!--      <ShopGoods :shopType="item.id"></ShopGoods>-->
    </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import GoodsTao  from "@/views/tao/goods/index";
import GoodsJd  from "@/views/jd/goods/index";
import GoodsDou  from "@/views/dou/goods/index";
import GoodsPdd  from "@/views/pdd/goods/index";
import GoodsWei  from "@/views/wei/goods/index";

import ShopGoods  from "@/views/shop/goods/index";
import {listPlatform} from "@/api/shop/shop";

export default {
  name: "Goods",
  components:{
    GoodsTao,GoodsJd,GoodsDou,GoodsPdd,GoodsWei,ShopGoods },
  data() {
    return {
      activeName: '',
      typeList: [],
    };
  },
  created() {

  },
  mounted() {
    listPlatform({status:0}).then(res => {
      this.typeList = res.rows;
      this.activeName = this.typeList[0].code
    })
  },
  methods: {
    handleClick(tab, event) {
      console.log(tab, event);
    }
  }
};
</script>
