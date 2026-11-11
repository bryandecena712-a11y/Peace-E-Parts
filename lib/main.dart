import 'package:flutter/material.dart';

import 'catalog.dart';

const _background = Color(0xFF1B1C1B);
const _surface = Color(0xFF272B28);
const _surfaceRaised = Color(0xFF303A35);
const _accent = Color(0xFF68D9CD);
const _mint = Color(0xFF9DEADD);
const _muted = Color(0xFF9DABA5);

void main() => runApp(const PeaceApp());

class PeaceApp extends StatelessWidget {
  const PeaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: _accent,
          brightness: Brightness.dark,
          surface: _background,
        ).copyWith(
          primary: _accent,
          onPrimary: const Color(0xFF10221F),
          secondary: _mint,
          surface: _background,
          onSurface: Colors.white,
        );

    return MaterialApp(
      title: 'PEACE E-parts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: scheme,
        scaffoldBackgroundColor: _background,
        canvasColor: _background,
        dividerColor: Colors.white12,
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: _surfaceRaised,
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: _accent,
            foregroundColor: const Color(0xFF10221F),
            minimumSize: const Size.fromHeight(48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(46),
            side: const BorderSide(color: Colors.white24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _surface,
          hintStyle: const TextStyle(color: _muted),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(color: _accent),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class DemoPurchase {
  const DemoPurchase({
    required this.product,
    required this.option,
    required this.quantity,
    required this.orderNumber,
  });

  final PartProduct product;
  final PartOption option;
  final int quantity;
  final String orderNumber;

  int get total => option.price * quantity;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _enterStore() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const ShopHome()),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _enterStore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(28, 22, 28, 18),
                children: [
                  const _BrandLockup(),
                  const SizedBox(height: 27),
                  Text(
                    _isSignUp ? 'Find your next upgrade.' : 'Good to see you.',
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _isSignUp
                        ? 'Create an account to start your build.'
                        : 'Log in for your next great find.',
                    style: const TextStyle(color: _muted),
                  ),
                  const SizedBox(height: 24),
                  const _FieldLabel('Email address'),
                  TextFormField(
                    key: const Key('emailField'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    decoration: const InputDecoration(
                      hintText: 'you@example.com',
                    ),
                    validator: (value) {
                      final email = value?.trim() ?? '';
                      if (!email.contains('@') || !email.contains('.')) {
                        return 'Enter a valid email address.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const _FieldLabel('Password'),
                  TextFormField(
                    key: const Key('passwordField'),
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _submit(),
                    autofillHints: const [AutofillHints.password],
                    decoration: InputDecoration(
                      hintText: 'Enter your password',
                      suffixIcon: IconButton(
                        tooltip: _passwordVisible
                            ? 'Hide password'
                            : 'Show password',
                        onPressed: () => setState(
                          () => _passwordVisible = !_passwordVisible,
                        ),
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 19,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if ((value ?? '').length < 6) {
                        return 'Use at least 6 characters.';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Password reset is not part of this demo.',
                              ),
                            ),
                          ),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: _mint, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  FilledButton(
                    onPressed: _submit,
                    child: Text(_isSignUp ? 'Create account' : 'Log in   →'),
                  ),
                  const SizedBox(height: 17),
                  const _OrDivider(),
                  const SizedBox(height: 15),
                  OutlinedButton.icon(
                    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Google sign-in is not enabled in this demo.',
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.g_mobiledata, size: 24),
                    label: const Text('Continue with Google'),
                  ),
                  const SizedBox(height: 13),
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          _isSignUp ? 'Already a member? ' : 'New to peace? ',
                          style: const TextStyle(color: _muted, fontSize: 13),
                        ),
                        TextButton(
                          onPressed: () =>
                              setState(() => _isSignUp = !_isSignUp),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            minimumSize: Size.zero,
                          ),
                          child: Text(
                            _isSignUp ? 'Log in' : 'Sign up',
                            style: const TextStyle(
                              color: _mint,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: TextButton.icon(
                      key: const Key('guestButton'),
                      onPressed: _enterStore,
                      icon: const Icon(Icons.arrow_forward, size: 14),
                      label: const Text('Explore as a guest'),
                      style: TextButton.styleFrom(foregroundColor: _muted),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShopHome extends StatefulWidget {
  const ShopHome({super.key});

  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  int _selectedTab = 0;
  final Set<int> _likes = {};
  PartProduct? _cartProduct;
  PartOption? _cartOption;
  int _quantity = 1;
  final List<DemoPurchase> _purchases = [];

  void _openCategory(String category) {
    final product = partProducts.firstWhere(
      (item) => item.category == category,
    );
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CategoryScreen(
          product: product,
          onOpenProduct: () => _openProduct(product),
          onOpenCategory: _openCategory,
          onOpenSearch: _openSearch,
          onOpenCart: _openCart,
        ),
      ),
    );
  }

  void _openSearch() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            SearchScreen(onOpenCategory: _openCategory, onOpenCart: _openCart),
      ),
    );
  }

  void _openProduct(PartProduct product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => ProductScreen(
          product: product,
          liked: _likes.contains(productIndex(product)),
          onToggleLike: () => _toggleLike(product),
          onAddToCart: (option) {
            setState(() {
              _cartProduct = product;
              _cartOption = option;
              _quantity = 1;
            });
            Navigator.of(context).pushReplacement(
              MaterialPageRoute<void>(
                builder: (_) => CartScreen(
                  product: product,
                  option: option,
                  quantity: 1,
                  onQuantityChanged: (value) =>
                      setState(() => _quantity = value),
                  onRemove: () => setState(() {
                    _cartProduct = null;
                    _cartOption = null;
                    _quantity = 1;
                  }),
                  onOpenCheckout: _openCheckout,
                  onExplore: _goToHome,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _toggleLike(PartProduct product) {
    setState(() {
      final index = productIndex(product);
      if (!_likes.add(index)) _likes.remove(index);
    });
  }

  void _openCart() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CartScreen(
          product: _cartProduct,
          option: _cartOption,
          quantity: _quantity,
          onQuantityChanged: (value) => setState(() => _quantity = value),
          onRemove: () => setState(() {
            _cartProduct = null;
            _cartOption = null;
            _quantity = 1;
          }),
          onOpenCheckout: _openCheckout,
          onExplore: _goToHome,
        ),
      ),
    );
  }

  void _openCheckout() {
    final product = _cartProduct;
    final option = _cartOption;
    if (product == null || option == null) return;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => CheckoutScreen(
          product: product,
          option: option,
          quantity: _quantity,
          onPlaceOrder: () => _placeOrder(product, option, _quantity),
        ),
      ),
    );
  }

  void _placeOrder(PartProduct product, PartOption option, int quantity) {
    final purchase = DemoPurchase(
      product: product,
      option: option,
      quantity: quantity,
      orderNumber: 'PEACE-1001',
    );
    setState(() {
      _purchases.insert(0, purchase);
      _cartProduct = null;
      _cartOption = null;
      _quantity = 1;
    });
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ConfirmationScreen(
          purchase: purchase,
          onViewNotification: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            setState(() => _selectedTab = 1);
          },
          onStartOver: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
            setState(() => _selectedTab = 0);
          },
        ),
      ),
    );
  }

  void _goToHome() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    setState(() => _selectedTab = 0);
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _selectTab(int index) {
    if (index == _selectedTab) return;
    setState(() => _selectedTab = index);
  }

  @override
  Widget build(BuildContext context) {
    final likedProducts = partProducts
        .where((product) => _likes.contains(productIndex(product)))
        .toList();

    return Scaffold(
      body: IndexedStack(
        index: _selectedTab,
        children: [
          HomeTab(
            cartCount: _cartProduct == null ? 0 : _quantity,
            onOpenCart: _openCart,
            onOpenSearch: _openSearch,
            onOpenCategory: _openCategory,
            onOpenProduct: _openProduct,
          ),
          NotificationsTab(
            purchases: _purchases,
            onExplore: _goToHome,
            onOpenPurchase: (purchase) => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => ConfirmationScreen(
                  purchase: purchase,
                  onViewNotification: () => Navigator.of(context).pop(),
                  onStartOver: _goToHome,
                  showBottomNav: false,
                ),
              ),
            ),
          ),
          ProfileTab(
            likeCount: _likes.length,
            cartCount: _cartProduct == null ? 0 : _quantity,
            orderCount: _purchases.length,
            onOpenLikes: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => LikesScreen(
                  products: likedProducts,
                  onOpenProduct: _openProduct,
                  onToggleLike: _toggleLike,
                  onExplore: _goToHome,
                ),
              ),
            ),
            onOpenCart: _openCart,
            onOpenOrders: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => OrdersScreen(
                  purchases: _purchases,
                  onExplore: _goToHome,
                  onOpenPurchase: (purchase) => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => ConfirmationScreen(
                        purchase: purchase,
                        onViewNotification: () => Navigator.of(context).pop(),
                        onStartOver: _goToHome,
                        showBottomNav: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            onLogout: _logout,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: _selectTab,
        height: 66,
        backgroundColor: _background,
        indicatorColor: _surfaceRaised,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications_none),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person_outline),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    required this.cartCount,
    required this.onOpenCart,
    required this.onOpenSearch,
    required this.onOpenCategory,
    required this.onOpenProduct,
    super.key,
  });

  final int cartCount;
  final VoidCallback onOpenCart;
  final VoidCallback onOpenSearch;
  final ValueChanged<String> onOpenCategory;
  final ValueChanged<PartProduct> onOpenProduct;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        key: const PageStorageKey('home'),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 9, 20, 18),
            sliver: SliverList.list(
              children: [
                Row(
                  children: [
                    const PeaceMark(size: 34),
                    const SizedBox(width: 8),
                    const Text(
                      'PEACE E-parts',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 42,
                      height: 42,
                      child: IconButton.filled(
                        tooltip: 'Open cart',
                        onPressed: onOpenCart,
                        style: IconButton.styleFrom(
                          backgroundColor: _accent,
                          foregroundColor: const Color(0xFF10221F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        icon: Badge(
                          isLabelVisible: cartCount > 0,
                          label: Text('$cartCount'),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const _DeliveryLocation(),
                const SizedBox(height: 11),
                InkWell(
                  key: const Key('searchButton'),
                  onTap: onOpenSearch,
                  borderRadius: BorderRadius.circular(11),
                  child: Container(
                    height: 42,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: _surface,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: _muted, size: 19),
                        SizedBox(width: 8),
                        Text(
                          'Search PC parts',
                          style: TextStyle(color: _muted, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 13),
                _HeroBanner(
                  eyebrow: 'YOUR BUILD. YOUR WAY.',
                  title: 'Your next build starts here.',
                  description: 'Find the right parts for your next PC.',
                ),
                const SizedBox(height: 15),
                const _SectionTitle('Shop by category'),
                const SizedBox(height: 7),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: partCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 7,
                    childAspectRatio: 1.18,
                  ),
                  itemBuilder: (context, index) {
                    final category = partCategories[index];
                    return _CategoryTile(
                      category: category,
                      onTap: () => onOpenCategory(category),
                    );
                  },
                ),
                const SizedBox(height: 15),
                const _SectionTitle('For your next build'),
                const SizedBox(height: 3),
                const Text(
                  'Example catalog · PHP · Product previews',
                  style: TextStyle(color: _muted, fontSize: 11),
                ),
                const SizedBox(height: 9),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: partProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 9,
                    childAspectRatio: 0.83,
                  ),
                  itemBuilder: (context, index) => _ProductCard(
                    product: partProducts[index],
                    onTap: () => onOpenProduct(partProducts[index]),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    required this.onOpenCategory,
    required this.onOpenCart,
    super.key,
  });

  final ValueChanged<String> onOpenCategory;
  final VoidCallback onOpenCart;

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      title: 'Search parts',
      trailing: _CartAction(onPressed: onOpenCart),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 24),
        children: [
          const SizedBox(height: 10),
          const Text(
            'What are you building?',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          const Text(
            'Tap a category to search the example catalog.',
            style: TextStyle(color: _muted, fontSize: 13),
          ),
          const SizedBox(height: 16),
          for (final category in partCategories)
            _CategoryRow(
              category: category,
              onTap: () => onOpenCategory(category),
            ),
          const SizedBox(height: 4),
          const Text(
            'Search is simulated with category shortcuts.',
            style: TextStyle(color: _muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    required this.product,
    required this.onOpenProduct,
    required this.onOpenCategory,
    required this.onOpenSearch,
    required this.onOpenCart,
    super.key,
  });

  final PartProduct product;
  final VoidCallback onOpenProduct;
  final ValueChanged<String> onOpenCategory;
  final VoidCallback onOpenSearch;
  final VoidCallback onOpenCart;

  @override
  Widget build(BuildContext context) {
    final option = product.startingOption;
    return _PageScaffold(
      title: product.category,
      trailing: _CartAction(onPressed: onOpenCart),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        children: [
          _SearchBar(onTap: onOpenSearch),
          const SizedBox(height: 15),
          const Text(
            'Find your fit.',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            'Choose a product, then pick the specifications that match your build.',
            style: TextStyle(color: _muted, fontSize: 13, height: 1.4),
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 187,
            child: Row(
              children: [
                Expanded(
                  child: _ProductCard(product: product, onTap: onOpenProduct),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: InkWell(
                    onTap: onOpenProduct,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 187,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _surface,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.fact_check_outlined,
                            color: _mint,
                            size: 29,
                          ),
                          SizedBox(height: 17),
                          Text(
                            'Check compatibility',
                            style: TextStyle(
                              color: _mint,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Sizes, interfaces and fit matter. Open the product to see the details.',
                            style: TextStyle(
                              color: _muted,
                              fontSize: 10,
                              height: 1.35,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const _SectionTitle('Browse other parts'),
          const SizedBox(height: 3),
          for (final category in partCategories.where(
            (category) => category != product.category,
          ))
            _CategoryRow(
              category: category,
              onTap: () => onOpenCategory(category),
              compact: true,
            ),
          Text(
            'Starting at ${pesoPrice(option.price)}',
            style: const TextStyle(color: _muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    required this.product,
    required this.liked,
    required this.onToggleLike,
    required this.onAddToCart,
    super.key,
  });

  final PartProduct product;
  final bool liked;
  final VoidCallback onToggleLike;
  final ValueChanged<PartOption> onAddToCart;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late PartOption _selected;
  late bool _liked;

  @override
  void initState() {
    super.initState();
    _selected = widget.product.startingOption;
    _liked = widget.liked;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(title: product.category),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(19, 8, 19, 20),
                children: [
                  _ProductArtwork(
                    product: product,
                    height: 145,
                    trailing: IconButton(
                      key: const Key('favoriteButton'),
                      tooltip: _liked ? 'Remove from Likes' : 'Save to Likes',
                      onPressed: () {
                        setState(() => _liked = !_liked);
                        widget.onToggleLike();
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: const Color(0xFF27332E),
                        foregroundColor: _mint,
                      ),
                      icon: Icon(
                        _liked ? Icons.favorite : Icons.favorite_border,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.specification,
                    style: const TextStyle(color: _muted, fontSize: 12),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Example product · Prices in PHP',
                    style: TextStyle(color: _mint, fontSize: 11),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Choose ${product.optionLabel}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  for (final option in product.options)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: _OptionTile(
                        product: product,
                        option: option,
                        selected: _selected == option,
                        onTap: () => setState(() => _selected = option),
                      ),
                    ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: const Color(0xFF26312C),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Before you buy',
                          style: TextStyle(
                            color: _mint,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          product.compatibility,
                          style: const TextStyle(
                            color: _muted,
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      'Prototype: one configuration per order.',
                      style: TextStyle(color: _muted, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 12),
              decoration: const BoxDecoration(
                color: _background,
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'TOTAL',
                        style: TextStyle(color: _muted, fontSize: 9),
                      ),
                      Text(
                        pesoPrice(_selected.price),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: FilledButton.icon(
                      key: const Key('addToCartButton'),
                      onPressed: () => widget.onAddToCart(_selected),
                      icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                      label: const Text('Add to cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({
    required this.product,
    required this.option,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
    required this.onOpenCheckout,
    required this.onExplore,
    super.key,
  });

  final PartProduct? product;
  final PartOption? option;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;
  final VoidCallback onOpenCheckout;
  final VoidCallback onExplore;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late int _quantity = widget.quantity;
  bool _removed = false;

  @override
  Widget build(BuildContext context) {
    final product = _removed ? null : widget.product;
    final option = _removed ? null : widget.option;
    if (product == null || option == null) {
      return _PageScaffold(
        title: 'Cart',
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            const Text(
              'Good builds start here.',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 15),
            _EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'Your cart is empty',
              message: 'Choose a part, pick its specifications and add it to your cart.',
              buttonLabel: 'Explore PC parts',
              onPressed: widget.onExplore,
            ),
            const SizedBox(height: 12),
            const Text(
              'Demo checkout supports one configured product at a time.',
              style: TextStyle(color: _muted, fontSize: 10),
            ),
          ],
        ),
      );
    }

    final total = option.price * _quantity;
    return _PageScaffold(
      title: 'Cart',
      bottomAction: FilledButton(
        key: const Key('checkoutButton'),
        onPressed: widget.onOpenCheckout,
        child: Text('Checkout · ${pesoPrice(total)}'),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 3, 20, 15),
        children: [
          const Text(
            'Added to your cart',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 7),
          const Text(
            'Your selected configuration is ready.',
            style: TextStyle(color: _muted, fontSize: 12),
          ),
          const SizedBox(height: 15),
          _CartItemCard(
            product: product,
            option: option,
            quantity: _quantity,
            onDecrease: _quantity > 1
                ? () => _setQuantity(_quantity - 1)
                : null,
            onIncrease: _quantity < 2
                ? () => _setQuantity(_quantity + 1)
                : null,
            onRemove: () {
              setState(() => _removed = true);
              widget.onRemove();
            },
          ),
          const SizedBox(height: 12),
          _TotalsCard(subtotal: total),
          const SizedBox(height: 11),
          const Text(
            'Demo cart holds one configured product. Starting a new shopping demo clears this selection.',
            style: TextStyle(color: _muted, fontSize: 10, height: 1.4),
          ),
        ],
      ),
    );
  }

  void _setQuantity(int quantity) {
    setState(() => _quantity = quantity);
    widget.onQuantityChanged(quantity);
  }
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({
    required this.product,
    required this.option,
    required this.quantity,
    required this.onPlaceOrder,
    super.key,
  });

  final PartProduct product;
  final PartOption option;
  final int quantity;
  final VoidCallback onPlaceOrder;

  @override
  Widget build(BuildContext context) {
    final total = option.price * quantity;
    return _PageScaffold(
      title: 'Checkout',
      bottomAction: FilledButton(
        key: const Key('placeOrderButton'),
        onPressed: onPlaceOrder,
        child: Text('Place demo order · ${pesoPrice(total)}'),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 3, 20, 15),
        children: [
          const Text(
            'Almost ready to build.',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          _InfoCard(
            icon: Icons.location_on_outlined,
            title: 'Deliver to',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bryan Enriquez',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 5),
                Text(
                  deliveryLocation,
                  style: TextStyle(color: _muted, fontSize: 12, height: 1.4),
                ),
                SizedBox(height: 7),
                Text(
                  'Sample address for this prototype',
                  style: TextStyle(color: _muted, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _InfoCard(
            title: 'Your order',
            child: Column(
              children: [
                _OrderProductLine(
                  product: product,
                  option: option,
                  quantity: quantity,
                ),
                const SizedBox(height: 12),
                _TotalsRows(subtotal: total),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _InfoCard(
            icon: Icons.credit_card_outlined,
            title: 'Cash on delivery',
            child: const Text(
              'No payment details required. Pay on delivery in this demonstration.',
              style: TextStyle(color: _muted, fontSize: 11, height: 1.4),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Demo order only. No payment will be collected and nothing will be shipped.',
            style: TextStyle(color: _muted, fontSize: 10, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({
    required this.purchase,
    required this.onViewNotification,
    required this.onStartOver,
    this.showBottomNav = true,
    super.key,
  });

  final DemoPurchase purchase;
  final VoidCallback onViewNotification;
  final VoidCallback onStartOver;
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: !showBottomNav,
        child: Column(
          children: [
            const _TopBar(title: 'Order confirmation', showBack: false),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 21,
                    ),
                    decoration: BoxDecoration(
                      color: _surface,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.check, color: _mint, size: 30),
                        SizedBox(height: 8),
                        Text(
                          "You're all set.",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Your demo order has been placed.',
                          style: TextStyle(color: _muted, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _surface,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ORDER #${purchase.orderNumber}',
                          style: const TextStyle(
                            color: _mint,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          purchase.product.name,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _optionDescription(purchase.product, purchase.option),
                          style: const TextStyle(color: _muted, fontSize: 11),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Quantity: ${purchase.quantity}',
                          style: const TextStyle(color: _muted, fontSize: 11),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${pesoPrice(purchase.total)} · Cash on delivery',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Bryan Enriquez · $deliveryLocation',
                          style: TextStyle(
                            color: _muted,
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    child: Text(
                      'This is a simulated purchase. No money has been charged and no shipment is scheduled.',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 10,
                        height: 1.4,
                      ),
                    ),
                  ),
                  FilledButton(
                    key: const Key('viewPurchaseNotificationButton'),
                    onPressed: onViewNotification,
                    child: const Text('View purchase notification'),
                  ),
                  const SizedBox(height: 7),
                  OutlinedButton(
                    onPressed: onStartOver,
                    child: const Text('Start a new shopping demo'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNav ? const _BottomNavSpacer() : null,
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({
    required this.purchases,
    required this.onExplore,
    required this.onOpenPurchase,
    super.key,
  });

  final List<DemoPurchase> purchases;
  final VoidCallback onExplore;
  final ValueChanged<DemoPurchase> onOpenPurchase;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        children: [
          const _SectionTitle('Notifications'),
          const SizedBox(height: 17),
          const Text(
            'Your build, in the loop.',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 13),
          if (purchases.isEmpty)
            _EmptyState(
              icon: Icons.notifications_none,
              title: 'Nothing here yet',
              message: 'Purchase confirmations will appear here after you place a demo order.',
              buttonLabel: 'Start exploring',
              onPressed: onExplore,
            )
          else ...[
            const Text('TODAY', style: TextStyle(color: _muted, fontSize: 10)),
            const SizedBox(height: 8),
            for (final purchase in purchases)
              _NotificationCard(
                purchase: purchase,
                onTap: () => onOpenPurchase(purchase),
              ),
            const SizedBox(height: 5),
            const Text(
              'Simulated purchase only. Starting a new demo from Home resets the journey.',
              style: TextStyle(color: _muted, fontSize: 10, height: 1.4),
            ),
          ],
        ],
      ),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    required this.likeCount,
    required this.cartCount,
    required this.orderCount,
    required this.onOpenLikes,
    required this.onOpenCart,
    required this.onOpenOrders,
    required this.onLogout,
    super.key,
  });

  final int likeCount;
  final int cartCount;
  final int orderCount;
  final VoidCallback onOpenLikes;
  final VoidCallback onOpenCart;
  final VoidCallback onOpenOrders;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 17, 20, 24),
        children: [
          const _SectionTitle('Me'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PeaceMark(size: 34),
                SizedBox(height: 8),
                Text(
                  'Hey, Bryan.',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Text(
                  'Bryan Enriquez · Demo account',
                  style: TextStyle(color: _muted, fontSize: 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          _ProfileLink(
            icon: Icons.favorite_border,
            title: 'Likes',
            subtitle: 'Your hearted parts, all in one place',
            badge: likeCount,
            onTap: onOpenLikes,
          ),
          const SizedBox(height: 8),
          _ProfileLink(
            icon: Icons.shopping_cart_outlined,
            title: 'Cart',
            subtitle: 'Parts you haven’t bought yet',
            badge: cartCount,
            onTap: onOpenCart,
          ),
          const SizedBox(height: 8),
          _ProfileLink(
            icon: Icons.inventory_2_outlined,
            title: 'My orders',
            subtitle: 'View your purchase confirmations',
            badge: orderCount,
            onTap: onOpenOrders,
          ),
          const SizedBox(height: 10),
          const Text(
            'peace · PC parts. Peace of mind.',
            style: TextStyle(color: _muted, fontSize: 10),
          ),
          const SizedBox(height: 13),
          OutlinedButton(
            onPressed: onLogout,
            child: const Text(
              'Log out',
              style: TextStyle(color: _mint, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class LikesScreen extends StatefulWidget {
  const LikesScreen({
    required this.products,
    required this.onOpenProduct,
    required this.onToggleLike,
    required this.onExplore,
    super.key,
  });

  final List<PartProduct> products;
  final ValueChanged<PartProduct> onOpenProduct;
  final ValueChanged<PartProduct> onToggleLike;
  final VoidCallback onExplore;

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {
  final Set<int> _removed = {};

  @override
  Widget build(BuildContext context) {
    final products = widget.products
        .where((product) => !_removed.contains(productIndex(product)))
        .toList();
    return _PageScaffold(
      title: 'Likes',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
        children: [
          if (products.isEmpty)
            _EmptyState(
              icon: Icons.favorite_border,
              title: 'Save your next upgrade',
              message:
                  'Tap the heart on a product to preview it in your wishlist.',
              buttonLabel: 'Start exploring',
              onPressed: widget.onExplore,
              note: 'Wishlist saving is shown as individual demo states.',
            )
          else ...[
            const Text(
              'Saved for your next build.',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 5),
            Text(
              '${products.length} saved product${products.length == 1 ? '' : 's'}',
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
            const SizedBox(height: 13),
            for (final product in products)
              Padding(
                padding: const EdgeInsets.only(bottom: 11),
                child: _LikedProductCard(
                  product: product,
                  onChooseOptions: () => widget.onOpenProduct(product),
                  onRemove: () {
                    setState(() => _removed.add(productIndex(product)));
                    widget.onToggleLike(product);
                  },
                ),
              ),
            const Text(
              'Wishlist preview for this product. Starting a new demo returns to the empty list.',
              style: TextStyle(color: _muted, fontSize: 10),
            ),
          ],
        ],
      ),
    );
  }
}

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({
    required this.purchases,
    required this.onExplore,
    required this.onOpenPurchase,
    super.key,
  });

  final List<DemoPurchase> purchases;
  final VoidCallback onExplore;
  final ValueChanged<DemoPurchase> onOpenPurchase;

  @override
  Widget build(BuildContext context) {
    return _PageScaffold(
      title: 'My orders',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 24),
        children: [
          if (purchases.isEmpty)
            _EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'No orders yet',
              message: 'Your completed demo purchase will include the exact part and specifications you selected.',
              buttonLabel: 'Start exploring',
              onPressed: onExplore,
            )
          else ...[
            for (final purchase in purchases)
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: _NotificationCard(
                  purchase: purchase,
                  onTap: () => onOpenPurchase(purchase),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _PageScaffold extends StatelessWidget {
  const _PageScaffold({
    required this.title,
    required this.child,
    this.trailing,
    this.bottomAction,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final Widget? bottomAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(title: title, trailing: trailing),
            Expanded(child: child),
            if (bottomAction != null)
              Container(
                padding: const EdgeInsets.fromLTRB(18, 9, 18, 11),
                decoration: const BoxDecoration(
                  color: _background,
                  border: Border(top: BorderSide(color: Colors.white10)),
                ),
                child: bottomAction,
              ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title, this.trailing, this.showBack = true});

  final String title;
  final Widget? trailing;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          if (showBack)
            IconButton(
              tooltip: 'Back',
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_new, size: 17),
            )
          else
            const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          if (trailing != null) trailing! else const SizedBox(width: 14),
        ],
      ),
    );
  }
}

class _BrandLockup extends StatelessWidget {
  const _BrandLockup();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        PeaceMark(size: 44),
        SizedBox(width: 10),
        Text(
          'PEACE E-parts',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class PeaceMark extends StatelessWidget {
  const PeaceMark({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _surfaceRaised,
          borderRadius: BorderRadius.circular(size * 0.22),
        ),
        child: CustomPaint(painter: _PeaceMarkPainter()),
      ),
    );
  }
}

class _PeaceMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final outline = Paint()
      ..color = _mint
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.035;
    final left = Path()
      ..moveTo(w * 0.5, h * 0.12)
      ..lineTo(w * 0.22, h * 0.25)
      ..lineTo(w * 0.22, h * 0.72)
      ..lineTo(w * 0.5, h * 0.88)
      ..close();
    final right = Path()
      ..moveTo(w * 0.5, h * 0.12)
      ..lineTo(w * 0.78, h * 0.25)
      ..lineTo(w * 0.78, h * 0.72)
      ..lineTo(w * 0.5, h * 0.88)
      ..close();
    canvas.drawPath(left, Paint()..color = const Color(0xFF55BDAE));
    canvas.drawPath(right, Paint()..color = const Color(0xFF8AE0D1));
    canvas.drawPath(left, outline);
    canvas.drawPath(right, outline);
    canvas.drawLine(
      Offset(w * 0.5, h * 0.12),
      Offset(w * 0.5, h * 0.88),
      outline,
    );
    canvas.drawLine(
      Offset(w * 0.35, h * 0.33),
      Offset(w * 0.35, h * 0.69),
      outline,
    );
    canvas.drawLine(
      Offset(w * 0.65, h * 0.33),
      Offset(w * 0.65, h * 0.69),
      outline,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 12, 13, 11),
      decoration: BoxDecoration(
        color: _surfaceRaised,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow,
            style: const TextStyle(
              color: _mint,
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              height: 1.12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            style: const TextStyle(color: _muted, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.category, required this.onTap});

  final String category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _surface,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(categoryIcons[category], size: 19, color: _mint),
            const SizedBox(height: 4),
            Text(
              category,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 9),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.category,
    required this.onTap,
    this.compact = false,
  });

  final String category;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: compact ? 7 : 10),
        child: Row(
          children: [
            Icon(categoryIcons[category], color: _mint, size: 17),
            const SizedBox(width: 10),
            Expanded(
              child: Text(category, style: const TextStyle(fontSize: 12)),
            ),
            const Icon(Icons.arrow_forward, color: _mint, size: 14),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});

  final PartProduct product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final option = product.startingOption;
    return Material(
      color: _surface,
      borderRadius: BorderRadius.circular(13),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProductArtwork(product: product, height: 80),
              const SizedBox(height: 7),
              Text(
                product.category.toUpperCase(),
                style: const TextStyle(
                  color: _mint,
                  fontSize: 8,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${option.label} · ${option.description}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: _muted, fontSize: 8),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    pesoPrice(option.price),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward, color: _mint, size: 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductArtwork extends StatelessWidget {
  const _ProductArtwork({
    required this.product,
    this.height = 116,
    this.trailing,
  });

  final PartProduct product;
  final double height;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _surfaceRaised,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              product.imageAsset,
              width: double.infinity,
              height: height,
              fit: BoxFit.contain,
            ),
          ),
          if (trailing != null) Positioned(top: 5, right: 5, child: trailing!),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.product,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final PartProduct product;
  final PartOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final extra = option.description.isEmpty ? '' : ' · ${option.description}';
    return Material(
      color: selected ? const Color(0xFF29423C) : _surface,
      borderRadius: BorderRadius.circular(9),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(9),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected ? _mint : Colors.transparent,
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${option.label}$extra',
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              Text(
                pesoPrice(option.price),
                style: const TextStyle(
                  color: _mint,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryLocation extends StatelessWidget {
  const _DeliveryLocation();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on_outlined, color: _mint, size: 17),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deliver to',
                  style: TextStyle(color: _muted, fontSize: 9),
                ),
                SizedBox(height: 2),
                Text(
                  deliveryLocation,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 39,
        padding: const EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: _muted, size: 18),
            SizedBox(width: 8),
            Text(
              'Search PC parts',
              style: TextStyle(color: _muted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartAction extends StatelessWidget {
  const _CartAction({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Open cart',
      onPressed: onPressed,
      icon: const Icon(Icons.shopping_cart_outlined, size: 19),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.buttonLabel,
    this.onPressed,
    this.note,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? buttonLabel;
  final VoidCallback? onPressed;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 19, 14, 14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: _muted, size: 28),
          const SizedBox(height: 9),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 5),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _muted, fontSize: 11, height: 1.4),
          ),
          if (buttonLabel != null && onPressed != null) ...[
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPressed,
                child: Text(buttonLabel!),
              ),
            ),
          ],
          if (note != null) ...[
            const SizedBox(height: 13),
            Text(
              note!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _muted, fontSize: 9),
            ),
          ],
        ],
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.product,
    required this.option,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
  });

  final PartProduct product;
  final PartOption option;
  final int quantity;
  final VoidCallback? onDecrease;
  final VoidCallback? onIncrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 49,
                height: 49,
                child: _ProductArtwork(product: product, height: 49),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _optionDescription(product, option),
                      style: const TextStyle(color: _mint, fontSize: 9),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${pesoPrice(option.price)} each',
                      style: const TextStyle(color: _muted, fontSize: 9),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Quantity',
                style: TextStyle(color: _muted, fontSize: 10),
              ),
              const Spacer(),
              _QuantityButton(
                label: '−',
                keyName: 'decreaseQuantity',
                onPressed: onDecrease,
              ),
              SizedBox(
                width: 34,
                child: Center(
                  child: Text(
                    '$quantity',
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              _QuantityButton(
                label: '+',
                keyName: 'increaseQuantity',
                onPressed: onIncrease,
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onRemove,
              style: TextButton.styleFrom(foregroundColor: _mint),
              child: const Text('Remove item', style: TextStyle(fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.label,
    required this.keyName,
    required this.onPressed,
  });

  final String label;
  final String keyName;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: Key(keyName),
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 29, height: 29),
      padding: EdgeInsets.zero,
      style: IconButton.styleFrom(
        backgroundColor: _surfaceRaised,
        foregroundColor: _mint,
        disabledForegroundColor: _muted,
      ),
      icon: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({required this.subtotal});

  final int subtotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(13),
      ),
      child: _TotalsRows(subtotal: subtotal),
    );
  }
}

class _TotalsRows extends StatelessWidget {
  const _TotalsRows({required this.subtotal});

  final int subtotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TotalRow(label: 'Subtotal', value: pesoPrice(subtotal)),
        const SizedBox(height: 5),
        _TotalRow(label: 'Shipping', value: 'Free'),
        const SizedBox(height: 5),
        _TotalRow(label: 'Total (PHP)', value: pesoPrice(subtotal), bold: true),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: bold ? 12 : 10,
      fontWeight: bold ? FontWeight.w700 : FontWeight.normal,
      color: bold ? Colors.white : _muted,
    );
    return Row(
      children: [
        Text(label, style: style),
        const Spacer(),
        Text(value, style: style),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.child, this.icon});

  final String title;
  final Widget child;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: _mint, size: 16),
                const SizedBox(width: 8),
              ],
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          child,
        ],
      ),
    );
  }
}

class _OrderProductLine extends StatelessWidget {
  const _OrderProductLine({
    required this.product,
    required this.option,
    required this.quantity,
  });

  final PartProduct product;
  final PartOption option;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 32,
          height: 32,
          child: _ProductArtwork(product: product, height: 32),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${_optionDescription(product, option)}\nQuantity: $quantity',
                style: const TextStyle(color: _muted, fontSize: 9, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  const _NotificationCard({required this.purchase, required this.onTap});

  final DemoPurchase purchase;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _surface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(purchase.product.icon, color: _mint, size: 18),
              const SizedBox(width: 9),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Purchase confirmed',
                      style: TextStyle(
                        color: _mint,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      purchase.product.name,
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${_optionDescription(purchase.product, purchase.option)} · Quantity ${purchase.quantity}',
                      style: const TextStyle(color: _muted, fontSize: 9),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Demo order #${purchase.orderNumber} · ${pesoPrice(purchase.total)}',
                      style: const TextStyle(color: _muted, fontSize: 9),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Your demo order was placed. Tap to view the confirmation.',
                      style: TextStyle(
                        color: _muted,
                        fontSize: 9,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Just now  →',
                      style: TextStyle(color: _mint, fontSize: 9),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileLink extends StatelessWidget {
  const _ProfileLink({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.badge = 0,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final int badge;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _surface,
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            children: [
              Icon(icon, color: _mint, size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(color: _muted, fontSize: 9),
                    ),
                  ],
                ),
              ),
              if (badge > 0) ...[
                Text(
                  '$badge',
                  style: const TextStyle(color: _mint, fontSize: 10),
                ),
                const SizedBox(width: 7),
              ],
              const Icon(Icons.arrow_forward, color: _mint, size: 15),
            ],
          ),
        ),
      ),
    );
  }
}

class _LikedProductCard extends StatelessWidget {
  const _LikedProductCard({
    required this.product,
    required this.onChooseOptions,
    required this.onRemove,
  });

  final PartProduct product;
  final VoidCallback onChooseOptions;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductArtwork(product: product, height: 94),
          const SizedBox(height: 9),
          Text(
            product.name,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            'From ${pesoPrice(product.startingOption.price)} · Choose your specifications',
            style: const TextStyle(color: _muted, fontSize: 9),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onChooseOptions,
              child: const Text('Choose options'),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onRemove,
              child: const Text('Remove from Likes'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Colors.white12)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or continue with',
            style: TextStyle(color: _muted, fontSize: 10),
          ),
        ),
        Expanded(child: Divider(color: Colors.white12)),
      ],
    );
  }
}

class _BottomNavSpacer extends StatelessWidget {
  const _BottomNavSpacer();

  @override
  Widget build(BuildContext context) => const SizedBox(height: 0);
}

String _optionDescription(PartProduct product, PartOption option) {
  if (product.category == 'RAM') {
    return '${option.label} · ${option.description}';
  }
  if (product.category == 'SSD') {
    return option.label;
  }
  return '${option.label} · ${option.description}';
}
