/// 
Class ArticleSimilarity.BussinessProcess Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='800' >
<switch name='方法判断' xpos='200' ypos='250' xend='200' yend='700' >
<case condition='(request.Method="getParamSimilarity")||(request.Method="getSenSimilarity")' name='request.Method="getParamSimi"' >
<call name='getpSim' target='ArticleSimilarity.GetSimilarityBussinessOperation' async='0' xpos='200' ypos='400' >
<request type='ArticleSimilarity.MSG.Request' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Ens.StringResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</case>
<default>
<call name='upload' target='ArticleSimilarity.GetArticleBussinessOperation' async='0' xpos='470' ypos='400' >
<request type='ArticleSimilarity.MSG.Request' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Ens.StringContainer' />
</call>
<call name='getSim' target='ArticleSimilarity.GetSimilarityBussinessOperation' async='0' xpos='470' ypos='500' >
<request type='ArticleSimilarity.MSG.Request' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Ens.StringResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
<call name='getsensim' target='ArticleSimilarity.GetArticlesentenceBussinessOperation' async='1' xpos='470' ypos='600' >
<request type='ArticleSimilarity.MSG.Request' >
<assign property="callrequest" value="request" action="set" languageOverride="" />
</request>
<response type='Ens.StringResponse' >
<assign property="response" value="callresponse" action="set" languageOverride="" />
</response>
</call>
</default>
</switch>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}

