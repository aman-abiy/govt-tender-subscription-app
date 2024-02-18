import 'package:alpha_tenders_mobile_app/models/Meta.dart';

class PaginationHandler {

  static int pageNumber(Meta meta) {
    if(meta != null) {
      // when on last page
      if((meta.pagination.next.page == 0 && meta.pagination.next.limit == 0) && meta.pagination.prev != null) {
        // custom refresher will handle end of list
        // send page that is above length of items to get empty list at end of page
        return meta.total + 1;
      } else {
        return meta.pagination.next.page;
      }
    } else {
      return 1;
    }
  }
}