import datetime

inpath = r"D:\rime\user\lua\input_log_word.txt"
outpath = r"D:\rime\user\cn_dicts\diy.dict.yaml"
words = []
sat = {}
with open(inpath,"r",encoding="utf-8") as f:
    words = f.read().split("\n")

for w in words:
    if sat.get(w,False):
        sat[w]+=1
    else:
        sat[w]=100

'''
# 第一次完整的词库
txt = """# Rime dictionary
# encoding: utf-8
---
name: diy
version: "time"
sort: by_weight
columns:
  - text
  - weight
...
"""
txt = txt.replace("time",datetime.datetime.now().strftime("%Y-%m-%d"))

for k,v in sat.items():
    if k:
        txt = txt+k+" "+str(v)+"\n"

with open(outpath,"w",encoding="utf-8") as f:
    f.write(txt)
'''


txt = """# Rime dictionary
# encoding: utf-8
---
name: diy
version: "time"
sort: by_weight
columns:
  - text
  - weight
...
"""
txt = txt.replace("time",datetime.datetime.now().strftime("%Y-%m-%d"))
pre_dict = {}

# 追加词库
with open(outpath,"r",encoding="utf-8") as f:
    pre = f.read().split("...")[1].split("\n")

for line in pre:
    if line:
        kv = line.split(" ")
        pre_dict[kv[0]] = int(kv[1])


for k,v in sat.items():
    v-=99
    if k:
        if pre_dict.get(k,False):
            pre_dict[k]+=v
        else:
            pre_dict[k]=99+v

for k,v in pre_dict.items():
    if k:
        txt = txt+k+" "+str(v)+"\n"

# print(txt)

with open(outpath,"w",encoding="utf-8") as f:
    f.write(txt)

with open(inpath,"w",encoding="utf-8") as f:
    f.write("")
