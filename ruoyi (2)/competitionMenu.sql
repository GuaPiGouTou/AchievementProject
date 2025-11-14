-- 菜单 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('竞赛成果', '2000', '1', 'competition', 'competition/competition/index', 1, 0, 'C', '0', '0', 'competition:competition:list', '#', 'admin', sysdate(), '', null, '竞赛成果菜单');

-- 按钮父菜单ID
SELECT @parentId := LAST_INSERT_ID();

-- 按钮 SQL
insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('竞赛成果查询', @parentId, '1',  '#', '', 1, 0, 'F', '0', '0', 'competition:competition:query',        '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('竞赛成果新增', @parentId, '2',  '#', '', 1, 0, 'F', '0', '0', 'competition:competition:add',          '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('竞赛成果修改', @parentId, '3',  '#', '', 1, 0, 'F', '0', '0', 'competition:competition:edit',         '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('竞赛成果删除', @parentId, '4',  '#', '', 1, 0, 'F', '0', '0', 'competition:competition:remove',       '#', 'admin', sysdate(), '', null, '');

insert into sys_menu (menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_by, create_time, update_by, update_time, remark)
values('竞赛成果导出', @parentId, '5',  '#', '', 1, 0, 'F', '0', '0', 'competition:competition:export',       '#', 'admin', sysdate(), '', null, '');