import UIKit
import WebKit

class PullRequestListViewControllerWeb: UIViewController {
    
    @IBOutlet weak var PullRequestWebView: WKWebView!
    var pullrequestWeb: PullRequest!
    @IBOutlet weak var loadingActiveIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: pullrequestWeb.user.html_url) else {
            fatalError()
        }
        let request = URLRequest(url: url)
        PullRequestWebView.load(request)
        PullRequestWebView.allowsBackForwardNavigationGestures = true
        PullRequestWebView.navigationDelegate = self
    }
}
extension PullRequestListViewControllerWeb:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActiveIndicator.stopAnimating()
    }
}
