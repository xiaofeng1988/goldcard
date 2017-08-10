/*
 * 解决JS跨域问题
 */
jQuery.LrMap = {
    // create map
    initializeMap: function (id, url, params, callback){
        var crs = new L.CRS.goldcardGlobal();
        var options = { svr:url, crs: crs,
            worldCopyJump: false,
            minZoom: 4,
            maxZoom: 18,
            zoomControl:false  //默认不显示控制器按钮
        };
        options = L.extend({}, options, params);
        var map = new L.Map(id, options);
        var center = new L.LatLng(0, 0, true);
        if( options.center ){
          center = options.center;
        }
        var zoom = 5;
        if( options.zoom ){
          zoom = options.zoom;
        }
        map.setView(center, zoom);
        //L.TileLayer.potions.tileSize = 256//图片尺寸
        //L.TileLayer.potions.subdomains = 'abc'//子服务器地址，abc被解析成 a 或 b 或 c
        //tileSize: 256,
        //subdomains: 'abc',
        var uri = map.options.svr + "{z}/{y}-{x}.png";
        //当图片加载错误时用指定的图片替换
        var errorTileUrl = map.options.svr + "errorimg.jpg";
        var layer = new L.TileLayer(uri, { "continuousWorld": true, "noWrap": true, "errorTileUrl": errorTileUrl});
        map._baselayer = layer;
        map.addLayer(layer);
        uri = map.options.svr + "cia/{z}/{y}-{x}.png";
        var cialayer = new L.TileLayer(uri, { "continuousWorld": true, "noWrap": true });
        map.addLayer(cialayer);
        //
        callback(map);
    }
};