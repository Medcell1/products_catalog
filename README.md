
---

# Product Catalog App

## Overview

The **Product Catalog App** is a Flutter-based e-commerce application that allows users to manage products in a catalog. The app features CRUD (Create, Read, Update, Delete) operations for managing products, with data persistence handled using Hive, a lightweight and fast key-value database in Flutter. The app includes product search, filtering, and sorting functionalities, with a simple and clean user interface.

## Features

- **Product Management**: Users can add, edit, and delete products in the catalog.
- **Image Management**: Multiple images can be selected and managed for each product.
- **Search Functionality**: Users can search for products by name, category, or price.
- **Sorting and Filtering**: Users can sort products by name, category, and price. Active filters are displayed as chips that can be removed individually.
- **Persistent Data Storage**: Products are stored locally using Hive DB, ensuring data persistence between app sessions.
- **Static Products**: The app includes pre-defined static products, identified by integer IDs, which cannot be deleted by the user.

## Technologies Used

- **Flutter**: The app is built using Flutter for a cross-platform mobile application.
- **Hive**: A lightweight and fast NoSQL database used for local storage.
- **Provider**: Used for state management.
- **UUID**: For generating unique IDs for new products.

## Project Structure

```
lib/
│
├── models/
│   └── product.dart           # Hive model for the Product
│
├── services/
│   └── product_service.dart   # Handles Hive CRUD operations
│
├── view/
│   ├── home_screen.dart       # Main screen with product listing, search, and filters
│   ├── product_form_screen.dart  # Screen for adding/editing products
│   └── product_details_screen.dart  # Screen for viewing product details
│
├── view_model/
│   └── product_view_model.dart  # Contains business logic and state management
│
└── utils/
    ├── customs/
    │   ├── styled_text.dart  # Custom styled text widget
    │   └── sort_dialog.dart  # Dialog for sorting options
    └── globals.dart         # Global constants like colors, styles, etc.
```

## Getting Started

### Prerequisites

- **Flutter SDK**: Install the latest version of Flutter.
- **Dart SDK**: Comes with Flutter, no need for separate installation.

### Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/product-catalog-app.git
   ```
2. **Navigate to the Project Directory**:
   ```bash
   cd product-catalog-app
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the App**:
   ```bash
   flutter run
   ```

### Usage

- **Home Screen**: 
  - Displays the list of products with options to add a new product using the floating action button.
  - Search for products using the search bar.
  - Open the sort dialog by tapping the filter icon beside the search field.
  - Categories are displayed at the top when neither sorting nor searching is active.
  
- **Product Form**:
  - Add or edit product details, including name, description, price, category, and images.
  - Static products (that thier ids are integers and can be parsed as ints) are pre-defined and non-editable.

- **Product Details**:
  - View detailed information about a product.
  - Delete a product (except static products) from this screen.

### Data Persistence

- **Hive DB**:
  - Products are stored in a Hive box named `products`.
  - The app initializes with a set of static products (with IDs 0, 1, 2) for demonstration purposes.

### State Management

- **ProductViewModel**: 
  - Manages the state for product data, search, and sorting/filtering operations.
  - The `isSortingActive` flag controls whether sorting is currently applied.

### Adding New Features

- **Extending Models**: Modify the `Product` model in `models/product.dart` to add more attributes (e.g., stock quantity, ratings).
- **Additional Filters**: Implement more advanced filtering in the `ProductViewModel` and update the sort dialog accordingly.
- **API Integration**: Replace or supplement the Hive database with a backend API to fetch and manage products remotely.

## Contributing

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Create a new Pull Request.

## License

This project is licensed under the MIT License.

## Contact
- **Author**: Med
- **Email**: adeolasoremi5@example.com
- **GitHub**:[(https://github.com/Medcell1/)]

---
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/6f95d000-2bbe-4015-aeae-aaa6ffa29255" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/c016007f-6805-4819-b2db-041834a0ec29" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/e5321029-db67-4cf5-8a6e-09d983367a91" width="200"/></td>
  </tr>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/5aaa1219-21d9-464f-9a32-e24075dc1f70" width="200"/></td>
    <td><img src="https://github.com/user-attachments/assets/e4a07a06-2f6c-4dbc-a4b7-1c743bfdb4a2" width="200"/></td>
  </tr>
</table>

