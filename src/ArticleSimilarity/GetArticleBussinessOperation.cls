Class ArticleSimilarity.GetArticleBussinessOperation Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Parameter SETTINGS;

Method OnMessage(request As ArticleSimilarity.MSG.Request, Output response As Ens.StringContainer) As %Status
{
	   
       #dim sc As %Status = $$$OK
       SET file=##class(%FileBinaryStream).%New()
       //set file.
       set file.Filename=request.Title1Name
       
       Do file.Write($ZCVT(request.Title1Content,"O","UTF8"))
       Do ..InsertEmbeddings(request.Title1Name,file)
       
       SET file2=##class(%FileBinaryStream).%New()
       set file2.Filename=request.Title2Name
       
       Do file2.Write($ZCVT(request.Title2Content,"O","UTF8"))
       Do ..InsertEmbeddings(request.Title2Name,file2)
        
       return sc
}

// 获取到txt文本内容后存储到指定文件夹

// 逐段存入数据库

ClassMethod InsertEmbeddings(Title, stream As %FileBinaryStream)
{
	    set myquery="Insert into ArticleSimilarity.Vector(Title,ParagraphNumber,ParagraphContent,Embedding) Values(?,?,?, TO_VECTOR(ArticleSimilarity.Vector_GetEmbeddingPy(?),double))"
		//set ^b2=myquery
        set sc=$$$OK
        set tStatement = ##class(%SQL.Statement).%New()
        $$$ThrowOnError(tStatement.%Prepare(myquery))
	
       set Content=""
      

       set num=1

      WHILE 'stream.AtEnd {
	  set line=$ZCVT(stream.ReadLine(),"I","UTF8")
	  if line'=""{
	  set rset = tStatement.%Execute(Title,num,line,line)
     
        if (rset.%SQLCODE < 0) {
	           throw ##class(%Exception.SQL).CreateFromSQLCODE(rset.%SQLCODE,rset.%Message)
        }
	  }
	  set num=num+1
        SET Content=Content_line
  ; Process the chunk here
      }
       set rset = tStatement.%Execute(Title,0,Content,Content)
        w rset.%SQLCODE,!
        if (rset.%SQLCODE < 0) {
	           w $system.Status.GetErrorText(##class(%Exception.SQL).CreateFromSQLCODE(rset.%SQLCODE,rset.%Message))
                throw ##class(%Exception.SQL).CreateFromSQLCODE(rset.%SQLCODE,rset.%Message)
        }
   Quit $$$OK
}

}

