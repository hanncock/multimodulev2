import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;


// Helper class for the right-click menu actions
class PopupMenuAction {
  final String label;
  final void Function(Map<String, dynamic> rowData)? onTap;

  PopupMenuAction({required this.label, required this.onTap});
}


class CustomTable extends StatefulWidget {
  final List<PopupMenuAction>? popupActions;
  final List headers;
  final List formDataList;
  final int fixedColumnCount;
  final int rowsPerPage;
  final Function(Map<String, dynamic> selectedRow)? onRowSelect;

  const CustomTable({
    required this.headers,
    required this.formDataList,
    this.fixedColumnCount = 1,
    this.rowsPerPage = 20,
    this.onRowSelect,
    this.popupActions,
    super.key,
  });

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  int currentPage = 0;
  late int _rowsPerPage;

  // Use a Set to track selected row data maps for selection state
  Set<Map<String, dynamic>> selectedRows = {};

  final ScrollController _verticalScrollController = ScrollController();
  final ScrollController _verticalScrollController2 = ScrollController();
  final ScrollController _horizontalScrollController = ScrollController();

  // --- Styling Utility Functions ---

  Widget _buildStatusChip(String status) {
    Color color;
    Color textColor;
    String text = status;

    switch (status.toLowerCase()) {
      case 'active':
      case 'available':
        color = Colors.green.shade100.withOpacity(0.5);
        textColor = Colors.green.shade800;
        break;
      case 'maintenance':
        color = Colors.yellow.shade100.withOpacity(0.5);
        textColor = const Color.fromARGB(255, 179, 140, 0);
        break;
      case 'inactive':
        color = Colors.grey.shade200;
        textColor = Colors.grey.shade700;
        break;
      case 'out of service':
        color = Colors.red.shade100.withOpacity(0.5);
        textColor = Colors.red.shade700;
        break;
      default:
        color = Colors.grey.shade100;
        textColor = Colors.black87;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          // Action logic here
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.black54),
              const SizedBox(width: 4),
              Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  // --- Top Controls Widget (Search/Filter/Columns) ---

  Widget _buildTopControls() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search Bar
          Container(
            width: 350,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search Vehicles, operators, license plates...",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Filter and Column Buttons
          Row(
            children: [
              // Filter Button
              Container(
                height: 40,
                margin: const EdgeInsets.only(right: 8),
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, size: 20, color: Colors.black54),
                  label: const Text("Filter", style: TextStyle(color: Colors.black87)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              // Column Selector Button
              Container(
                height: 40,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.grid_view_outlined, size: 20, color: Colors.black54),
                  label: const Text("Column", style: TextStyle(color: Colors.black87)),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Init/Dispose ---
  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.rowsPerPage;

    if (kIsWeb) {
      html.document.onContextMenu.listen((event) => event.preventDefault());
    }

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

  // @override
  // void dispose() {
  //   _verticalScrollController.dispose();
  //   _verticalScrollController2.dispose();
  //   _horizontalScrollController.dispose();
  //   super.dispose();
  // }

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    const double checkboxColumnWidth = 56.0;
    const double fixedColumnWidth = 200.0;
    const double scrollableColumnWidth = 150.0;
    const double actionColumnWidth = 200.0; // Increased to help with horizontal scroll

    final fixedHeaders = widget.headers.take(widget.fixedColumnCount).toList();
    final scrollableHeaders = widget.headers.skip(widget.fixedColumnCount).toList();

    // CRITICAL FIX: Ensure formDataList is a List
    final List dataList = widget.formDataList ?? [];

    final totalRows = dataList.length;
    final totalPages = (totalRows / _rowsPerPage).ceil();

    if (currentPage >= totalPages && totalPages > 0) {
      currentPage = totalPages - 1;
    } else if (totalPages == 0) {
      currentPage = 0;
    }

    final startIndex = currentPage * _rowsPerPage;
    final endIndex = (startIndex + _rowsPerPage).clamp(0, totalRows);

    final currentRows = dataList.sublist(startIndex, endIndex).cast<Map<String, dynamic>>();

    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        children: [
          // Top Controls (Search, Filter, Column)
          _buildTopControls(),

          // Main Table Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  // Table Data Area
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Fixed Columns (Checkbox + Fixed Data)
                        Column(
                          children: [
                            // Fixed Header (Checkbox + Fixed Headers)
                            Row(
                              children: [
                                // Checkbox Header
                                Container(
                                  width: checkboxColumnWidth,
                                  height: 48,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey.shade300),
                                      // Vertical separator removed
                                    ),
                                  ),
                                  child: Checkbox(
                                    value: currentRows.isNotEmpty && selectedRows.length == currentRows.length,
                                    onChanged: (bool? val) {
                                      setState(() {
                                        if (val == true) {
                                          selectedRows.addAll(currentRows);
                                        } else {
                                          selectedRows.clear();
                                        }
                                      });
                                    },
                                    activeColor: Colors.blue.shade600,
                                    checkColor: Colors.white,
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                // Fixed Text Headers
                                ...fixedHeaders.map((header) {
                                  return Container(
                                    width: fixedColumnWidth,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      border: Border(
                                        bottom: BorderSide(color: Colors.grey.shade300),
                                        // Vertical separator removed
                                      ),
                                    ),
                                    child: Text(
                                      header.toString(),
                                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),

                            // Fixed Data
                            Expanded(
                              child: SingleChildScrollView(
                                controller: _verticalScrollController,
                                child: Column(
                                  children: currentRows.map((row) {
                                    bool isSelected = selectedRows.contains(row);

                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (isSelected) {
                                            selectedRows.remove(row);
                                          } else {
                                            selectedRows.add(row);
                                          }
                                        });
                                      },
                                      onDoubleTap: (){
                                        if (widget.onRowSelect != null) {
                                          widget.onRowSelect!(row);
                                        }
                                      },
                                      onSecondaryTapDown: (details){
                                        showMenu(
                                          context: context,
                                          position: RelativeRect.fromLTRB(
                                            details.globalPosition.dx,
                                            details.globalPosition.dy,
                                            details.globalPosition.dx,
                                            details.globalPosition.dy,
                                          ),
                                          items: widget.popupActions?.map((action) {
                                            return PopupMenuItem(
                                              child: Text(action.label),
                                              onTap: () {
                                                Future.delayed(Duration.zero, () {
                                                  action.onTap?.call(row);
                                                });
                                              },
                                            );
                                          }).toList() ?? [],
                                        );
                                      },
                                      child: Container(
                                        color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                                        child: Row(
                                          children: [
                                            // Checkbox
                                            Container(
                                              width: checkboxColumnWidth,
                                              height: 52,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(color: Colors.grey.shade200),
                                                ),
                                              ),
                                              child: Checkbox(
                                                value: isSelected,
                                                onChanged: (val) {
                                                  setState(() {
                                                    if (val == true) {
                                                      selectedRows.add(row);
                                                    } else {
                                                      selectedRows.remove(row);
                                                    }
                                                  });
                                                },
                                                activeColor: Colors.blue.shade600,
                                                checkColor: Colors.white,
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              ),
                                            ),

                                            // Fixed Data Cells
                                            ...fixedHeaders.map((key) {
                                              final value = row[key] ?? '';
                                              return Container(
                                                width: fixedColumnWidth,
                                                height: 52,
                                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                alignment: Alignment.centerLeft,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide(color: Colors.grey.shade200),
                                                    // Vertical separator removed
                                                  ),
                                                ),
                                                child: Text(
                                                  value.toString(),
                                                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                        ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Scrollable Header
                                Row(
                                  children: scrollableHeaders.map((header) {
                                    bool isActions = header == 'Actions';
                                    return Container(
                                      width: isActions ? actionColumnWidth : scrollableColumnWidth,
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,

                                        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
                                      ),
                                      child: Text(
                                        header.toString(),
                                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                                      ),
                                    );
                                  }).toList(),
                                ),

                                // Scrollable Data
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: _verticalScrollController2,
                                    child: Column(
                                      children: currentRows.map((row) {
                                        bool isSelected = selectedRows.contains(row);

                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (isSelected) {
                                                selectedRows.remove(row);
                                              } else {
                                                selectedRows.add(row);
                                              }
                                            });
                                          },
                                          onDoubleTap: (){
                                            if (widget.onRowSelect != null) {
                                              widget.onRowSelect!(row);
                                            }
                                          },
                                          onSecondaryTapDown: (details){
                                            showMenu(
                                              context: context,
                                              position: RelativeRect.fromLTRB(
                                                details.globalPosition.dx,
                                                details.globalPosition.dy,
                                                details.globalPosition.dx,
                                                details.globalPosition.dy,
                                              ),
                                              items: widget.popupActions?.map((action) {
                                                return PopupMenuItem(
                                                  child: Text(action.label),
                                                  onTap: () {
                                                    Future.delayed(Duration.zero, () {
                                                      action.onTap?.call(row);
                                                    });
                                                  },
                                                );
                                              }).toList() ?? [],
                                            );
                                          },
                                          child: Container(
                                            color: isSelected ? Colors.blue.shade50 : Colors.transparent,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: scrollableHeaders.map((key) {
                                                final value = row[key] ?? '';
                                                bool isStatus = key == 'Status';
                                                bool isActions = key == 'Actions';

                                                Widget cellContent;
                                                double width = isActions ? actionColumnWidth : scrollableColumnWidth;

                                                if (isStatus) {
                                                  cellContent = _buildStatusChip(value.toString());
                                                } else if (isActions) {
                                                  cellContent = Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      _buildActionButton("View", Icons.visibility_outlined),
                                                      _buildActionButton("Edit", Icons.edit_outlined),
                                                      // More menu
                                                      Container(
                                                        margin: const EdgeInsets.only(left: 4),
                                                        child: Icon(Icons.more_vert, size: 20, color: Colors.grey.shade600),
                                                      ),
                                                    ],
                                                  );
                                                } else {
                                                  cellContent = Text(
                                                    value.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                                                  );
                                                }

                                                return Container(
                                                  width: width,
                                                  height: 52,
                                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                                  alignment: isActions ? Alignment.centerRight : Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(color: Colors.grey.shade200),
                                                        // Vertical separator removed
                                                      )),
                                                  child: cellContent,
                                                );
                                              }).toList(),
                                            ),
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

                  // Pagination Footer
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Rows per page selector and count text
                        Row(
                          children: [
                            Container(
                              height: 28,
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: DropdownButton<int>(
                                value: _rowsPerPage,
                                isDense: true,
                                underline: const SizedBox(),
                                style: const TextStyle(fontSize: 13, color: Colors.black87),
                                icon: const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.black54),
                                items: [10, 20, 50].map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text('$value', style: const TextStyle(fontSize: 13)),
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
                            ),
                            const SizedBox(width: 12),
                            // Gracefully handle 0 rows
                            Text(
                              totalRows == 0
                                  ? "Of 0 vehicles (0-0)"
                                  : "Of $totalRows vehicles (${startIndex + 1}-${endIndex})",
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            ),
                          ],
                        ),

                        // Previous/Next Buttons
                        Row(
                          children: [
                            TextButton(
                              onPressed: currentPage > 0 ? () => setState(() => currentPage--) : null,
                              style: TextButton.styleFrom(
                                foregroundColor: currentPage > 0 ? Colors.black87 : Colors.grey,
                                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                minimumSize: Size(60, 32),
                              ),
                              child: const Text("Previous"),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: currentPage < totalPages - 1
                                  ? () => setState(() => currentPage++)
                                  : null,
                              style: TextButton.styleFrom(
                                foregroundColor: currentPage < totalPages - 1 ? Colors.black87 : Colors.grey,
                                textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                minimumSize: Size(60, 32),
                              ),
                              child: const Text("Next"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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