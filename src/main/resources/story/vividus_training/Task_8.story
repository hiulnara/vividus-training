Meta:
    @group VIVIDUS Training
    @requirementId MyTask-0008

Scenario: Navigate to the SauceDemo website homepage
When I go to main application page
When I ${baselineAction} baseline with name `loginPage` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|10                        |

Scenario: Log in
When I log in as a user with registered username ${swagGoodUserName} and password ${swagPassword}
Then `${current-page-url}` is equal to `https://www.saucedemo.com/inventory.html`


Scenario: Add items to the shopping cart
When I select `Price <sortingValue>` in dropdown located by `xpath(//*[@class="product_sort_container"])`
When I click on element located by `xpath(//*[@class="inventory_item"][1]//button[contains(text(), "Add to cart")][1])`
When I save text of element located by `xpath(//*[@class="shopping_cart_badge"])` to scenario variable `cartCount`
Then `${cartCount}` is = `<cartBadgeCount>`
Examples:
|sortingValue   |cartBadgeCount|
|(low to high) |1             |
|(high to low)|2             |


Scenario: Populate checkout data
When I click on element located by `xpath(//*[@class="shopping_cart_link"])`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/cart.html`
When I wait until element located by `xpath(//div[@class="cart_list"])` appears
Then number of elements found by `xpath(//div[@class="cart_quantity"])` is equal to `2`
When I click on element located by `id(checkout)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-one.html`
Given I initialize story variable `userFirstName` with value `#{generate(Name.firstName)}`
Given I initialize story variable `userLastName` with value `#{generate(regexify '[A-Za-z]{10}')}`
Given I initialize story variable `postalCode` with value `#{generate(regexify '[A-Z]{3}[-][0-9]{5}')}`
When I enter `${userFirstName}` in field located by `id(first-name)`
When I enter `${userLastName}` in field located by `id(last-name)`
When I enter `${postalCode}` in field located by `id(postal-code)`
When I ${baselineAction} baseline with name `checkoutPage` ignoring:
|ELEMENT                              |AREA                          |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="checkout_info"])|By.cssSelector(.checkout_info)|50                        |


Scenario: Validate order summary and complete order
When I click on element located by `id(continue)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-step-two.html`
When I save text of element located by `xpath(//*[@class="cart_item"][1]//*[@class="inventory_item_price"][last()])` to scenario variable `SumOfCheapestItem`
When I save text of element located by `xpath(//*[@class="cart_item"][2]//*[@class="inventory_item_price"][last()])` to scenario variable `SumOfExpensiveItem`
When I save text of element located by `xpath(//*[@class="summary_subtotal_label"])` to scenario variable `totalPrice`
When I save text of element located by `xpath(//*[@class="summary_info_label summary_total_label"])` to scenario variable `totalSum`
When I save text of element located by `xpath(//*[@class="summary_tax_label"])` to scenario variable `taxSum`
Given I initialize scenario variable `SumOfCheapestItemNum` with value `#{substringAfter(${SumOfCheapestItem}, $)}`
Given I initialize scenario variable `SumOfExpensiveItemNum` with value `#{substringAfter(${SumOfExpensiveItem}, $)}`
Given I initialize scenario variable `totalPriceNum` with value `#{substringAfter(${totalPrice}, Item total: $)}`
Given I initialize scenario variable `totalSumNum` with value `#{substringAfter(${totalSum}, Total: $)}`
Given I initialize scenario variable `taxSumNum` with value `#{substringAfter(${taxSum}, Tax: $)}`
Then `#{round(#{eval(${SumOfCheapestItemNum} + ${SumOfExpensiveItemNum})}, 2, half up)}` is = `#{round(${totalPriceNum}, 2, half up)}`
Then `#{round(#{eval(${totalPriceNum} + ${taxSumNum})}, 2, half up)}` is = `#{round(${totalSumNum}, 2, half up)}`
When I ${baselineAction} baseline with name `cartItems` ignoring:
|ELEMENT                          |AREA                      |ACCEPTABLE_DIFF_PERCENTAGE|
|By.xpath(//*[@class="cart_item"])|By.cssSelector(.cart_item)|10                        |
When I click on element located by `id(finish)`
Then `${current-page-url}` is equal to `https://www.saucedemo.com/checkout-complete.html`
When I save text of element located by `xpath(//*[@class="complete-header"])` to scenario variable `thankYouMessage`
Then `${thankYouMessage}` is equal to `Thank you for the order!`
