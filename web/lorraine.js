$(function(){
  
  // Find the host
  //var pathArray = window.location.pathname.split( '/' );
  var host = getBaseURL() + "faye"; //pathArray[0]; // + "/";
  host = host.replace("/admin", "");
  
  // alert(host);
    
  window.faye_client = new Faye.Client(host);
  console.log("client: "+ host)

  window.faye_client.subscribe('/messages', function(message) {
    alert('Got a message: ' + message.text);
  });
  
});

function illuminatePixel(pixel, r, g, b) {
  window.faye_client.publish('/illuminate', [1, pixel, r * 4095, g * 4095, b * 4095]);
}

function refresh() {
  window.faye_client.publish('/illuminate', [2]);
}

function illuminateAll(r, g, b) {
  illuminatePixel(0, r, g, b);
  illuminatePixel(1, r, g, b);
  illuminatePixel(2, r, g, b);
  illuminatePixel(3, r, g, b);
  illuminatePixel(4, r, g, b);
}


function colorChanged(color) {
  illuminateAll(color.rgb[0], color.rgb[1], color.rgb[2]);
  refresh();
}


function getBaseURL() {
    var url = location.href;  // entire url including querystring - also: window.location.href;
    var baseURL = url.substring(0, url.indexOf('/', 14));


    if (baseURL.indexOf('http://localhost') != -1) {
        // Base Url for localhost
        var url = location.href;  // window.location.href;
        var pathname = location.pathname;  // window.location.pathname;
        var index1 = url.indexOf(pathname);
        var index2 = url.indexOf("/", index1 + 1);
        var baseLocalUrl = url.substr(0, index2);

        return baseLocalUrl + "/";
    }
    else {
        // Root Url for domain name
        return baseURL + "/";
    }

}
