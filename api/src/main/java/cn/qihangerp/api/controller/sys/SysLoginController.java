package cn.qihangerp.api.controller.sys;

import cn.qihangerp.common.sys.SysUser;
import cn.qihangerp.model.request.LoginBody;
import cn.qihangerp.model.entity.SysMenu;
import cn.qihangerp.service.service.ISysMenuService;
import cn.qihangerp.service.service.SysPermissionService;
import cn.qihangerp.security.common.Constants;
import cn.qihangerp.common.AjaxResult;
import cn.qihangerp.security.common.SecurityUtils;
import cn.qihangerp.security.service.SysLoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 登录验证
 * 
 * @author qihang
 */
@RestController
public class SysLoginController
{
    @Autowired
    private SysLoginService loginService;

    @Autowired
    private ISysMenuService menuService;

    @Autowired
    private SysPermissionService permissionService;

    /**
     * 登录方法
     * 
     * @param loginBody 登录信息
     * @return 结果
     */
    @PostMapping("/login")
    public AjaxResult login(@RequestBody LoginBody loginBody)
    {
        try {
            AjaxResult ajax = AjaxResult.success();
            // 生成令牌
            String token = loginService.login(loginBody.getUsername(), loginBody.getPassword(), loginBody.getCode(),
                    loginBody.getUuid());
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("accessToken",token);
            map.put("expiresIn",7200);
            map.put("refreshToken",token);
            map.put("tokenType","Bearer");
            ajax.put("data",map);
            ajax.put(Constants.TOKEN, token);
            return ajax;
        }catch (Exception e){
            return AjaxResult.error(e.getMessage());
        }
    }

    /**
     * 获取用户信息
     * 
     * @return 用户信息
     */
    @GetMapping("getInfo")
    public AjaxResult getInfo()
    {
        SysUser user = SecurityUtils.getLoginUser().getUser();
        // 角色集合
        Set<String> roles = permissionService.getRolePermission(user);
        // 权限集合
        Set<String> permissions = permissionService.getMenuPermission(user);
        AjaxResult ajax = AjaxResult.success();
        ajax.put("user", user);
        ajax.put("roles", roles);
        ajax.put("permissions", permissions);
        return ajax;
    }

    /**
     * 获取路由信息
     * 
     * @return 路由信息
     */
    @GetMapping("getRouters")
    public AjaxResult getRouters()
    {
        Long userId = SecurityUtils.getUserId();
        List<SysMenu> menus = menuService.selectMenuTreeByUserId(userId);
        return AjaxResult.success(menuService.buildMenus(menus));
    }
}
