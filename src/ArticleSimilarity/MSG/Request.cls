Class ArticleSimilarity.MSG.Request Extends Ens.Request
{

Property Method As %String;

Property Title1Name As %String;

Property Title1Content As %String(MAXLEN = "");

Property Title2Name As %String;

Property Title2Content As %String(MAXLEN = "");

Storage Default
{
<Data name="RequestDefaultData">
<Subscript>"Request"</Subscript>
<Value name="1">
<Value>TitleName</Value>
</Value>
<Value name="2">
<Value>TitleContent</Value>
</Value>
<Value name="3">
<Value>Title1Name</Value>
</Value>
<Value name="4">
<Value>Title1Content</Value>
</Value>
<Value name="5">
<Value>Title2Name</Value>
</Value>
<Value name="6">
<Value>Title2Content</Value>
</Value>
<Value name="7">
<Value>Mehod</Value>
</Value>
<Value name="8">
<Value>Method</Value>
</Value>
</Data>
<DefaultData>RequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}

