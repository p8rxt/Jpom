import axios from "./config";

// 获取系统菜单列表
export function getMenu() {
  return axios({
    url: "/menus_data.json",
    method: "post",
  });
}

// 获取系统菜单列表
export function getSystemMenu() {
  return axios({
    url: "/system_menus_data.json",
    method: "post",
  });
}

/**
 * 节点菜单
 * @param {String} nodeId
 */
export function getNodeMenu(nodeId:string) {
  return axios({
    url: "/menus_data.json",
    method: "post",
    data: { nodeId },
  });
}
