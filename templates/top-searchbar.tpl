        <div class="search">
            <form name="searchForm" action="{$smarty.server.PHP_SELF}" method="post">
                {if $config->search_collection_list->collection|@count > 1}
                  <div class="informationTypes">
                    {foreach from=$config->search_collection_list->collection item=collection name=colIterator}
                        {assign var=colName value=$collection->name}
                        {assign var=colSite value=$collection->site}

                        {if $colSite eq ''}
                            {assign var=colSite value=$config->site}
                            {assign var=colId value=$colName|upper}
                        {else}
                            {assign var=colId value="`$colName`-`$colSite`"|upper}
                        {/if}

                        {if ($col == $colName && $site == $colSite) }
                            {assign var=selectColPos value=$smarty.foreach.colIterator.index}

                            <a href="#" onclick="changeCollection('{$colName}','{$colSite}')" class="selected">{$texts.COLLECTIONS.$colId}</a>
                        {else}
                            <a href="#" onclick="changeCollection('{$colName}','{$colSite}')">{$texts.COLLECTIONS.$colId}</a>
                        {/if}
                    {/foreach}
                  </div>
                {/if}

                <div class="searchForm">
                        <input type="hidden" name="lang" value="{$lang}"/>
                        <input type="hidden" name="col" value="{$col}"/>
                        <input type="hidden" name="site" value="{$site}"/>
                        <input type="hidden" name="count" value="{$config->documents_per_page}"/>
                        <input type="hidden" name="filter" value="{$filter|replace:"\\\"":"&quot;"}"/>
                        <input type="hidden" name="filterLabel" value="{$filterLabel}"/>
                        <input type="hidden" name="qt" value="standard"/>
                        <input type="hidden" name="fmt" value="{$fmt}"/>
                        <input type="hidden" name="sort" value="{$smarty.request.sort}"/>

                        <!-- fields used by javascript functions -->
                        <input type="hidden" name="pageFrom" value="{$from}"/>
                        <input type="hidden" name="from" value=""/>
                        <input type="hidden" name="addfilter" value=""/>
                        <input type="hidden" name="backfilter" value=""/>
                        <input type="hidden" name="printMode" value=""/>
                        <input type="hidden" name="output" value=""/>
                        <input type="hidden" name="fb" value=""/>


                        {if isset($smarty.request.debug)}
                            <input type="hidden" name="debug" value="1"/>
                        {/if}

                        {foreach from=$filter_chain item=filterValue}
                            {assign var=fvalue value=$filterValue|replace:"\\\"":"&quot;"}
                            <input type="hidden" name="filter_chain[]" value="{$fvalue}">
                        {/foreach}
                        <!--span>{$texts.SEARCH_WORDS}</span-->

                        <label for='textEntry1' class='hide'>Busca</label>

                        <input type="text" name="q" value="{if $q_escaped eq ''}{$texts.ENTER_WORDS}{else}{$q_escaped}{/if}" class="inputText defaultValue" onKeyDown="if(event.keyCode==13) newSearch();" onblur="clearDefault('textEntry1', 'inputText defaultValue'); this.value= (this.value=='')? 'Entre uma ou mais palavras' : this.value" onfocus="clearDefault('textEntry1', 'inputText'); this.value= (this.value=='Entre uma ou mais palavras')? '' : this.value"  id="textEntry1"/>

                        <label for='selectIndex' class='hide'>Índice</label>
                        <select name="index" class="inputText" id="selectIndex">
                            {foreach from=$colectionData->index_list->index item=availableIndex}
                                {assign var=indexKey value=$availableIndex->name|upper}
                                {assign var=indexPrefix value=$availableIndex->prefix}

                                {if $indexKey neq ''}
                                    {if $indexPrefix == $index}
                                        <option value="{$indexPrefix}" selected="1">{$texts.INDEXES.$indexKey}</option>
                                    {else}
                                        <option value="{$indexPrefix}">{$texts.INDEXES.$indexKey}</option>
                                    {/if}
                                {/if}
                            {/foreach}
                        </select>

                        {if $colectionData->where_list->where|@count > 0}
                            {$texts.WHERE_FILTER}:
                            <label for='selectWhere' class='hide'>Onde</label>
                            <select name="where" class="inputText" id='selectWhere'>
                                {foreach from=$colectionData->where_list->where item=where}
                                    {strip}
                                    {assign var=whereName value=$where->name|upper}
                                    {assign var=whereFilter value=$where->filter}
                                    {assign var=whereLevel value=$where->level}

                                    {if $texts.WHERE.$whereName neq ''}
                                        {assign var=whereLabel value=$texts.WHERE.$whereName}
                                    {else}
                                        {assign var=whereLabel value=$whereName}
                                    {/if}

                                    {if $whereLevel neq ''}
                                        {assign var=ident value='&nbsp;&nbsp;&nbsp;&nbsp;'}
                                    {else}
                                        {assign var=ident value=''}
                                    {/if}

                                    {if $whereName neq ''}
                                        {if $whereName eq $smarty.request.where}
                                            <option value="{$whereName}" selected="1">{$ident}{$whereLabel}</option>
                                        {else}
                                            <option value="{$whereName}">{$ident}{$whereLabel}</option>
                                        {/if}
                                    {/if}
                                    {/strip}
                                {/foreach}
                            </select>
                        {/if}
                        <input type="button" name="go" value="{$texts.SEARCH_SUBMIT}" class="submit" onclick="javascript:newSearch()" onkeypress="javascript:newSearch()" />
                        &#160;
                        <a href="advanced.php?lang={$lang}">{$texts.SEARCH_ADVANCED}</a>
                </div>

                <div id="bookmark_button">
                    <!--img src="./image/common/star_selected.gif" onclick="showBookmarks()";/-->
                </div>
            </form>
        </div>
