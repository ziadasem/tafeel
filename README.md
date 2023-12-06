# Users Display Application -Tafeel
an example for APIs integration, scroll to get new pages and testing.

### Architecture
this project follows patterns of MVVM, where views (screens and their widgets) are in views folder and controlled by users_provider (VM) which featchs data from User services repo.
a  User services object is passed to user_provider to allow passing a Mock User services object for sake of testing.
Users provider using notifyListeners() to refresh the screens.
 

### Next sprint
1- integrate with a new API for searching for users instead of searching inside local storage
2- make the GetUser API returns more data