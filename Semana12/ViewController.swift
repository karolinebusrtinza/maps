  import UIKit
  import MapKit
  import CoreLocation
  
  class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var locationManager: CLLocationManager?
    var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocation()
        setUpMap()
        addAnnotations(coords: getCoordinates())
        //let location = CLLocationCoordinate2D(latitude: -12.0447773, longitude: -76.9544714)
        //let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        //mapView.setRegion(region, animated: true)
        
    }
    
    func setUpMap() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        
    }
    
    func requestLocation() {
        guard CLLocationManager.locationServicesEnabled() else {return}
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
    }
    
    @IBAction func actionSegmentControl(_ sender: Any) {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        case 3:
            mapView.mapType = .hybridFlyover
        default:
            break
        }
        
    }
    
    func getCoordinates () -> [CLLocation] {
        return [
            CLLocation(latitude: -12.0447773, longitude: -76.9544714),
            CLLocation(latitude: -12.0464746, longitude: -76.9560720),
            CLLocation(latitude: -12.0455686, longitude: 76.9564661),
            CLLocation(latitude: -12.0454803, longitude: -76.950959),
        ]
    }
    
    func addAnnotations(coords: [CLLocation]) {
        for coord  in coords {
            let CLLCoordType = CLLocationCoordinate2D(latitude: coord.coordinate.latitude, longitude: coord.coordinate.longitude)
            
            annotation.coordinate = CLLCoordType
            annotation.title = "Ubicacion"
            annotation.subtitle = "Subtitulo"
            
            mapView.addAnnotation(annotation)
        }
    }
    
  }
  
  extension ViewController: CLLocationManagerDelegate {
    
  }
  
  extension ViewController: MKMapViewDelegate{
    //func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //if annotation is MKUserLocation {
    //return nil
    //}
    //let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customannotation")
    //annotationView.image = UIImage(named: "pin")
    //annotationView.canShowCallout = true
    //return annotationView
    //}
  }
