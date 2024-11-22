# Case Study
- My main idea was keeping the viper modules simple, readable and open to extend.
- Moslty I focus on to each class has one responsibility to conform SRP.
- Implemented test cases for extensions and viper modules.
- For collection view, I created compositional layout provider to handle sponsored and normal products.
- Base cell implemented for generic approach for sponsored and normal products.
- Seperated network provider as different framework.
- By using base protocols I aim to increase modularity, scalability, and reusability hence increase the testability.
- Followed Solid and clean code.
- SwiftLinter added to the project.
- Used Operation due to it provide cancel mechanism.

- - Apart from the case, I configured basic staging and live environment. Usually I provide this by adding multiple schemas for staging and production but this time i keep very simple with User defaults.
    - Used 3rd dependencies as netfox, alamofire, progresshud, cosmos, reachability and sdwebImage. 
