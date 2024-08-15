# rime_log_words
Windows端基于lua的记词器

# 使用方法
1.将log_words.lua放到lua文件夹 
2.rime.lua添加`log_words = require("log_words")` 
3.方案文件添加
```yaml
engine:
  processors:
    - lua_processor@log_words  # 记词
``` 
4.托盘图标右键重新部署

然后输入文字就会记录在小狼毫程序目录下，具体可log_words.lua看着改。 
基于性能考虑，log_words.lua只负责记词，使用Python将记录文件转为词库文件。
