{set-block scope=global variable=cache_ttl}0{/set-block}
{def $event_node_id = 2}
{if is_set($view_parameters['art_center_node'])}
  {set $event_node_id = $view_parameters['art_center_node']}
{/if}
{* Event Calendar - Full Calendar view *}
{def $event_node    = $node
    

    $curr_ts = currentdate()
    $curr_today = $curr_ts|datetime( custom, '%j')
    $curr_year = $curr_ts|datetime( custom, '%Y')
    $curr_month = $curr_ts|datetime( custom, '%n')

    $temp_ts = cond( and(ne($view_parameters.month, ''), ne($view_parameters.year, '')), makedate($view_parameters.month, cond(ne($view_parameters.day, ''),$view_parameters.day, eq($curr_month, $view_parameters.month), $curr_today, 1 ), $view_parameters.year), currentdate() )

    $temp_month = $temp_ts|datetime( custom, '%n')
    $temp_year = $temp_ts|datetime( custom, '%Y')
    $temp_today = $temp_ts|datetime( custom, '%j')

    $days = $temp_ts|datetime( custom, '%t')

    $first_ts = makedate($temp_month, 1, $temp_year)
    $dayone = $first_ts|datetime( custom, '%w' )

    $last_ts = makedate($temp_month, $days, $temp_year)
    $daylast = $last_ts|datetime( custom, '%w' )

    $span1 = $dayone
    $span2 = sub( 7, $daylast )

    $dayofweek = 0

    $day_array = " "
    $loop_dayone = 1
    $loop_daylast = 1
    $day_events = array()
    $loop_count = 0
    }

{if ne($temp_month, 12)}
    {set $last_ts=makedate($temp_month|sum( 1 ), 1, $temp_year)}
{else}
    {set $last_ts=makedate(1, 1, $temp_year|sum(1))}
{/if}
{*  Getting the events for this month based on the view parameters *}
{def $events=fetch( 'content', 'tree', hash(
            'parent_node_id', $event_node_id,
            'sort_by', array( 'attribute', true(), 'event/from_time'),
            'class_filter_type',  'include',
            'class_filter_array', array( 'event' ),
            'main_node_only', true(),
             'attribute_filter',
            array( 'or',
                    array( 'event/from_time', 'between', array( sum($first_ts,1), sub($last_ts,1)  )),
                    array( 'event/to_time', 'between', array( sum($first_ts,1), sub($last_ts,1) )) )
                ))

    $url_reload=concat( $event_node.url_alias, "/(day)/", $temp_today, "/(month)/", $temp_month, "/(year)/", $temp_year, "/offset/2")
    $url_back=concat( $event_node.url_alias,  "/(month)/", sub($temp_month, 1), "/(year)/", $temp_year)
    $url_forward=concat( $event_node.url_alias, "/(month)/", sum($temp_month, 1), "/(year)/", $temp_year)
}

{if eq($temp_month, 1)}
    {set $url_back=concat( $event_node.url_alias,"/(month)/", "12", "/(year)/", sub($temp_year, 1))}
{elseif eq($temp_month, 12)}
    {set $url_forward=concat( $event_node.url_alias,"/(month)/", "1", "/(year)/", sum($temp_year, 1))}
{/if}

{foreach $events as $event}
    {if eq($temp_month|int(), $event.data_map.from_time.content.month|int())}
        {set $loop_dayone = $event.data_map.from_time.content.day}
    {else}
        {set $loop_dayone = 1}
    {/if}
    {if $event.data_map.to_time.content.is_valid}
       {if eq($temp_month|int(), $event.data_map.to_time.content.month|int())}
            {set $loop_daylast = $event.data_map.to_time.content.day}
        {else}
            {set $loop_daylast = $days}
        {/if}
    {else}
         {set $loop_daylast = $loop_dayone}
    {/if}
    {for $loop_dayone|int() to $loop_daylast|int() as $counter}
        {set $day_array = concat($day_array, $counter, ', ')}
        {if eq($counter,$temp_today)}
            {set $day_events = $day_events|append($event)}
        {/if}
    {/for}
{/foreach}


<div class="content-view-full">
 <div class="class-event-calendar event-calendar-calendarview">
{if or(is_set($view_parameters['art_center_node']),is_set($view_parameters['event_node_id']))}
   <h1>Art Center Events</h1>
{else}  
    <h1>{$event_node.name|wash()}</h1>
{/if}

<div id="ezagenda_calendar_left">


