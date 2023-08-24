# PizzaApp
Description: iOS app prototype for a pizza delivery service

Language: Swift
Frameworks and Libraries: UIKit programmatically, SnapKit, Foundation
Dependency Managers: Swift Package Manager

Banner Display:
Users can view various banners showcasing deals or special pizzas.
Clickable price button on banners for further details.

Menu and Special Offers:
A detailed menu where users can choose items.
Special deals or offers might be highlighted separately for users to view.

Detailed Product View:
Users can get detailed views of individual products.
They can see a product's image and description.
Products can be added to the cart directly from the details page.

Shopping Cart Functionality:
Users can add items to their shopping cart.
They have an option to view their cart and finalize their order.

Delivery or Take Away:
Users can choose between getting their order delivered or picking it up themselves.
They will need to provide respective addresses based on their choice.

Localization:
The app is to be prepared for localization, it can be available in multiple languages in the future.

# PizzaApp Demo

<table>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Bazilier/pizza-app/demo-screenshots/01.png" width="300"><br>
      <b>Main Screen</b><br>
      Choose between delivery or takeaway. Features a UICollectionView inside a UITableViewCell for banners and a UITableView for the pizza menu.
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Bazilier/pizza-app/demo-screenshots/02.png" width="300"><br>
      <b>Address Screen</b><br>
      Fetches addresses using the Dadata API.
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Bazilier/pizza-app/demo-screenshots/03.png" width="300"><br>
      <b>Product Details Screen</b><br>
      Provides detailed information and an order button.
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Bazilier/pizza-app/demo-screenshots/04.png" width="300"><br>
      <b>Cart Screen</b><br>
      Displays ordered products in a UITableView, includes a custom stepper for order customization, and a haptic feedback feature to shake and clear the cart.
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Bazilier/pizza-app/demo-screenshots/05.png" width="300"><br>
      <b>Empty Cart</b><br>
      Features a "Go to Menu" button when the cart is empty.
    </td>
    <td align="center">
      <img src="https://raw.githubusercontent.com/Bazilier/pizza-app/demo-screenshots/06.png" width="300"><br>
      <b>Dark Theme</b><br>
      Supports a dark theme in line with the system theme.
    </td>
  </tr>
</table>
