import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:test_task/model/drink_model.dart';

class Details extends StatefulWidget {
  final Drink drink;

  const Details({super.key, required this.drink});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _noseController = TextEditingController();
  final TextEditingController _palateController = TextEditingController();
  final TextEditingController _finishController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    final selectedTextStyle = textStyle?.copyWith(fontWeight: FontWeight.bold, fontSize: 17);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink.drinkName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.drink.image,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.drink.drinkName,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(height: 24),
                        SizedBox(
                          height: 36,
                          child: SegmentedTabControl(
                            controller: _tabController,
                            selectedTabTextColor: Colors.white,
                            selectedTextStyle: selectedTextStyle,
                            textStyle: textStyle,
                            squeezeIntensity: 2,
                            tabPadding: const EdgeInsets.symmetric(horizontal: 8),
                            tabs: const [
                              SegmentTab(label: "Details", color: Colors.blue),
                              SegmentTab(label: "Tasting notes", color: Colors.blue),
                              SegmentTab(label: "History", color: Colors.blue),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 250,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              SingleChildScrollView(
                                child: _buildDetailContent(widget.drink),
                              ),
                              SingleChildScrollView(
                                child: _buildTastingNoteForm(),
                              ),
                              SingleChildScrollView(
                                child: _buildDetailContent(widget.drink), // placeholder
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // handle continue
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Add to my collection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailContent(Drink drink) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow("Shop", drink.shopName),
        _buildDetailRow("Cask Number", drink.caskNumber),
        _buildDetailRow("Age", drink.ageStatement),
        _buildDetailRow("Type", drink.drinkType),
        _buildDetailRow("Region", drink.region),
      ],
    );
  }

  Widget _buildTastingNoteForm() {
    return Column(
      children: [
        _buildTextField(_noseController, "Nose",maxLines: 5),
       const SizedBox(height: 1),
        _buildTextField(_palateController,"Palate",maxLines: 5),
      const  SizedBox(height: 1),
        _buildTextField(_finishController,"Finish",maxLines: 5),

      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Theme.of(context)
              .brightness ==
              Brightness.dark
              ? Colors.black
              : Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
                softWrap: true,
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

