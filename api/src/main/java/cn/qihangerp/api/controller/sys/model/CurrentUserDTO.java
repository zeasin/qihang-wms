package cn.qihangerp.api.controller.sys.model;

import lombok.Data;

import java.util.Set;

/**
 * 当前登录用户对象
 *
 * @author haoxr
 * @since 2022/1/14
 */
@Data
public class CurrentUserDTO {

    //用户ID")
    private Long userId;

    //用户名")
    private String username;

    //用户昵称")
    private String nickname;

    //头像地址")
    private String avatar;

    //用户角色编码集合")
    private Set<String> roles;

    //用户权限标识集合")
    private Set<String> perms;

}
