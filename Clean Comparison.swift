// Cameron Reilly 
//Mid-Term Change log


//RootViewController functions
//Cleaned
override func viewDidLoad() {
    super.viewDidLoad()
    self.pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
    self.pageViewController?.delegate = self
    
    guard let selfStory = self.storyboard else {
        return
    }
    guard let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: selfStory) else{
        return
    }
    let viewControllers = [startingViewController]
    self.pageViewController?.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
    
    self.pageViewController?.dataSource = self.modelController
    
    guard let selfPageView = self.pageViewController else {
        return
    }
    self.addChildViewController(selfPageView)
    self.view.addSubview(selfPageView.view)
    
    var pageViewRect = self.view.bounds
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
    }
    self.pageViewController?.view.frame = pageViewRect
    
    self.pageViewController?.didMoveToParentViewController(self)
    
}

//Original
override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
    self.pageViewController!.delegate = self
    
    let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)!
    let viewControllers = [startingViewController]
    self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: {done in })
    
    self.pageViewController!.dataSource = self.modelController
    
    self.addChildViewController(self.pageViewController!)
    self.view.addSubview(self.pageViewController!.view)
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    var pageViewRect = self.view.bounds
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0)
    }
    self.pageViewController!.view.frame = pageViewRect
    
    self.pageViewController!.didMoveToParentViewController(self)
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController!.gestureRecognizers
}

//Removed DidRevieveMemoryWarning() function as all it did was call super

//Cleaned
var modelController: ModelController {

    if _modelController == nil {
        _modelController = ModelController()
    }
    guard let mc = _modelController else{
        abort()
    }
    return mc
}
//Original
var modelController: ModelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if _modelController == nil {
        _modelController = ModelController()
    }
    return _modelController!
}


//Cleaned
func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
    if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {

        guard let currentViewController = self.pageViewController?.viewControllers?[0] as? DataViewController else {
            abort()
        }
        let viewControllers = [currentViewController]
        self.pageViewController?.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
        
        self.pageViewController?.doubleSided = false
        return .Min
    }
    
    guard let currentViewController = self.pageViewController?.viewControllers?[0] as? DataViewController else {
        abort()
    }
    var viewControllers: [UIViewController]
    
    let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
    if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
        guard let spvc = self.pageViewController else {
            abort()
        }
        let nextViewController = self.modelController.pageViewController(spvc, viewControllerAfterViewController: currentViewController)
        viewControllers = [currentViewController, nextViewController!]
    } else {
        guard let spvc = self.pageViewController else {
            abort()
        }
        let previousViewController = self.modelController.pageViewController(spvc, viewControllerBeforeViewController: currentViewController)
        viewControllers = [previousViewController!, currentViewController]
    }
    self.pageViewController?.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
    
    return .Mid
}
//Original
func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
    if (orientation == .Portrait) || (orientation == .PortraitUpsideDown) || (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to true, so set it to false here.
        let currentViewController = self.pageViewController!.viewControllers![0]
        let viewControllers = [currentViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
        
        self.pageViewController!.doubleSided = false
        return .Min
    }
    
    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    let currentViewController = self.pageViewController!.viewControllers![0] as! DataViewController
    var viewControllers: [UIViewController]
    
    let indexOfCurrentViewController = self.modelController.indexOfViewController(currentViewController)
    if (indexOfCurrentViewController == 0) || (indexOfCurrentViewController % 2 == 0) {
        let nextViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerAfterViewController: currentViewController)
        viewControllers = [currentViewController, nextViewController!]
    } else {
        let previousViewController = self.modelController.pageViewController(self.pageViewController!, viewControllerBeforeViewController: currentViewController)
        viewControllers = [previousViewController!, currentViewController]
    }
    self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: {done in })
    
    return .Mid
}


//DataViewController
//Cleaned
class DataViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel?
    var dataObject: String = ""
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel?.text = dataObject
    }
    
    
}
//Original
class DataViewController: UIViewController {
    
    @IBOutlet weak var dataLabel: UILabel!
    var dataObject: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }
    
    
}


//modelController
//Cleaned
class ModelController: NSObject, UIPageViewControllerDataSource {
    
    var catData: [String] = ["Bobby", "Joey", "Fluffy", "That Other Cat"]
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.catData.count == 0) || (index >= self.catData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as? DataViewController
        dataViewController?.dataObject = self.catData[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {

        return catData.indexOf(viewController.dataObject) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        guard let vConStory = viewController.storyboard else {
            return nil
        }
        index--
        return self.viewControllerAtIndex(index, storyboard: vConStory)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.catData.count {
            return nil
        }
        guard let vConStory = viewController.storyboard else {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: vConStory)
    }
    
}
//Original

class ModelController: NSObject, UIPageViewControllerDataSource {
    
    var pageData: [String] = []
    
    
    override init() {
        super.init()
        // Create the data model.
        let dateFormatter = NSDateFormatter()
        pageData = dateFormatter.monthSymbols
    }
    
    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData[index]
        return dataViewController
    }
    
    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return pageData.indexOf(viewController.dataObject) ?? NSNotFound
    }
    
    // MARK: - Page View Controller Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}

