# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
window.markers = []
jQuery ->
  map_handler = false
  opt = false
  points = []
  init_map = (map_id, get_opt, get_points)->
    opt = get_opt
    points = get_points
    map_handler = Gmaps.build("Google")
    map_handler.buildMap
      internal:
        id: map_id
    , ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition add_points
      else
        # position = {coords: {latitude: 52.36132, longitude: 9.628606}}
        add_points(opt.default_map_position)
      return
    map_handler.getMap().setZoom(12)
    window.map_handler = map_handler
    
  add_points = (position)->
    # a) ersten den point auf den die map zentiert wird
    center_on_marker = map_handler.addMarker(
      lat: position.coords.latitude
      lng: position.coords.longitude
      picture: {
        url: "https://addons.cdn.mozilla.net/img/uploads/addon_icons/13/13028-64.png"
        width:  36
        height: 36
      }
      infowindow: if position.default then 'Default start position' else 'Your current position'
    )
    map_handler.map.centerOn center_on_marker
    # b) dann 'alle' points, die sich im Umkreis des point aus a) befinden --> ajax
    get_points_near_center()
    # c) wenn  @points schon points beinhaltet, dann diese auch rendern
    if points.length > 0
      map_handler.addMarkers(points)
      
    window.map_handler = map_handler
        
  update_points = ()->
    get_points_near_center()
    # entweder lösche alle bestehenden Marker aus der Karte und fülle diese neu auf
    # oder schecke, ob new_marker schon vorhanden ist
    window.map_handler = map_handler

  get_points_near_center = ()->
    # erhalte lat, lng, und zoom von der aktuellen Karte
    #@map_handler.getMap().getCenter(); // --> .lat(), .lng()
    #@map_handler.getMap().getZoom(); //--> e.g. 9
    # rufe eine URL mit lat, lng und zoom auf und erhalte json
    map_data = map_handler.getMap()
    params = {
      zoom: map_data.getZoom()
      latitude: map_data.getCenter().lat()
      longitude: map_data.getCenter().lng()
    }
    $.get('http://geopoints-111285.euw1-2.nitrousbox.com/points.json', params, (res, status, xhr)->
      map_handler.addMarkers(res)
    , 'json')
    
  # wie bauen ich einen event linstener ein, wenn gezoomt, oder verschoben wird?
  
  
  #init_map()
  window.init_map = init_map
  window.map_handler = map_handler