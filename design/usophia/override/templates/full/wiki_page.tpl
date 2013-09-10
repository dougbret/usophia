{* Article - Full view *}

    <div class="content-view-full">
        <div class="class-wiki_page">

          <h1>{$node.name|wash()}</h1>

        <div class="attribute-byline">
        <p class="author">
             {$node.object.owner.name}
        </p>

        <p class="date">
             {$node.object.published|l10n(shortdatetime)}
        </p>
        </div>

        <div class="attribute-long">
            {attribute_view_gui attribute=$node.data_map.text}
        </div>
          
          <a href="#" class="more-link">Back to top&gt;&gt;</a><a href="/" class="more-link" onclick="history.go(-1); return false;">&lt;&lt;Back</a><a href="/" class="more-link-top" onclick="history.go(-1); return false;">&lt;&lt;Back</a>        

        </div>
    </div>
