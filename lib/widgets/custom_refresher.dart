import 'package:alpha_tenders_mobile_app/models/Pagination.dart';
import 'package:alpha_tenders_mobile_app/widgets/custom_circular_loader.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomScroller extends StatefulWidget {
  final Function onRefresh;
  final Function onLoading;
  final Pagination pagination;
  final Widget child;

  CustomScroller({this.onRefresh, this.onLoading, this.pagination, this.child});

  @override
  _CustomScrollerState createState() => _CustomScrollerState();
}

class _CustomScrollerState extends State<CustomScroller> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    if (widget.onRefresh != null) await widget.onRefresh();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (widget.onLoading != null) await widget.onLoading();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoading != null,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      header: const WaterDropHeader(
        complete: Icon(Ionicons.checkmark),
        failed: Text('Failed to refresh. Try again.',
          style: TextStyle(color: Colors.red),
        ),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          if (widget.pagination != null) {
            if (widget.pagination.next.page == 0 && widget.pagination.next.limit == 0) {
              return const SizedBox(
                height: 55.0,
                child: Center(
                  child: Text('End of List',
                    style: TextStyle(color: Colors.black26),
                  ),
                ),
              );
            }
          }

          Widget body;

          if (mode == LoadStatus.idle) {
            body = const Text('Scroll up to keep loading', style: TextStyle(color: Colors.black26));
          } else if (mode == LoadStatus.loading) {
            body = const CustomCircularLoader();
          } else if (mode == LoadStatus.failed) {
            body = const Text('Loading Failed!');
          } else if (mode == LoadStatus.canLoading) {
            body = const Text('Release to load more');
          } else {
            body = const Text('-End of List-');
          }

          return SizedBox(
            height: 60.0,
            child: Center(child: body),
          );
        },
      ),
      child: widget.child,
    );
  }
}
