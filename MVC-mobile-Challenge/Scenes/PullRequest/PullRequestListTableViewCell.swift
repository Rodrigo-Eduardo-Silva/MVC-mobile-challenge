import UIKit
import Kingfisher
class PullRequestListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var avatarPullimage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func preparePullrequest(with pullrequest: PullRequest){
        titleLabel.text = pullrequest.title
        bodyLabel.text = pullrequest.user.body
        if let url = URL(string: pullrequest.user.avatar_url){
            avatarPullimage.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        }
    }

}
