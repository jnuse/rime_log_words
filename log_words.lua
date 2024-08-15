
-- 定义常见标点符号的集合
local punctuation_set = ".,!?;:\"'()[]{}<>@#&*%-_+=|/\\~`1234567890，。《》：；‘’“”"

-- 判断字符是否为标点符号
function not_punctuation(char)
    return string.find(punctuation_set, char, 1, true) == nil
end

-- 定义一个函数，用于处理提交事件
function on_commit(context)
    -- 获取提交的文本内容
    local commit_text = context:get_commit_text()

    -- 指定保存文件的绝对路径
    local file_path = "./input_log_words.txt"

    -- 以追加模式打开文件
    local file = io.open(file_path, "a")
    if file and not_punctuation(commit_text) then
        -- 将提交的文字写入文件并换行
        file:write(commit_text .. "\n")
        file:close()
    else
        -- 文件打开失败时输出错误日志
        log.error("无法打开文件进行写入: " .. file_path)
    end

end

local is_initialized = false
-- 初始化函数，在输入法加载时运行
function init(env)
    -- 如果已经初始化过，不再重复初始化
    if is_initialized then
        return
    end

    -- 连接 commit_notifier，监听提交事件

    env.engine.context.commit_notifier:connect(on_commit)

    -- 设置标志位，标记初始化已经完成
    is_initialized = true
end

-- 返回初始化函数
return { init = init }
