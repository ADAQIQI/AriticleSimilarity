Class ArticleSimilarity.GetSimilarityBussinessOperation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Parameter SETTINGS;

Method OnMessage(request As ArticleSimilarity.MSG.Request, Output response As Ens.StringResponse) As %Status
{
	set response=##class(Ens.StringResponse).%New()
	if (request.Method="getParamSimilarity")||(request.Method="uplaodAriticle"){
	   set response.StringValue=..GetSimiEmbeddings(request.Title1Name,request.Title2Name)
	}else{
		 set response.StringValue=..GetSenSimiEmbeddings(request.Title1Name,request.Title2Name)
	}
	Quit $$$OK
}

// 获取到txt文本内容后存储到指定文件夹

// 逐段存入数据库

ClassMethod GetSimiEmbeddings(Title1, Title2)
{
	
	
	
	  set result=[]
	  
	set queryStr="select Top 1 ParagraphContent,ParagraphNumber,VECTOR_COSINE(TO_VECTOR(demo.Embedding,double), (select TO_VECTOR(Embedding,double) from ArticleSimilarity.Vector where id=?)) as sim from ArticleSimilarity.Vector as demo where Title ='"_Title2_"'  and ParagraphNumber!=0 ORDER BY sim DESC"
	Set statement1 = ##class(%SQL.Statement).%New()
	Set qStatus = statement1.%Prepare(queryStr) 
	 
    set queryStrAriticle1="select id,ParagraphNumber,ParagraphContent from ArticleSimilarity.Vector where Title='"_Title1_"' and ParagraphNumber!=0"
	Set statementAriticle1= ##class(%SQL.Statement).%New()
	Set qStatus = statementAriticle1.%Prepare(queryStrAriticle1)
	Set rsetAriticle1 = statementAriticle1.%Execute()
	while rsetAriticle1.%Next(){
		set ob={}
		set ob.ParamNum=rsetAriticle1.%Get("ParagraphNumber")
		set ob.content=rsetAriticle1.%Get("ParagraphContent")
		set id=rsetAriticle1.%Get("id")
		Set rset1 = statement1.%Execute(id)
		if rset1.%Next(){
		    set ob.sim=rset1.%Get("sim")
		    set ob.simParamNum=rset1.%Get("ParagraphNumber")
		    set ob.simParam=rset1.%Get("ParagraphContent")
		    Do result.%Push(ob)
	    }
	}
 
    
	
       Quit result.%ToJSON()
}

ClassMethod GetSenSimiEmbeddings(Title1, Title2)
{

	

	
	set result={}
	  ///VECTOR_DOT_PRODUCT
	set queryStr="select Top 1 sentence,ParagraphNumber,VECTOR_COSINE(TO_VECTOR(demo.Embedding,double), (select TO_VECTOR(Embedding,double) from ArticleSimilarity.SentenceVector where id=?)) as sim from ArticleSimilarity.SentenceVector as demo where Title ='"_Title2_"'  and ParagraphNumber!=0 ORDER BY sim DESC"
	Set statement1 = ##class(%SQL.Statement).%New()
	Set qStatus = statement1.%Prepare(queryStr) 
	 
    set queryStrAriticle1="select id,ParagraphNumber,sentence from ArticleSimilarity.SentenceVector where Title='"_Title1_"' and ParagraphNumber!=0"
	Set statementAriticle1= ##class(%SQL.Statement).%New()
	Set qStatus = statementAriticle1.%Prepare(queryStrAriticle1)
	Set rsetAriticle1 = statementAriticle1.%Execute()
	while rsetAriticle1.%Next(){
		
		set ob=result.%Get("Param"_rsetAriticle1.%Get("ParagraphNumber"))
		if ob=""
		{
		   set ob={}	
		   set ob.ParamNum=rsetAriticle1.%Get("ParagraphNumber")
		   &sql(select ParagraphContent into :ParagraphContent from ArticleSimilarity.Vector where ParagraphNumber=:ob.ParamNum and Title =:Title1)
		   set ob.content=ParagraphContent
		   set ob.simParam={}
		   Do result.%Set("Param"_rsetAriticle1.%Get("ParagraphNumber"),ob)
		}
		set ob=result.%Get("Param"_rsetAriticle1.%Get("ParagraphNumber"))
		
		set obsimparam=ob.simParam
		// w 123,!
		//w ob.%ToJSON(),!
		//set ob.content=rsetAriticle1.%Get("ParagraphContent")
		set simcontent={}
		set id=rsetAriticle1.%Get("id")
		Set rset1 = statement1.%Execute(id)
		if rset1.%Next(){
			//w "Param"_rsetAriticle1.%Get("ParagraphNumber"),!
			 if obsimparam.%Get("Param"_rset1.%Get("ParagraphNumber"))'=""
			 {
				 
				 //w "---?1"
			  }ELSE{
				   //w "---?2"
				  set tempob={
                "simParamNum": 1,
                "simcontent": "",
                "sententces": [
                   
                ]
            }
				  set tempob.simParamNum=rset1.%Get("ParagraphNumber")
				  
				  
				  &sql(select ParagraphContent into :ParagraphContent from ArticleSimilarity.Vector where ParagraphNumber=:tempob.simParamNum and Title =:Title2)
		          set tempob.simcontent=ParagraphContent
				 // set tempob.simParam={}
				  //set tempob.sententces=[]
				   //w 123,!
				  Do obsimparam.%Set("Param"_rset1.%Get("ParagraphNumber"),tempob) 
				  //w ob.%ToJSON()
				 
			 }
			
		     set tempob=obsimparam.%Get("Param"_rset1.%Get("ParagraphNumber"))
			 
			 set sentencet={}
			 
			 set sentencet.sentence=rsetAriticle1.%Get("sentence")
			 set sentencet.simsentence=rset1.%Get("sentence")
			 set sentencet.sim=rset1.%Get("sim")
			 if (sentencet.sim>0.9){
			     Do tempob.sententces.%Push(sentencet)
			 }
			  Do obsimparam.%Set("Param"_rset1.%Get("ParagraphNumber"),tempob) 
			 //Do obsimparam.sententces.%Push(sentencet)
			 //Do simparamob.sententces.%Push(sentencet)
			 //w 123,!
		    //Do ob.%Set("Param"_rsetAriticle1.%Get("ParagraphNumber"),simParam)
		    Do result.%Set("Param"_rsetAriticle1.%Get("ParagraphNumber"),ob)
	    }
	}
	w result.%ToJSON(),!
	Quit result.%ToJSON()
}

}

