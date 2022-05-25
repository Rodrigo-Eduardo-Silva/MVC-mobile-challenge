import UIKit
import Kingfisher

class RepositoriesListTableViewCell: UITableViewCell {
   
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var descriptionRepositoryLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareRepositoryCell(with repository: GitRepository){
        repositoryNameLabel.text = repository.name
        descriptionRepositoryLabel.text = repository.description
        forksLabel.text = String(repository.forks)
        starsLabel.text = String(repository.stargazers_count)
        userNameLabel.text = repository.full_name
        if let url = URL(string: repository.owner.avatar_url){
            avatarImage.kf.setImage(with: url, placeholder: nil, options: nil, completionHandler: nil)
        }
    }
}
