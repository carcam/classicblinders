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


<span class="product-image media-middle">
    {if $product.default_image}
        <img src="{$product.default_image.bySize.cart_default.url}" alt="{$product.name|escape:'quotes'}" loading="lazy">
    {elseif $product.cover}
        <img src="{$product.cover.bySize.cart_default.url}" alt="{$product.name|escape:'quotes'}" loading="lazy">
    {else}
        <img src="{$urls.no_picture_image.bySize.cart_default.url}" loading="lazy" />
    {/if}
</span>

<div class="cart__product-name">
    <span class="product-name">
        <a class="label" href="{$product.url}" data-id_customization="{$product.id_customization|intval}">{$product.name}</a>
    </span>
    {foreach from=$product.attributes key="attribute" item="value"}
        <div class="product-attributes">
            <span class="label">{$attribute}:</span>
            <span class="value">{$value}</span>
        </div>
    {/foreach}
    {if is_array($product.customizations) && $product.customizations|count}
        {block name='cart_detailed_product_line_customization'}
            {foreach from=$product.customizations item="customization"}
                <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                <div class="modal fade customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="{l s='Close' d='Shop.Theme.Global'}">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                            </div>
                            <div class="modal-body">
                                {foreach from=$customization.fields item="field"}
                                    <div class="product-customization-line row">
                                        <div class="col-sm-3 col-xs-4 label">
                                            {$field.label}
                                        </div>
                                        <div class="col-sm-9 col-xs-8 value">
                                            {if $field.type == 'text'}
                                                {if (int)$field.id_module}
                                                    {$field.text nofilter}
                                                {else}
                                                    {$field.text}
                                                {/if}
                                            {elseif $field.type == 'image'}
                                                <img src="{$field.image.small.url}" loading="lazy">
                                            {/if}
                                        </div>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
        {/block}
    {/if}

    {block name='hook_cart_extra_product_actions'}
        {hook h='displayCartExtraProductActions' product=$product}
    {/block}
</div>

<div class="cart__product-qty">
    {if isset($product.is_gift) && $product.is_gift}
        <span class="gift-quantity">{$product.quantity}</span>
    {else}
        <input
                class="js-cart-line-product-quantity"
                data-down-url="{$product.down_quantity_url}"
                data-up-url="{$product.up_quantity_url}"
                data-update-url="{$product.update_quantity_url}"
                data-product-id="{$product.id_product}"
                type="number"
                value="{$product.quantity}"
                name="product-quantity-spin"
        />
    {/if}
</div>

<div class="cart__product-price">
    <a
            class                       = "remove-from-cart"
            rel                         = "nofollow"
            href                        = "{$product.remove_from_cart_url}"
            data-link-action            = "delete-from-cart"
            data-id-product             = "{$product.id_product|escape:'javascript'}"
            data-id-product-attribute   = "{$product.id_product_attribute|escape:'javascript'}"
            data-id-customization   	  = "{$product.id_customization|escape:'javascript'}"
    >
        {if !isset($product.is_gift) || !$product.is_gift}
            <i class="fa-regular fa-trash-can"></i>
        {/if}
    </a>
    <span class="product-totalprice">
        {if isset($product.is_gift) && $product.is_gift}
            <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
        {else}
            {$product.total}
        {/if}
    </span>
    <span class="product-price">
        {$product.price}/{l s='unit' d='Shop.Theme.Checkout'}
        {if $product.unit_price_full}
            <div class="unit-price-cart">{$product.unit_price_full}</div>
        {/if}
    </span>
</div>
