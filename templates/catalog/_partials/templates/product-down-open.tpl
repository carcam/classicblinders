{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

<div class="product-information">
    <p class="title_info_product">{l s='Información del producto' d='Shop.Theme.Catalog'}</p>
    <div class="card card_product_info">
        {block name='product_tabs'}
            {if $product.description}
                <div id="description" class="info_content">
                    {block name='product_description'}
                        <div class="product-description">{$product.description nofilter}</div>
                    {/block}

                    {block name='product_reference'}
                        {if isset($product.reference_to_display) && $product.reference_to_display neq ''}
                            <div class="product-reference">
                                <label class="label">{l s='Reference' d='Shop.Theme.Catalog'} </label>
                                <span itemprop="sku">{$product.reference_to_display}</span>
                            </div>
                        {/if}
                    {/block}
                    {block name='product_quantities'}
                        {if $product.show_quantities}
                            <div class="product-quantities">
                                <label class="label">{l s='In stock' d='Shop.Theme.Catalog'}</label>
                                <span data-stock="{$product.quantity}" data-allow-oosp="{$product.allow_oosp}">{$product.quantity} {$product.quantity_label}</span>
                            </div>
                        {/if}
                    {/block}
                </div>
            {/if}

            <div id="product-details-info">
                <span class="btn btn-link">
                    {l s='Información adicional' d='Shop.Theme.Catalog'}
                </span>
            </div>
            <div id="product-details" class="info_content">
                {block name='product_details'}
                    {include file='catalog/_partials/product-details.tpl'}
                {/block}
            </div>

            {foreach from=$product.extraContent item=extra key=extraKey}
                <div class="card">
                    <div id="extra-info-{$extraKey}">
                        <span class="product-info_title">{$extra.title}</span>
                    </div>
                    <div id="extra-{$extraKey}" class="info_content">
                        {$extra.content nofilter}
                    </div>
                </div>
            {/foreach}

        {/block}
    </div>

</div>
