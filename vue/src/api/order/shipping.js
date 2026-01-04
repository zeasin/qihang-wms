import request from '@/utils/request'

// 查询
export function listShipping(query) {
  return request({
    url: '/shipping/list',
    method: 'get',
    params: query
  })
}

export function getLogistics(id) {
  return request({
    url: '/api/logistics/' + id,
    method: 'get'
  })
}

// 新增
export function handShip(data) {
  return request({
    url: '/api/oms-api/shipping/handShip',
    method: 'post',
    data: data
  })
}


export function searchOrderConsignee(query) {
  return request({
    url: '/api/oms-api/shipping/searchOrderConsignee',
    method: 'get',
    params: query
  })
}


export function searchOrderItemByReceiverMobile(query) {
  return request({
    url: '/api/oms-api/shipping/searchOrderItemByReceiverMobile',
    method: 'get',
    params: query
  })
}

export function stockOut(data) {
  return request({
    url: '/ship/generate_stock_out_entry',
    method: 'post',
    data: data
  })
}
