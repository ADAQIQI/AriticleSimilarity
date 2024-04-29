![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/dabd804d-654d-47c8-a002-1605fee23f67)

# AriticleSimilarity

写简介

# Installation

  ## 1.docker
  
   1.1 Pull the code to a local directory
   
     $ git clone https://github.com/ADAQIQI/AriticleSimilarity.git
     
   1.2 下载模型放到指定目录，可以在https://huggingface.co/上下载  以bert模型为例，下载后放到同一目录下

     ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/76aabbed-d421-4f8a-bd3b-9a5db0e882ab)

     ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/04365f2c-72d8-46f1-a2aa-e742442a20ba)
     
     ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/bcc8e592-93cd-4714-8f72-9f64c0afea63)


    1.3 若使用其他模型需要修改dockerfile文件及类

       ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/8943266e-883f-41eb-a49b-3639b2f7496f)

       修改为你所下模型文件夹名。
    
   1.4 docker-compose up -d启动
       ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/74395fa1-2d0e-4d91-8e85-4c9de8e31634)

       如果所用模型并非bert，需要修改ArticleSimilarity.Vector类的GetEmbeddingPy方法，将文件夹名改为相应文件夹
       
       ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/407f262d-f26a-449b-bcb2-2654f401608f)


   ## 2.IPM

     zpm install ariticlesimilarity

     参考1.2将模型文件夹放到指定目录

     安装sentence-transformers
     
     python3 -m pip install --target  /usr/irissys/mgr/python sentence-transformers 
   

# How to use

    进入首页 

    http://localhost:52773/csp/user/Index.csp
    
    输入/上传文章标题与内容，演示文本为google-bard生成的文章

    ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/6f33434e-583f-443f-a022-668b3732e48a)

    
    点击上传后等待一段时间页面跳转至段落相似度对比，同时后台还会继续将文章拆分成句子并逐句对比
    

     ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/e9dfcddf-e4fd-4df0-b663-0ede4e6a493c)

     

    ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/3f2ebe3f-c142-46b1-b380-40ddc21afdea)

     

    刷新页面后点击tap3，选择文章标题后点击按钮查看句子相似度对比，相似度高于0.7（可在bo类中修改）的句子将会按颜色区分

    ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/4710c0de-045c-48f0-bced-347febd4ee8b)





    
