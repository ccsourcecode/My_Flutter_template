import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:my_template/core/constants/images.dart';
import 'package:my_template/core/utils/theme_utils.dart';
import 'package:my_template/core/widgets/state_layout_widget.dart';

/// 封裝下拉刷新與加載更多
class DeerListView extends StatefulWidget {
  const DeerListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.onRefresh,
    this.loadMore,
    this.hasMore = false,
    this.stateType = StateType.empty,
    this.pageSize = 10,
    this.padding,
    this.itemExtent,
  });

  final RefreshCallback onRefresh;
  final LoadMoreCallback? loadMore;
  final int itemCount;
  final bool hasMore;
  final IndexedWidgetBuilder itemBuilder;
  final StateType stateType;

  /// 一頁的數量，默認為10
  final int pageSize;

  /// padding屬性使用時注意會破壞原有的SafeArea，需要自行計算bottom大小
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;

  @override
  _DeerListViewState createState() => _DeerListViewState();
}

typedef RefreshCallback = Future<void> Function();
typedef LoadMoreCallback = Future<void> Function();

class _DeerListViewState extends State<DeerListView> {
  /// 是否正在加載數據
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Widget child = RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: widget.itemCount == 0
          ? StateLayout(type: widget.stateType)
          : ListView.builder(
              itemCount: widget.loadMore == null
                  ? widget.itemCount
                  : widget.itemCount + 1,
              padding: widget.padding,
              itemExtent: widget.itemExtent,
              itemBuilder: (BuildContext context, int index) {
                /// 不需要加載更多則不需要添加FootView
                if (widget.loadMore == null) {
                  return widget.itemBuilder(context, index);
                } else {
                  return index < widget.itemCount
                      ? widget.itemBuilder(context, index)
                      : MoreWidget(
                          widget.itemCount, widget.hasMore, widget.pageSize);
                }
              },
            ),
    );
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification note) {
          /// 確保是垂直方向滾動，且滑動至底部
          if (note.metrics.pixels == note.metrics.maxScrollExtent &&
              note.metrics.axis == Axis.vertical) {
            _loadMore();
          }
          return true;
        },
        child: child,
      ),
    );
  }

  Future<void> _loadMore() async {
    if (widget.loadMore == null) {
      return;
    }
    if (_isLoading) {
      return;
    }
    if (!widget.hasMore) {
      return;
    }
    _isLoading = true;
    await widget.loadMore?.call();
    _isLoading = false;
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget(this.itemCount, this.hasMore, this.pageSize, {super.key});

  final int itemCount;
  final bool hasMore;
  final int pageSize;

  @override
  Widget build(BuildContext context) {
    final TextStyle style = context.isDark
        ? TextStyles.textGray14
        : const TextStyle(color: Color(0x8A000000));
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (hasMore) const CupertinoActivityIndicator(),
          if (hasMore) Gaps.hGap5,

          /// 只有一頁的時候，就不顯示FooterView了
          Text(hasMore ? '正在加載中...' : (itemCount < pageSize ? '' : '沒有了呦~'),
              style: style),
        ],
      ),
    );
  }
}
