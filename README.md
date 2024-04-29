
# AriticleSimilarity

写简介

# Installation

  ## 1.docker
  
   1.1 Pull the code to a local directory
   
     $ git clone https://github.com/ADAQIQI/AriticleSimilarity.git
     
   1.2 下载模型放到指定目录，可以在https://huggingface.co/上下载  以bert模型为例，下载后放到同一目录下

   ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/e5d54c71-52d5-45eb-a416-e73b6f5d5df8)

   ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/e8e4cf34-99ec-44cf-b7cf-873df537f234)



    




    1.3 若使用其他模型需要修改dockerfile文件及类

       ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/e3fbbff4-595e-4eec-be49-52bd4cac4559)


       修改为你所下模型文件夹名。
    
   1.4 docker-compose up -d启动

       ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/9b23ca10-7cb0-4e08-8970-cf18681093b6)


       如果所用模型并非bert，需要修改ArticleSimilarity.Vector类的GetEmbeddingPy方法，将文件夹名改为相应文件夹
       
       ![image](https://github.com/ADAQIQI/AriticleSimilarity/assets/168393168/b3e84558-6e9e-48ea-aab0-9e5c30ecbabd)



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





    
