!-- A precondition to entire story
GivenStories: story/demo/Homepage_Demo.story

Scenario:  Log in as Good User
When I enter `${swagGoodUserName}` in field located by `id(user-name)`
When I enter `${swagPassword}` in field located by `id(password)`
When I click on element located by `id(login-button)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`
Then number of elements found by `xpath(//div[@class="inventory_item"])` is equal to `6`
When I take screenshot
