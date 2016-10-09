$(function(){
  if (window.PIE) {
    $('#pickup div.round').each(function(){
      PIE.attach(this);
    });
	}
});