<div id="ezagenda_calendar_today">
    {if eq($curr_ts|datetime( custom, '%j'),$temp_ts|datetime( custom, '%j'))} 
        <h2>{"Today"|i18n("design/ezwebin/full/event_view_calendar")}:</h2> 
    {else} 
        <h2>{$temp_ts|datetime( custom, '%l %j')|upfirst()}:</h2> 
    {/if} 
{foreach $day_events as $day_event}
    
    <div class="ezagenda_day_event{if gt($curr_ts , $day_event.object.data_map.to_time.content.timestamp)} ezagenda_event_old{/if}">
    <h4><a href={$day_event.url_alias|ezurl}>{$day_event.name|wash}</a></h4>
    <p>
    {*if $day_event.object.data_map.category.has_content}
    <span class="ezagenda_keyword">
    {"Category"|i18n("design/ezwebin/full/event_view_calendar")}:
    {attribute_view_gui attribute=$day_event.object.data_map.category}
    </span>
    {/if*}

    <span class="ezagenda_date">
    {*$day_event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M %H:%i")} 
    {if $day_event.object.data_map.to_time.has_content}
        - {$day_event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M %H:%i")}
    {/if*}
    </span>
    <span class="ezagenda_date">
    <span id='from-day-date-{$day_event.data_map.from_time.content.timestamp}'></span>&nbsp; 
    <span id='from-day-hours-{$day_event.data_map.from_time.content.timestamp}'></span>&nbsp; 
    {if $day_event.object.data_map.to_time.has_content}
     - <span id='to-day-date-{$day_event.data_map.to_time.content.timestamp}'></span>&nbsp; 
    <span id='to-day-hours-{$day_event.data_map.to_time.content.timestamp}'></span>&nbsp;
    {/if}
    </span>
    {literal}
    <script type='text/javascript'>
      var fromdate = new Date({/literal}{$day_event.data_map.from_time.content.timestamp}{literal} * 1000 );
      var todate = new Date({/literal}{$day_event.data_map.to_time.content.timestamp}{literal} * 1000 );
      x = new Date()
      currentTimeZoneOffsetInHours = x.getTimezoneOffset()/60; 
      var year 	= fromdate.getUTCFullYear();
      var month 	= fromdate.getMonth() ; // getMonth() is zero-indexed, so we'll increment to get the correct month number
      var day		= fromdate.getDate();
      var hours 	= fromdate.getHours();
      var minutes = fromdate.getMinutes();
      var seconds = fromdate.getSeconds();
      
      var toyear 	= todate.getUTCFullYear();
      var tomonth 	= todate.getMonth() ; // getMonth() is zero-indexed, so we'll increment to get the correct month number
      var today		= todate.getDate();
      var tohours 	= todate.getHours();
      var tominutes = todate.getMinutes();
      var toseconds = todate.getSeconds();
      var montharray=new Array();
          montharray[0]="January";
          montharray[1]="February";
          montharray[2]="March";
          montharray[3]="April";
          montharray[4]="May";
          montharray[5]="June";
          montharray[6]="July";
          montharray[7]="August";
          montharray[8]="September";
          montharray[9]="October";
          montharray[10]="November";
          montharray[11]="December";
      
     
     // month	= (month < 10) ? '0' + month : month;
      day		= (day < 10) ? '0' + day : day;
      hours	= (hours < 10) ? '0' + hours : hours;
      minutes = (minutes < 10) ? '0' + minutes : minutes;
      seconds	= (seconds < 10) ? '0' + seconds: seconds;
      
      //tomonth	= (tomonth < 10) ? '0' + tomonth : tomonth;
      today		= (today < 10) ? '0' + today : today;
      tohours	= (tohours < 10) ? '0' + tohours : tohours;
      tominutes = (tominutes < 10) ? '0' + tominutes : tominutes;
      toseconds	= (toseconds < 10) ? '0' + toseconds: toseconds;
      
      
      
      
        jQuery("#from-day-hours-{/literal}{$day_event.data_map.from_time.content.timestamp}{literal}").html(hours + ":" + minutes);
        jQuery("#from-day-date-{/literal}{$day_event.data_map.from_time.content.timestamp}{literal}").html(montharray[month] + ' ' + day);
        jQuery("#to-day-hours-{/literal}{$day_event.data_map.to_time.content.timestamp}{literal}").html(tohours + ":" + tominutes);
        jQuery("#to-day-date-{/literal}{$day_event.data_map.to_time.content.timestamp}{literal}").html(montharray[tomonth] + ' ' + today);
      </script> 
    {/literal}
    
    
    </p>    
    </div>
{/foreach}
</div>
</div>


<div id="ezagenda_calendar_right">
<h2>{$temp_ts|datetime( custom, '%F %Y' )|upfirst()}:</h2> 
{foreach $events as $event}
    {if and( ne($view_parameters.offset, 2), eq($loop_count, 8))}
        <a id="ezagenda_month_hidden_show" href={$url_reload|ezurl} onclick="document.getElementById('ezagenda_month_hidden').style.display='';this.style.display='none';return false;">{"Show All Events.."|i18n("design/ezwebin/full/event_view_calendar")}</a>
        <div id="ezagenda_month_hidden" style="display:none;">
    {/if}
    
    <table class="ezagenda_month_event" cellpadding="0" cellspacing="0"{if gt($curr_ts , $event.object.data_map.to_time.content.timestamp)} class="ezagenda_event_old"{/if} summary="Previw of event">
    <tr>
    <td class="ezagenda_month_label">
        <h2>
        <span class="ezagenda_month_label_date">{$event.object.data_map.from_time.content.timestamp|datetime(custom,"%j")}</span>
        {$event.object.data_map.from_time.content.timestamp|datetime(custom,"%M")|extract_left( 3 )}
        </h2>
    </td>
    <td class="ezagenda_month_info">

    <h4><a href={$event.url_alias|ezurl}>{$event.name|wash}</a></h4>

    <p>
    {*<span class="ezagenda_date">
    {$event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
    {if and($event.object.data_map.to_time.has_content,  ne( $event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M"), $event.object.data_map.from_time.content.timestamp|datetime(custom,"%j %M") ))}
        - {$event.object.data_map.to_time.content.timestamp|datetime(custom,"%j %M")|shorten( 6 , '')}
    {/if}
    </span>*}
    <span class="ezagenda_date">
    <span id='from-day-date-{$event.data_map.from_time.content.timestamp}'></span>&nbsp; 
    <span id='from-day-hours-{$event.data_map.from_time.content.timestamp}'></span>&nbsp; 
    {if $event.object.data_map.to_time.has_content}
     - <span id='to-day-date-{$event.data_map.to_time.content.timestamp}'></span>&nbsp; 
    <span id='to-day-hours-{$event.data_map.to_time.content.timestamp}'></span>&nbsp;
    {/if}
    </span>
    {literal}
    <script type='text/javascript'>
      var fromdate = new Date({/literal}{$event.data_map.from_time.content.timestamp}{literal} * 1000 );
      var todate = new Date({/literal}{$event.data_map.to_time.content.timestamp}{literal} * 1000 );
      x = new Date()
      currentTimeZoneOffsetInHours = x.getTimezoneOffset()/60; 
      var year 	= fromdate.getUTCFullYear();
      var month 	= fromdate.getMonth() ; // getMonth() is zero-indexed, so we'll increment to get the correct month number
      var day		= fromdate.getDate();
      var hours 	= fromdate.getHours();
      var minutes = fromdate.getMinutes();
      var seconds = fromdate.getSeconds();
      
      var toyear 	= todate.getUTCFullYear();
      var tomonth 	= todate.getMonth() ; // getMonth() is zero-indexed, so we'll increment to get the correct month number
      var today		= todate.getDate();
      var tohours 	= todate.getHours();
      var tominutes = todate.getMinutes();
      var toseconds = todate.getSeconds();
      var montharray=new Array();
          montharray[0]="January";
          montharray[1]="February";
          montharray[2]="March";
          montharray[3]="April";
          montharray[4]="May";
          montharray[5]="June";
          montharray[6]="July";
          montharray[7]="August";
          montharray[8]="September";
          montharray[9]="October";
          montharray[10]="November";
          montharray[11]="December";
      
     
     // month	= (month < 10) ? '0' + month : month;
      day		= (day < 10) ? '0' + day : day;
      hours	= (hours < 10) ? '0' + hours : hours;
      minutes = (minutes < 10) ? '0' + minutes : minutes;
      seconds	= (seconds < 10) ? '0' + seconds: seconds;
      

      
      
      
        jQuery("#from-day-hours-{/literal}{$event.data_map.from_time.content.timestamp}{literal}").html(hours + ":" + minutes);
        jQuery("#from-day-date-{/literal}{$event.data_map.from_time.content.timestamp}{literal}").html(montharray[month] + ' ' + day);
        jQuery("#to-day-hours-{/literal}{$event.data_map.to_time.content.timestamp}{literal}").html(tohours + ":" + tominutes);
        jQuery("#to-day-date-{/literal}{$event.data_map.to_time.content.timestamp}{literal}").html(montharray[tomonth] + ' ' + today);
      </script> 
    {/literal}

    
    {*if $event.object.data_map.category.has_content}
    <span class="ezagenda_keyword">
    {attribute_view_gui attribute=$event.object.data_map.category}
    </span>
    {/if*}
    </p>
    
    {if $event.object.data_map.text.has_content}
        <div class="attribute-short">{$node.data_map.text.content.output.output_text|strip_tags|shorten(150)}</div>
    {/if}

    </td>
    </tr>
    </table>
    {set $loop_count = inc($loop_count)}
{/foreach}
{if and(  ne($view_parameters.offset, 2) , gt($loop_count, 8))}
    </div>
{/if}
</div>

{undef}
</div>
</div>
