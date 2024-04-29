Class ArticleSimilarity.GetArticlesentenceBussinessOperation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Parameter SETTINGS;

Method OnMessage(request As ArticleSimilarity.MSG.Request, Output response As Ens.StringContainer) As %Status
{
	   
       #dim sc As %Status = $$$OK
       Do ..InsertEmbeddings(request.Title1Name)
       Do ..InsertEmbeddings(request.Title2Name)
       return sc
}

// 获取到txt文本内容后存储到指定文件夹

// 逐段存入数据库

ClassMethod InsertEmbeddings(Title1)
{
	    ///
	    set insertquery="Insert into ArticleSimilarity.SentenceVector(Title,ParagraphNumber,sentence,Embedding) Values(?,?,?, TO_VECTOR(ArticleSimilarity.Vector_GetEmbeddingPy(?),double))"
		//set ^b2=myquery
        set sc=$$$OK
        set iStatement = ##class(%SQL.Statement).%New()
        $$$ThrowOnError(iStatement.%Prepare(insertquery))
	    set myquery="select * from ArticleSimilarity.Vector where Title = '"_Title1_"' and ParagraphNumber!=0"
		Set statement= ##class(%SQL.Statement).%New()
	    Set qStatus = statement.%Prepare(myquery)
	    Set rset = statement.%Execute()
	    while rset.%Next(){
		    set ParagraphNumber=rset.%Get("ParagraphNumber")
		    set line=rset.%Get("ParagraphContent")
		    set line=$replace(line,"'","""")
		    set listOfStrings = ##class("%Library.ListOfDataTypes").%New()
            //do ..split()
		    set str=..split(line) 
		    //w str,!
		    //set str=$replace(str,"'","""")
		    //W str,!
		    set array=[].%FromJSON($replace(str,"['","["""))
		    //w array.%ToJSON(),!
		    for i=0:1:array.%Size()-1
		    {
			    //w array.%Get(i),!
			    if $replace(array.%Get(i)," ","")'=""{
			       Do iStatement.execute(Title1,ParagraphNumber,array.%Get(i),array.%Get(i))
			    }
			     
			}
		    //按句插入   
	   }
   Quit $$$OK
}

ClassMethod split(txt) As %List [ Language = python ]
{
  import re
  import json
  import numpy as np
  #txt = "按标点符号分割,中文，测试测试；"
  pattern = "[,|.|?|!|，|。|？|！]"
  #r',|\.|/|;|\'|`|\[|\]|<|>|\?|:|"|\{|\}|\~|!|@|#|\$|%|\^|&|\(|\)|-|=|\_|\+|，|。|、|；|‘|’|【|】|·|！| |…|（|）'
  listOfStrings = re.split(pattern, txt)
 
  #print(listOfStrings)
  keys = [str(x) for x in np.arange(len(listOfStrings))]
  list_json = dict(zip(keys, listOfStrings))
  str_json = json.dumps(list_json, indent=2, ensure_ascii=False)  # json转为string
  #print(str_json)
  return str_json
}

}

