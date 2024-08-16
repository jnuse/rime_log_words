
local punctuation_set = ".,!?;:\"'()[]{}<>@#&*%-_+=|/\\~`1234567890，。《》：；‘’“”！（）【】「」、？abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

function not_punctuation(char)
    return string.find(punctuation_set, char, 1, true) == nil
end

function on_commit(context)
    local commit_text = context:get_commit_text()

    -- 指定保存文件的绝对路径，不能使用相对路径，否则会报错
    local file_path = "D:\\rime\\weasel-0.16.1\\input_log_word.txt"

    local file, err  = io.open(file_path, "a")
    if file then
        if not_punctuation(commit_text) then
            file:write(commit_text .. "\n")
            file:close()
        end
    else
        log.error("无法打开文件进行写入: " .. err)
    end

end

function inite(env)
    env.engine.context.commit_notifier:connect(on_commit)
end


return
{
 init=inite,
 func=function()
  return 2;
 end,
};
