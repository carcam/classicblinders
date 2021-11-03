/**
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
 */
import $ from 'jquery';
import prestashop from 'prestashop';
import ProductSelect from './components/product-select';

$(document).ready(function () {
  createProductSpin();
  createInputFile();
  coverImage();
  imageScrollBox();

  prestashop.on('updatedProduct', function (event) {
    createInputFile();
    coverImage();
    if (event && event.product_minimal_quantity) {
      const minimalProductQuantity = parseInt(event.product_minimal_quantity, 10);
      const quantityInputSelector = '#quantity_wanted';
      let quantityInput = $(quantityInputSelector);

      // @see http://www.virtuosoft.eu/code/bootstrap-touchspin/ about Bootstrap TouchSpin
      quantityInput.trigger('touchspin.updatesettings', {min: minimalProductQuantity});
    }
    imageScrollBox();
    $($('.tabs .nav-link.active').attr('href')).addClass('active').removeClass('fade');
    $('.js-product-images-modal').replaceWith(event.product_images_modal);

    let productSelect  = new ProductSelect();
    productSelect.init();
  });

  function coverImage() {
    $('.js-thumb').on(
      'click',
      (event) => {
        $('.js-modal-product-cover').attr('src',$(event.target).data('image-large-src'));
        $('.selected').removeClass('selected');
        $(event.target).addClass('selected');
        $('.js-qv-product-cover').prop('src', $(event.currentTarget).data('image-large-src'));
      }
    );
  }

  function imageScrollBox()
  {
    if ($('#main .js-qv-product-images li').length > 2) {
      $('#main .js-qv-mask').addClass('scroll');
      $('.scroll-box-arrows').addClass('scroll');
        $('#main .js-qv-mask').scrollbox({
          direction: 'h',
          distance: 113,
          autoPlay: false
        });
        $('.scroll-box-arrows .left').click(function () {
          $('#main .js-qv-mask').trigger('backward');
        });
        $('.scroll-box-arrows .right').click(function () {
          $('#main .js-qv-mask').trigger('forward');
        });
    } else {
      $('#main .js-qv-mask').removeClass('scroll');
      $('.scroll-box-arrows').removeClass('scroll');
    }
  }

  function createInputFile()
  {
    $('.js-file-input').on('change', (event) => {
      let target, file;

      if ((target = $(event.currentTarget)[0]) && (file = target.files[0])) {
        $(target).prev().text(file.name);
      }
    });
  }

  function createProductSpin()
  {
    const $quantityInput = $('#quantity_wanted');

    $quantityInput.TouchSpin({
      verticalbuttons: true,
      verticalupclass: 'material-icons touchspin-up',
      verticaldownclass: 'material-icons touchspin-down',
      buttondown_class: 'btn btn-touchspin js-touchspin',
      buttonup_class: 'btn btn-touchspin js-touchspin',
      min: parseInt($quantityInput.attr('min'), 10),
      max: 1000000
    });

    $('body').on('change keyup', '#quantity_wanted', (e) => {
      $(e.currentTarget).trigger('touchspin.stopspin');
      prestashop.emit('updateProduct', {
          eventType: 'updatedProductQuantity',
          event: e
      });
    });
  }
});

// Actualizar contenido producto por ajax
$(document).ready(function () {
  prestashop.on(
      'updatedProduct',
      function (event) {
        $('.product-information .price_outstanding .product_prices').html(event.product_prices);
        $('.product-information .price_outstanding .product_variants').html(event.product_variants);

        $('.product_topview .page-content .product_cover_thumbnails').html(event.product_cover_thumbnails);
        $('.product_topview .page-content .product_flags').html(event.product_flags);
      }
  );
});


// Packs productos
$(document).on('click', '.pack_dto', function(e) {
  var qty = $(this).attr('data-qty');

  $('#quantity_wanted').val(qty);

  $( ".pack_dto" ).each(function() {
    $(this).removeClass("checked");
  });
  $(this).addClass("checked");

  // Actualizamos los precios con los descuentos
  prestashop.emit("updateProduct", { eventType: "updatedProductQuantity"});
});

// imagenes productos
if(typeof(show_product_imgs) != "undefined" && show_product_imgs == 1) {
  $(document).ready(function () {
    prestashop.on(
        'updatedProduct',
        function (event) {
          var secondarySlider = new Splide('#splide_images_product_secundary', {
            fixedWidth: 70,
            height: 70,
            gap: 10,
            cover: true,
            isNavigation: true,
            focus: 'left',
            pagination: false,
            arrows: false,
            breakpoints: {
              '991': {
                fixedWidth: 50,
                height: 50,
              }
            },
          }).mount();

          var primarySlider = new Splide('#splide_images_product_miniature', {
            perPage: 1,
            pagination: false,
            arrows: true,
          });

          primarySlider.sync(secondarySlider).mount();
        }
    );
  });
} else if(typeof(show_product_imgs) != "undefined" && show_product_imgs == 2) {
  $(document).ready(function () {
    prestashop.on(
        'updatedProduct',
        function (event) {
          var secondarySlider = new Splide( '#splide_images_product_secundary_lateral', {
            direction: 'ttb',
            height   : '310px',
            perPage     : 4,
            pagination: false,
            arrows: false,
            gap         : 10,
            cover       : true,
            isNavigation: true,
            fixedWidth  : 70,
            breakpoints : {
              '991': {
                fixedWidth: 50,
                height   : '245px',
              }
            },
          } ).mount();

          var primarySlider = new Splide( '#splide_images_product_miniature_lateral', {
            perPage     : 1,
            pagination: false,
            arrows: true,
          } ).mount();

          primarySlider.sync( secondarySlider ).mount();

          new Splide( '#splide_images_product', {
            perPage     : 1,
            pagination: false,
            arrows: true,
          } ).mount();
        }
    );
  });
} else {
  $(document).ready(function () {
    prestashop.on(
        'updatedProduct',
        function (event) {
          new Splide('#splide_images_product', {
            perPage: 1,
            pagination: false,
            lazyLoad: 'sequential',
            arrows: true,
          }).mount();
        }
    );
  });
}
