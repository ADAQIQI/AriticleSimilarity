Class ArticleSimilarity.Production Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="ArticleSimilarity.Production" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="ArticleSimilarity.GetArticleBussinessOperation" Category="" ClassName="ArticleSimilarity.GetArticleBussinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ArticleSimilarity.GetArticleBussinessService" Category="" ClassName="ArticleSimilarity.GetArticleBussinessService" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ArticleSimilarity.GetSimilarityBussinessOperation" Category="" ClassName="ArticleSimilarity.GetSimilarityBussinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ArticleSimilarity.BussinessProcess" Category="" ClassName="ArticleSimilarity.BussinessProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="ArticleSimilarity.GetArticlesentenceBussinessOperation" Category="" ClassName="ArticleSimilarity.GetArticlesentenceBussinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}

