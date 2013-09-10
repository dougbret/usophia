{* Invoice - Full view *}
<div class="content-view-full">
  <div class="class-invoice">

    <h1>{$node.data_map.title.content|wash()}</h1>
  </div>  
  <div>
  {attribute_view_gui attribute=$node.data_map.price}
  </div>
  <div>
  Type:{attribute_view_gui attribute=$node.data_map.type}
  </div>
  <div>
  {attribute_view_gui attribute=$node.data_map.description}
  </div>
  <div>
  Items in this invoice:<br>
  {attribute_view_gui attribute=$node.data_map.content_to_buy}
  </div>
  <form method="post" action={"content/action"|ezurl}>
    <input type="submit" class="defaultbutton" name="ActionAddToBasket" value="{'Buy Now'|i18n("design/ezwebin/full/product")}" />
    <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
    <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
    <input type="hidden" name="ViewMode" value="full" />
  </form>
  
  <a target="_blank" href="/layout/set/print{$node.url_alias|ezurl(no)}">Print Invoice</a>
  
</div>  