Meta:
    @group VIVIDUS Training
    @requirementId MyTask-0008

Lifecycle:
Examples:
|userName	                |password	    |
|standard_user	            |secret_sauce	|

Scenario: Navigate to the SauceDemo website homepage
Given I am on main application page
When I go to main application page
Then `${current-page-url}` is equal to `https://www.saucedemo.com/`
When I ${baselineAction} baseline with name `loginPage` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|10                        |

Scenario: Log in
When I log in as a user with registered username <userName> and password <password>
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`


Scenario: Add items to the shopping cart
When I select `<sortingValue_1>` in dropdown located by `<productSortContainer>`
When I click on element located by `<addItemButtonLocator>`
When I select `<sortingValue_2>` in dropdown located by `<productSortContainer>`
When I click on element located by `<addItemButtonLocator>`
When I save text of element located by `<cartBadgeCountLocatorId>` to scenario variable `cartCount`
Then `${cartCount}` is = `<cartBadgeCount>`
Examples:
|sortingValue_1|sortingValue_2|addItemButtonLocator|productSortContainer|cartBadgeCount|cartBadgeCountLocatorId|
|Price (low to high)|Price (high to low)|xpath(//div[@class="inventory_item"][1]//button[contains(@class, "btn_primary")][1])|xpath(//select[@class="product_sort_container"])|2|xpath(//a/span[1])|


Scenario: Populate checkout data
When I open my Cart
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I wait until element located by `<buttonLocator1>` appears
Then number of elements found by `<buttonLocator2>` is equal to `2`
When I click on element located by `id(checkout)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-one.html`
When I enter `<firstName>` in field located by `id(first-name)`
When I enter `<lastName>` in field located by `id(last-name)`
When I enter `<postalCode>` in field located by `id(postal-code)`
When I ${baselineAction} baseline with name `checkoutPage` ignoring:
|ELEMENT                              |AREA                          |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="checkout_info"])|By.cssSelector(.checkout_info)|50                        |
Examples:
|buttonLocator1 |buttonLocator2|firstName|lastName|postalCode|
|xpath(//div[@class="cart_list"])|xpath(//div[@class="cart_quantity"])|#{generate(regexify '[0-9A-Za-z]{10}')}|#{generate(regexify '[A-Za-z]{15}')}|#{generate(regexify '[A-Z]{3}[-][0-9]{5}')}|

Scenario: Validate order summary and complete order
When I click on element located by `id(continue)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I save text of element located by `<script1>` to scenario variable `SumOfCheapestItem`
When I save text of element located by `<script2>` to scenario variable `SumOfExpensiveItem`
When I save text of element located by `<script3>` to scenario variable `totalPrice`
Given I initialize scenario variable `SumOfCheapestItemNum` with value `#{substringAfter(${SumOfCheapestItem}, $)}`
Given I initialize scenario variable `SumOfExpensiveItemNum` with value `#{substringAfter(${SumOfExpensiveItem}, $)}`
Given I initialize scenario variable `totalPriceNum` with value `#{substringAfter(${totalPrice}, Item total: $)}`
Then `#{round(#{eval(${SumOfCheapestItemNum} + ${SumOfExpensiveItemNum})}, 2, half up)}` is = `#{round(${totalPriceNum}, 2, half up)}`
When I ${baselineAction} baseline with name `cartItems` ignoring:
|ELEMENT                          |AREA                      |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="cart_item"])|By.cssSelector(.cart_item)|50                        |
When I click on element located by `id(finish)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
When I save text of element located by `<script4>` to scenario variable `thankYouMessage`
Then `${thankYouMessage}` is equal to `Thank you for the order!`
Examples:
|script1|script2|script3|script4|
|xpath(//div[@class="cart_item"][1]//div[@class="inventory_item_price"][last()])|xpath(//div[@class="cart_item"][2]//div[@class="inventory_item_price"][last()])|xpath(//div[@class="summary_subtotal_label"])|xpath(//h2[@class="complete-header"])|
