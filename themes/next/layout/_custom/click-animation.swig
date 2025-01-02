{% if theme.click_animation.enable %}
  <script type="text/javascript">
    function isPC() {
      var userAgentInfo = navigator.userAgent;
      var agents = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"];
      for (var i = 0; i < agents.length; i++) {
        if (userAgentInfo.indexOf(agents[i]) > 0) {
          return false;
        }
      }
      return true;
    }
    var showOnMobile = {{ theme.click_animation.mobile }};
    var openOnPC = isPC();

    {% if theme.click_animation.style == "love" %}
      if (openOnPC || showOnMobile) $.getScript("/js/src/love.js");
    {% elseif theme.click_animation.style == "fireworks" %}
      if (openOnPC || showOnMobile) {
        var newCanvas = $('<canvas class="fireworks" style="position: fixed; left: 0; top: 0; z-index: 1; pointer-events: none;"></canvas>');
	    $("body").append(newCanvas);
        $.getScript("http://cdn.bootcss.com/animejs/2.2.0/anime.min.js").done(function (script, textstatus) {
          if (textstatus == "success" && typeof(anime) != undefined) {
            $.getScript("/js/src/fireworks.js");
          }
        });
      }
    {% endif %}
  </script>
{% endif %}
