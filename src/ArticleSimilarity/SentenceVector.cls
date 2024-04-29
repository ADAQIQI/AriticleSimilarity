Class ArticleSimilarity.SentenceVector Extends %Persistent
{

Property Title As %String(MAXLEN = 200);

Property ParagraphNumber As %Integer;

// 段落序号 0的时候为整篇文章

Property sentence As %String(MAXLEN = "");

// 段落内容

Property Embedding As %Library.Vector(DATATYPE = "double", LEN = 768);

Storage Default
{
<Data name="SentenceVectorDefaultData">
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
<Value>sentence</Value>
</Value>
<Value name="5">
<Value>Embedding</Value>
</Value>
</Data>
<DataLocation>^ArticleSimi38B4.SentenceVectorD</DataLocation>
<DefaultData>SentenceVectorDefaultData</DefaultData>
<ExtentSize>43</ExtentSize>
<IdLocation>^ArticleSimi38B4.SentenceVectorD</IdLocation>
<IndexLocation>^ArticleSimi38B4.SentenceVectorI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,16,$lb("-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000","-10000000000000000000"),$lb(21,21,21,21,21,21,21,21,21,21,21,21,21,21,21),$lb(758198320,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,758198320))</Histogram>
<OutlierSelectivity>.999999:</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(1,3,6,9,12,15,18,21,24,27,30,33,36,39,41,43),$lb(0,0,0,0,1,1,0,1,1,0,1,1,1,0,1),$lb(822083584,822083584,855638016,855638016,905969664,905969664,956301312,956301312,825360384,838860800,889192448,889192448,939524096,825753600,842072064,822083584,872415232,872415232,922746880,842465280,858783744,805306368,855638016,855638016,905969664,905969664,956301312,859373568,875626496,822083584,855638016,875757568))</Histogram>
<Selectivity>1</Selectivity>
</Property>
<Property name="Embedding">
<AverageFieldSize>8516</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="ParagraphNumber">
<AverageFieldSize>2.58</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,1,0,$lb(0,0,0,0,0,0,0,1,2,3,3,4,4,4,4,4),$lb(1,1,1,1,1,1,0,0,0,1,0,1,1,1,1),$lb(805306368,0,0,0,0,0,0,0,0,0,0,0,0,805306368,822083584,822083584,838860800,838860800,855638016,0,0,855638016,872415232,0,0,0,0,0,0,0,0,872415232))</Histogram>
<Selectivity>20.0000%</Selectivity>
</Property>
<Property name="Title">
<AverageFieldSize>9</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"," TTITLE1"),$lb(9,9,9,9,9,9,9,9,9,9,9,9,9,9,9),$lb(542397513,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,542397513))</Histogram>
<OutlierSelectivity>.999999:"TTITLE1"</OutlierSelectivity>
<Selectivity>0.0001%</Selectivity>
</Property>
<Property name="sentence">
<AverageFieldSize>34.51</AverageFieldSize>
<Histogram>$lb(.06666666666666666667,0,0,$lb(" "," "," ","  ENSURE THAT INFORMATION DENOTED BY THE COLOR IS EITHER OBVIOUS FROM THE CONTENT ITSELF (E","  OR IS INCLUDED THROUGH ALTERNATIVE MEANS","  RATHER THAN THE","  SUCH AS SCREEN READERS","  THE STYLING TO SET THE VISUAL WIDTH OF THE PROGRESS BAR MUST BE APPLIED TO THE","  WHICH WILL NOT BE CONVEYED TO USERS OF ASSISTIVE TECHNOLOGIES"," CONVEYING MEANING TO ASSISTIVE TECHNOLOGIES"," G"," PROGRESS ELEMENTS"," PROGRESS-BARS"," USING COLOR TO ADD MEANING ONLY PROVIDES A VISUAL INDICATION"," VISUALLY-HIDDEN CLASS"," YOU CAN INCLUDE MULTIPLE PROGRESS COMPONENTS INSIDE A CONTAINER WITH"),$lb(2,2,1,2,2,2,2,2,1,1,1,9,1,1,1),$lb(536870912,0,0,0,0,0,541412947,1162761045,1330782281,1330782281,1380013128,1380013128,1398096712,1398096712,1414022432,1414022432,1464355139,542591049,1129270870,1129270870,1191182336,1191182336,1347571527,541412421,759316818,1347571527,1431521614,1431521614,1447646037,1447646037,1498371360,542723925))</Histogram>
<Selectivity>4.3478%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-348</BlockCount>
</SQLMap>
<StreamLocation>^ArticleSimi38B4.SentenceVectorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

