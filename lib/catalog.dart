import 'package:flutter/material.dart';

class PartOption {
  const PartOption(this.label, this.price, this.description);

  final String label;
  final int price;
  final String description;
}

class PartProduct {
  const PartProduct({
    required this.category,
    required this.name,
    required this.specification,
    required this.icon,
    required this.imageAsset,
    required this.optionLabel,
    required this.options,
    required this.compatibility,
  });

  final String category;
  final String name;
  final String specification;
  final IconData icon;
  final String imageAsset;
  final String optionLabel;
  final List<PartOption> options;
  final String compatibility;

  PartOption get startingOption => options.first;
}

const partProducts = <PartProduct>[
  PartProduct(
    category: 'RAM',
    name: 'Pulse DDR5 memory',
    specification: 'DDR5 · 6000 MT/s · CL36',
    icon: Icons.memory,
    imageAsset: 'assets/products/ram.jpg',
    optionLabel: 'capacity',
    options: [
      PartOption('16 GB', 49, '2 × 8 GB'),
      PartOption('32 GB', 89, '2 × 16 GB'),
      PartOption('64 GB', 159, '2 × 32 GB'),
    ],
    compatibility: 'Desktop DIMM kit. Requires a DDR5 motherboard; will not fit DDR4 slots.',
  ),
  PartProduct(
    category: 'SSD',
    name: 'Sprint NVMe SSD',
    specification: 'M.2 2280 · PCIe 4.0 ×4',
    icon: Icons.storage,
    imageAsset: 'assets/products/ssd.png',
    optionLabel: 'capacity',
    options: [
      PartOption('500 GB', 59, 'PCIe 4.0'),
      PartOption('1 TB', 99, 'PCIe 4.0'),
      PartOption('2 TB', 179, 'PCIe 4.0'),
    ],
    compatibility:
        'Requires an M-key M.2 slot with NVMe support. Not a SATA drive.',
  ),
  PartProduct(
    category: 'HDD',
    name: 'Vault desktop HDD',
    specification: '3.5-inch · SATA · 7200 RPM',
    icon: Icons.dns_outlined,
    imageAsset: 'assets/products/hdd.jpg',
    optionLabel: 'capacity',
    options: [
      PartOption('2 TB', 59, 'SATA'),
      PartOption('4 TB', 89, 'SATA'),
      PartOption('8 TB', 149, 'SATA'),
    ],
    compatibility: 'Requires a 3.5-inch drive bay, SATA data cable and SATA power connector.',
  ),
  PartProduct(
    category: 'GPU',
    name: 'Vector graphics card',
    specification: 'PCIe 4.0 ×16 · GDDR6',
    icon: Icons.smart_display_outlined,
    imageAsset: 'assets/products/gpu.jpg',
    optionLabel: 'capacity',
    options: [
      PartOption('8 GB', 299, 'Dual fan'),
      PartOption('12 GB', 399, 'Triple fan'),
    ],
    compatibility: '8 GB: 240 mm, 550 W PSU, 1 × 8-pin. 12 GB: 300 mm, 650 W PSU, 2 × 8-pin. Check case clearance.',
  ),
  PartProduct(
    category: 'CPU fan',
    name: 'Breeze tower cooler',
    specification: 'Air cooler · 155 mm height',
    icon: Icons.air,
    imageAsset: 'assets/products/cpu_cooler.jpg',
    optionLabel: 'cooling',
    options: [
      PartOption('120 mm', 39, 'Single fan'),
      PartOption('120 mm', 59, 'Dual fan'),
    ],
    compatibility: 'Includes AM4, AM5 and LGA1700 brackets. Case must allow at least 155 mm cooler height.',
  ),
  PartProduct(
    category: 'Motherboard',
    name: 'Core B650 motherboard',
    specification: 'AMD AM5 · B650 · DDR5',
    icon: Icons.developer_board,
    imageAsset: 'assets/products/motherboard.jpg',
    optionLabel: 'form factor',
    options: [
      PartOption('Micro-ATX', 149, '2 DIMM'),
      PartOption('ATX', 189, '4 DIMM'),
    ],
    compatibility: 'AM5 processors and DDR5 only. Micro-ATX: 244 × 244 mm. ATX: 305 × 244 mm. Check case support.',
  ),
  PartProduct(
    category: 'Case',
    name: 'Flow mesh PC case',
    specification: 'Mid tower · ATX / mATX / ITX',
    icon: Icons.computer,
    imageAsset: 'assets/products/case.jpg',
    optionLabel: 'color',
    options: [
      PartOption('Black', 79, 'Mesh front'),
      PartOption('White', 99, 'Mesh front'),
    ],
    compatibility: 'GPU clearance: 330 mm. Cooler clearance: 160 mm. Includes two 120 mm fans. PSU sold separately.',
  ),
  PartProduct(
    category: 'CPU',
    name: 'Zenith desktop CPU',
    specification: 'AM5 · 65 W · Desktop',
    icon: Icons.memory,
    imageAsset: 'assets/products/cpu.png',
    optionLabel: 'processor',
    options: [
      PartOption('6 cores', 199, '12 threads'),
      PartOption('8 cores', 249, '16 threads'),
    ],
    compatibility: 'Requires an AM5 motherboard with a compatible BIOS. Cooler sold separately.',
  ),
];

const partCategories = <String>[
  'RAM',
  'SSD',
  'HDD',
  'GPU',
  'CPU fan',
  'Motherboard',
  'Case',
  'CPU',
];

const categoryIcons = <String, IconData>{
  'RAM': Icons.memory,
  'SSD': Icons.storage,
  'HDD': Icons.dns_outlined,
  'GPU': Icons.smart_display_outlined,
  'CPU fan': Icons.air,
  'Motherboard': Icons.developer_board,
  'Case': Icons.computer,
  'CPU': Icons.memory,
};

int productIndex(PartProduct product) => partProducts.indexOf(product);

String pesoPrice(int amount) => '₱$amount';

const deliveryLocation = 'Pansol, Calamba City, Laguna';
