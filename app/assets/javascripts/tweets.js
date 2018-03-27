$(document).ready(function(){
  $("#tweets").infiniteScroll({
    path: 'nav.pagination a[rel=next]',
    append: '#tweets',
    history: false,
  });
});
