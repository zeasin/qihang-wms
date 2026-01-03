import request from '@/utils/request'

// 接口拉取订单
export function pullOrder(data) {
  return request({
    url: '/shop/order/pull_order',
    method: 'post',
    data: data
  })
}

export function pullOrderDetail(data) {
  return request({
    url: '/shop/order/pull_order_detail',
    method: 'post',
    data: data
  })
}
