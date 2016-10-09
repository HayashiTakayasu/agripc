$(function(){

  // 検索、メニュー
  $('#searchToggle, #menuToggle').click(function(){
    $(this).parent().toggleClass('open');
    if($(this).attr('id') == 'searchToggle'){
      $('#menuToggle').parent().removeClass('open');
    } else {
      $('#searchToggle').parent().removeClass('open');
    }
    $('body').addClass('removeHighlight');
  });
  $('body').click(function(e){
    if( !$(e.target).parents().hasClass('open') ){
      $('.search, .menu').removeClass('open');
      $('body').removeClass('removeHighlight');
    }
  });

  // タブ
  $('#pickup').find('.tab a').click(function(){
    $(this).parent().addClass('current').siblings('.current').removeClass('current');
    var tabTarget = $(this).attr('href');
    $( tabTarget ).addClass('current').siblings('.current').removeClass('current');
    return false;
  });

  // アコーディオン
  $('.toggle').find('h2').click(function(){
    if (b.hasClass('lt768')) { 
      $(this).siblings('dl ').slideToggle('fast', function(){
        $(this).parent().toggleClass('close');
      });
    }
  });

  $('.flexslider').flexslider({
    animation: 'slide'
  });

  var b = $('#body');
  var breakPoint = 768;
 
  function slideChange(than, range ){ 
    var slide = $('.slides li'); 
    b.attr('class', than + range); 
    slide.find('img').each(function() { 
      this.src = this.src.replace(/(lt|gte)_[0-9]{3}\.jpg/, than + '_' + range + '.jpg'); 
    });
  }

  $(window).on('load resize', function(){ 
    if (b.width() >= breakPoint && !b.hasClass('gte768') ) { // 付与したクラスの有無を確認して、重複処理を防ぐ。
      slideChange('gte', '768'); 
    } else if (b.width() < breakPoint && !b.hasClass('lt768') ) {
      slideChange('lt', '768'); 
    }
  });

});

$(window).load(function(){
  setTimeout(function(){
    window.scrollTo(0, 1);
  }, 300);
});
