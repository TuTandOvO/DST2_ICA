CREATE TABLE IF NOT EXISTS `page_visits` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `page_path` varchar(255) NOT NULL COMMENT '页面路径',
  `visit_count` int(11) NOT NULL DEFAULT '0' COMMENT '访问次数',
  `last_visit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后访问时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_page_path` (`page_path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='页面访问统计';

CREATE TABLE IF NOT EXISTS `visit_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `page_path` varchar(255) NOT NULL COMMENT '页面路径',
  `ip_address` varchar(50) DEFAULT NULL COMMENT '访问IP',
  `user_agent` varchar(500) DEFAULT NULL COMMENT '浏览器信息',
  `visit_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '访问时间',
  `username` varchar(100) DEFAULT NULL COMMENT '用户名(如已登录)',
  PRIMARY KEY (`id`),
  KEY `idx_page_path` (`page_path`),
  KEY `idx_visit_time` (`visit_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='访问日志详情'; 