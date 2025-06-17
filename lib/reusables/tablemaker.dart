import 'package:flutter/material.dart';

class CustomTable extends StatefulWidget {
  final List headers;
  final List formDataList;
  final int fixedColumnCount;
  final int rowsPerPage;

  const CustomTable({
    required this.headers,
    required this.formDataList,
    this.fixedColumnCount = 1,
    this.rowsPerPage = 10,
    super.key,
  });

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  int currentPage = 0;
  late int _rowsPerPage;
  int? selectedRowIndex;

  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _verticalScrollController2 = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.rowsPerPage;

    // Sync vertical scroll of fixed and scrollable columns
    _verticalScrollController.addListener(() {
      if (_verticalScrollController.offset != _verticalScrollController2.offset) {
        _verticalScrollController2.jumpTo(_verticalScrollController.offset);
      }
    });

    _verticalScrollController2.addListener(() {
      if (_verticalScrollController2.offset != _verticalScrollController.offset) {
        _verticalScrollController.jumpTo(_verticalScrollController2.offset);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final fixedHeaders = widget.headers.take(widget.fixedColumnCount).toList();
    final scrollableHeaders = widget.headers.skip(widget.fixedColumnCount).toList();

    final totalRows = widget.formDataList.length;
    final totalPages = (totalRows / _rowsPerPage).ceil();
    final startIndex = currentPage * _rowsPerPage;
    final endIndex = (startIndex + _rowsPerPage).clamp(0, totalRows);
    final currentRows = widget.formDataList.sublist(startIndex, endIndex);

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fixed Columns
                Column(
                  children: [
                    // Fixed Header
                    Row(
                      children: fixedHeaders.map((header) {
                        return Container(
                          width: 200,
                          padding: const EdgeInsets.all(12),
                          color: Colors.blueGrey[100],
                          child: Text(
                            header,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                    const Divider(height: 1, color: Colors.black),

                    // Fixed Data
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _verticalScrollController,
                        child: Column(
                          children: currentRows.asMap().entries.map((entry) {
                            int localIndex = entry.key;
                            var row = entry.value;
                            int globalIndex = startIndex + localIndex;
                            bool isSelected = selectedRowIndex == globalIndex;

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedRowIndex = globalIndex;
                                });
                              },
                              child: Row(
                                children: fixedHeaders.map((key) {
                                  final value = row[key] ?? '';
                                  return Container(
                                    width: 200,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.blue.shade50 : null,
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey.shade300),
                                        right: BorderSide(color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: Text(value.toString(),style: TextStyle(fontSize: 13),),
                                  );
                                }).toList(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),

                // Scrollable Columns
                Expanded(
                  child: SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Scrollable Header
                        Row(
                          children: scrollableHeaders.map((header) {
                            return Container(
                              width: 200,
                              padding: const EdgeInsets.all(12),
                              color: Colors.blueGrey[100],
                              child: Text(
                                header,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            );
                          }).toList(),
                        ),
                        const Divider(height: 1, color: Colors.black),

                        // Scrollable Data
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _verticalScrollController2,
                            child: Column(
                              children: currentRows.asMap().entries.map((entry) {
                                int localIndex = entry.key;
                                var row = entry.value;
                                int globalIndex = startIndex + localIndex;
                                bool isSelected = selectedRowIndex == globalIndex;

                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedRowIndex = globalIndex;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // textAlign: TextAlign.left,

                                    children: scrollableHeaders.map((key) {
                                      final value = row[key] ?? '';
                                      return Container(
                                        width: 200,
                                        padding: const EdgeInsets.all(12),
                                        alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                              color: isSelected ? Colors.blue.shade50 : null,
                                              border: Border(
                                                bottom: BorderSide(color: Colors.grey.shade300),
                                                right: BorderSide(color: Colors.grey.shade200),
                                              )),
                                        child: Text(
                                          value.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          softWrap: false,
                                          style: const TextStyle(fontSize: 13),
                                        )
                                      );
                                     /* return Container(
                                        width: 200,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: isSelected ? Colors.blue.shade50 : null,
                                          border: Border(
                                            bottom: BorderSide(color: Colors.grey.shade300),
                                            right: BorderSide(color: Colors.grey.shade200),
                                          ),
                                        ),
                                        child: Text(value.toString()),
                                      );*/
                                    }).toList(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Rows per page selector
                    Row(
                      children: [
                        const Text("Rows per page:", style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 4),
                        DropdownButton<int>(
                          value: _rowsPerPage,
                          isDense: true, // compact layout
                          underline: SizedBox(), // remove underline
                          style: const TextStyle(fontSize: 12, color: Colors.black),
                          items: [5, 10, 15, 20, 25].map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text('$value', style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _rowsPerPage = value;
                                currentPage = 0;
                              });
                            }
                          },
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: currentPage > 0 ? () => setState(() => currentPage--) : null,
                          icon: const Icon(Icons.chevron_left,),
                        ),
                        const VerticalDivider(thickness: 0.5),
                        Text(
                          "${startIndex + 1}–$endIndex of $totalRows",
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                        ),
                        const VerticalDivider(thickness: 0.5),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          onPressed: currentPage < totalPages - 1
                              ? () => setState(() => currentPage++)
                              : null,
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _verticalScrollController.dispose();
    _verticalScrollController2.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }
}
