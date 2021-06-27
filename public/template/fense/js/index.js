//默认数据
$(function(){
    //图片懒加载
    $("img.lazy").lazyload({
        effect : "fadeIn",
    　　threshold : 10
    });
    $('.update-nav').click(function(){
        var index = $(this).index();
        $('.update-nav').removeClass('active');
        $('.update-nav i').remove();
        $('.update-nav').eq(index).addClass('active').prepend('<i class="icon-active-rabbit active-rank"></i>');
        $('.comic-sort-list').addClass('acgn-hide');
        $('.comic-sort-list').eq(index).removeClass('acgn-hide');
    });
    //热门标签切换
    $('.tags-nav').mouseover(function(){
        var index = $(this).index();
        $('.tags-nav').removeClass('active');
        $('.tags-nav').eq(index).addClass('active');
        $('.tags-list').removeClass('active');
        $('.tags-list').eq(index).addClass('active');
        $('.tags-list img.lazy').lazyload();
    });
    $('.hot-list li').hover(function(){
        $(this).find('.floater').show();
    }, function() {
        $(this).find('.floater').hide();
    });
    //排行榜切换
    $('.hot-nav').click(function(){
        var index = $(this).index();
        $('.hot-nav').removeClass('active');
        $('.hot-nav').eq(index).addClass('active');
        $('.hot-list').removeClass('checked');
        $('.hot-list').eq(index).addClass('checked');
    });
    $('.tabs-underline .tab').mouseover(function(){
        var type = $(this).data('type');
        $(".area .block-container,.tabs-underline .tab").removeClass('active');
        $(".area ."+type).addClass('active');
        $(this).addClass('active');
    });
    $('.rank-row').mouseover(function(){
        $(this).parent().children('.rank-row').removeClass('hover');
        $(this).addClass('hover');
    });
});