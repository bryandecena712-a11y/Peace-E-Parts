import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:peace_part/catalog.dart';
import 'package:peace_part/main.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('guest can complete a demo purchase', (tester) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const PeaceApp());

    await tester.tap(find.byKey(const Key('guestButton')));
    await tester.pumpAndSettle();
    expect(find.text('Your next build starts here.'), findsOneWidget);
    expect(find.text(deliveryLocation), findsOneWidget);
    expect(find.byType(Image), findsWidgets);

    await tester.tap(find.text('RAM').first);
    await tester.pumpAndSettle();
    expect(find.text('Find your fit.'), findsOneWidget);

    await tester.tap(find.text('Pulse DDR5 memory').first);
    await tester.pumpAndSettle();
    expect(find.text('Choose capacity'), findsOneWidget);
    expect(
      find.text(
        'Desktop DIMM kit. Requires a DDR5 motherboard; will not fit DDR4 slots.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('32 GB · 2 × 16 GB'));
    await tester.tap(find.byKey(const Key('addToCartButton')));
    await tester.pumpAndSettle();
    expect(find.text('Added to your cart'), findsOneWidget);
    expect(find.text('₱89 each'), findsOneWidget);

    await tester.tap(find.byKey(const Key('increaseQuantity')));
    await tester.pumpAndSettle();
    expect(find.text('Checkout · ₱178'), findsOneWidget);

    await tester.tap(find.byKey(const Key('checkoutButton')));
    await tester.pumpAndSettle();
    expect(find.text('Cash on delivery'), findsOneWidget);
    expect(find.text(deliveryLocation), findsOneWidget);
    expect(find.textContaining('Quantity: 2'), findsOneWidget);

    await tester.tap(find.byKey(const Key('placeOrderButton')));
    await tester.pumpAndSettle();
    expect(find.text("You're all set."), findsOneWidget);
    expect(find.text('ORDER #PEACE-1001'), findsOneWidget);
    expect(
      find.text(
        'This is a simulated purchase. No money has been charged and no shipment is scheduled.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('viewPurchaseNotificationButton')));
    await tester.pumpAndSettle();
    expect(find.text('Purchase confirmed'), findsOneWidget);
    expect(find.text('Demo order #PEACE-1001 · ₱178'), findsOneWidget);
  });
}
