Class ArticleSimilarity.Vector Extends %Persistent
{

Property Title As %String(MAXLEN = 200);

Property ParagraphNumber As %Integer;

// 段落序号 0的时候为整篇文章

Property ParagraphContent As %String(MAXLEN = "");

// 段落内容

Property Embedding As %Library.Vector(DATATYPE = "double", LEN = 768);

ClassMethod GetEmbeddingPy(text) As %String [ Language = python, SqlProc ]
{
 from transformers import AutoTokenizer,AutoModel
 import torch
 import torch.nn.functional as F
 try:
  sentences = [text]
  #Mean Pooling - Take attention mask into account for correct averaging
  def mean_pooling(model_output,attention_mask):
   token_embeddings = model_output[0] #First element of model_output contains all token embeddings
   input_mask_expanded = attention_mask.unsqueeze(-1).expand(token_embeddings.size()).float()
   return torch.sum(token_embeddings * input_mask_expanded,1) / torch.clamp(input_mask_expanded.sum(1),min=1e-9)

  # Load model from local place

  tokenizer = AutoTokenizer.from_pretrained('/usr/irissys/bert/')
  model = AutoModel.from_pretrained('/usr/irissys/bert/')

  # Tokenize sentences
  encoded_input = tokenizer(sentences,padding=True,truncation=True,return_tensors='pt')

  # Compute token embeddings
  with torch.no_grad():
   model_output = model(**encoded_input)

  # Perform pooling
  sentence_embeddings = mean_pooling(model_output,encoded_input['attention_mask'])

  # Normalize embeddings
  sentence_embeddings = F.normalize(sentence_embeddings,p=2,dim=1)

  return str(sentence_embeddings[0].tolist())       
        
 except Exception as e:
  errorMsg = "SplitAndEmbed Error: "+ str(e)
  print(errorMsg)
  return str(errorMsg)
}

ClassMethod InsertEmbeddings(stream As %FileBinaryStream)
{
	    set myquery="Insert into Embeddings.ArticleSimilarity(Title,ParagraphNumber,ParagraphContent,Embedding) Values(?,?,?, TO_VECTOR(Embeddings.ArticleSimilarity_EmbeddingPy(?),double))"
		//set ^b2=myquery
        set sc=$$$OK
        set tStatement = ##class(%SQL.Statement).%New()
        $$$ThrowOnError(tStatement.%Prepare(myquery))
	//w ##class(Embeddings.ArticleSimilarity).EmbeddingPy(Content),!
       set Title=stream.Filename
       set Content=""
      
       
       //Set stream=##class(%FileBinaryStream).%New()
       set num=1
      //Set stream.Filename=filename
      WHILE 'stream.AtEnd {
	  set line=$zcvt(stream.ReadLine(),"I","UTF8")
	  if line'=""{
	  set rset = tStatement.%Execute(Title,num,line,line)
      
        if (rset.%SQLCODE < 0) {
	           w $system.Status.GetErrorText(##class(%Exception.SQL).CreateFromSQLCODE(rset.%SQLCODE,rset.%Message))
                throw ##class(%Exception.SQL).CreateFromSQLCODE(rset.%SQLCODE,rset.%Message)
        }
	  }
	  set num=num+1
        SET Content=Content_line
  ; Process the chunk here
      }
       set rset = tStatement.%Execute(Title,0,Content,Content)
      
        if (rset.%SQLCODE < 0) {
	          
                throw ##class(%Exception.SQL).CreateFromSQLCODE(rset.%SQLCODE,rset.%Message)
        }
	   // w Content,!
		
    
        
    
	
	
   
   Quit $$$OK
}
ClassMethod Setting() As %Status
{
	zn "%sys"
	Set Application=##Class(Security.Applications).%OpenId("/csp/user")
	set Application.ServeFiles=2
	Set tsc= Application.%Save()
	zn "user"
	Quit tsc
}
Storage Default
{
<Data name="VectorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Title</Value>
</Value>
<Value name="3">
<Value>ParagraphNumber</Value>
</Value>
<Value name="4">
<Value>ParagraphContent</Value>
</Value>
<Value name="5">
<Value>Embedding</Value>
</Value>
</Data>
<DataLocation>^ArticleSimilarity.VectorD</DataLocation>
<DefaultData>VectorDefaultData</DefaultData>
<ExtentSize>113</ExtentSize>
<IdLocation>^ArticleSimilarity.VectorD</IdLocation>
<IndexLocation>^ArticleSimilarity.VectorI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(1,8,16,24,32,40,48,56,64,71,78,85,92,99,106,113),$lb(0,0,0,0,0,1,0,0,0,1,0,0,1,0,1),$lb(822083584,822083584,939524096,939524096,825622528,825622528,842268672,842268672,858914816,858914816,875560960,805306368,939524096,876085248,892731392,892731392,909377536,909377536,925958144,822083584,939524096,926416896,942997504,942997504,959578112,838860800,956301312,960036864,825243136,808845312,825425920,825307904))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="Embedding">
<AverageFieldSize>8516</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="ParagraphContent">
<AverageFieldSize>34.49</AverageFieldSize>
<Histogram>
<![CDATA[$lb(.06666666666666666667,0,0,$lb(" "," "_$c(9,9,9,9,9,9,9,9,9)_"<PART TYPE=""AL"" VALUE=""""/>"," "_$c(9,9,9,9,9,9,9,9)_"<CODE>"," "_$c(9,9,9,9,9,9,9,9)_"<XSL:VARIABLE NAME=""SFZH"" SELECT=""/RESULT/MS_BRDA/SFZH""/>"," "_$c(9,9,9,9,9,9,9)_"</ADMINISTRATIVEGENDERCODE>"," "_$c(9,9,9,9,9,9,9)_"<BIRTHPLACE CLASSCODE="""">"," "_$c(9,9,9,9,9,9,9)_"<XSL:VARIABLE NAME=""BRXB"" SELECT=""TRANSLATE(TRANSLATE($BRXBCODE,'1','?'),'2','?')""/>"," "_$c(9,9,9,9,9,9)_"</EFFECTIVETIME>"," "_$c(9,9,9,9)_"<ITEM ROOT=""2.16.156.10011.2.5.1.3"" EXTENSION=""""/>"," "_$c(9,9,9)_"</ID>"," "_$c(9,9)_"</DEVICE>"," "_$c(9)_"<!-- ????: AL(ALWAYS); ER(ERROR/REJECT ONLY); NE(NEVER) -->"," "_$c(9)_"</RECEIVER>"," "_$c(9)_"<PROCESSINGCODE CODE=""P""/>"," ??"," ??????????????"),$lb(2,21,25,19,23,23,17,13,11,9,7,11,11,1,3),$lb(536870912,0,151587081,574704674,0,0,1296383266,1112294688,1096042838,1162298702,1397965647,1397965647,1095583037,1094863941,1163151693,1129597270,1330920738,1380929364,0,0,1128611328,1447641925,1061109567,975192396,1379794944,1379794944,1313293135,154947666,1061093376,0,1061109567,541015871))]]></Histogram>
<Selectivity>1.0000%</Selectivity>
</Property>
<Property name="ParagraphNumber">
<AverageFieldSize>2.95</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(0,1,4,12,20,28,36,44,52,59,66,73,80,87,94,101),$lb(0,0,0,0,1,0,0,0,1,0,0,0,1,0,0),$lb(805306368,805306368,822083584,822083584,872415232,872415232,825360384,825360384,842006528,805306368,939524096,842530816,859176960,859176960,875823104,875823104,892469248,838860800,956301312,892928000,909508608,909508608,926089216,926089216,942669824,805306368,922746880,943128576,959709184,959709184,825241856,825241856))</Histogram>
<OutlierSelectivity>.053097:0</OutlierSelectivity>
<Selectivity>0.9375%</Selectivity>
</Property>
<Property name="Title">
<AverageFieldSize>18.44</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 历史消息.XSLT"," 文章"," 文章2"),$lb(1,11,11,11,11,11,11,11,11,11,11,11,11,1,3),$lb(536870912,0,3851323109,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3851323109,3868624871,0,838860800,551982727))</Histogram>
<OutlierSelectivity>.893805:"历史消息.xslt"</OutlierSelectivity>
<Selectivity>3.5398%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-908</BlockCount>
</SQLMap>
<StreamLocation>^ArticleSimilarity.VectorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

