# TODO: geht so leider nicht, da das MapBuilder object in e.g. buildMap verloren geht
class MapBuilder
  constructor: (@map_id, @opt, @points) ->
    @map_handler = false
    console.log 'hello constructor!'
    #@add_points
    #@default_map_position = opt.default_map_position
    #@infowindow_base_url = opt.infowindow_base_url
    #@picture_base_url = opt.picture_base_url
    
  draw: ()->
    # das ding soll die Map dann zeichnen
    @map_handler = Gmaps.build("Google")
    @map_handler.buildMap
      internal:
        id: @map_id
    , ->
      if navigator.geolocation
        navigator.geolocation.getCurrentPosition @add_points
      else
        # position = {coords: {latitude: 52.36132, longitude: 9.628606}}
        @add_points(@opt.default_map_position)
      return
    @map_handler.getMap().setZoom(@opt.default_zoom)

  add_points: (position)->
    # dieses ding soll die points zu @map_handler hinzufügen
    # a) ersten den point auf den die map zentiert wird
    center_on_marker = @map_handler.addMarker(
      lat: position.coords.latitude
      lng: position.coords.longitude
      infowindow: if position.default then 'Default start position' else 'Your current position'
    )
    @map_handler.map.centerOn center_on_marker
    # b) dann 'alle' points, die sich im Umkreis des point aus a) befinden --> ajax
    @map_handler.addMarker(@get_points())
    # c) wenn  @points schon points beinhaltet, dann diese auch rendern
    if @points.length > 0
      @map_handler.addMarker(@points)
    
  update_points: ()->
    new_points = @get_points()
    # entweder lösche alle bestehenden Marker aus der Karte und fülle diese neu auf
    # oder schecke, ob new_marker schon vorhanden ist

  get_points: ()->
    # erhalte lat, lng, und zoom von der aktuellen Karte
    #@map_handler.getMap().getCenter(); // --> .lat(), .lng()
    #@map_handler.getMap().getZoom(); //--> e.g. 9
    # rufe eine URL mit lat, lng und zoom auf und erhalte json
    return []
  
window.MapBuilder = MapBuilder