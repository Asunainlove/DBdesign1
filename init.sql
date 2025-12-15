CREATE TABLE tourist_info (
    -- 核心主键字段
    tourist_id VARCHAR(32) PRIMARY KEY NOT NULL COMMENT '游客ID，唯一标识，建议格式为T+日期+随机数（如T20251214001）',
    -- 游客身份信息
    name VARCHAR(20) NOT NULL COMMENT '游客姓名',
    id_card CHAR(18) UNIQUE NOT NULL COMMENT '身份证号，唯一绑定游客身份，脱敏存储',
    phone VARCHAR(11) COMMENT '游客联系方式，可选字段',
    -- 入园关联信息（预留预约关联字段）
    reservation_no VARCHAR(32) COMMENT '预约记录编号，预留与预约表的关联字段，后续可加外键',
    entry_time DATETIME COMMENT '实际入园时间，入园时更新',
    exit_time DATETIME COMMENT '实际离园时间，离园时更新',
    entry_type VARCHAR(10) COMMENT '入园方式，枚举值为“线上预约”“现场购票”',
    -- 额外补充业务约束（MySQL8.0+支持CHECK）
    CONSTRAINT chk_entry_exit_time CHECK (exit_time IS NULL OR exit_time > entry_time),
    CONSTRAINT chk_entry_type CHECK (entry_type IN ('线上预约', '现场购票') OR entry_type IS NULL)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='游客智能管理业务线-游客信息表';
