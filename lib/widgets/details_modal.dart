import 'package:alpha_tenders_mobile_app/models/Category.dart';
import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/style/button_style.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/date_parser.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailsModal {

  final Tender tender;

  DetailsModal(this.tender);

  showDetailsModal(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Divider(),
                  Text(tender.title,
                    style: TextStyle(
                      fontSize: 17, 
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Text('Opening Date:  ',
                        style: textTheme.subtitle1,
                      ),
                      Flexible(
                        child: Container(
                          child: Text(tender.bidOpeningDateText ?? DateParser.getDate(tender.bidOpeningDate),
                            style: textTheme.subtitle2,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text('Closing Date:  ',
                        style: textTheme.subtitle1,
                      ),
                      Flexible(
                        child: Container(
                          child: Text(tender.bidClosingDateText ?? DateParser.getDate(tender.bidClosingDate),
                            style: textTheme.subtitle2,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text('Published On:  ',
                        style: textTheme.subtitle1,
                      ),
                      Text('${tender.tenderSources[0].name.en} (${DateParser.getDate(tender.createdAt)})',
                        style: textTheme.subtitle2,
                      )
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text('Posted:  ',
                        style: textTheme.subtitle1,
                      ),
                      Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(tender.createdAt)),
                        style: textTheme.subtitle2,
                      )
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text('Bid Bond:  ',
                        style: textTheme.subtitle1,
                      ),
                      Text(tender.bidBond ?? '-',
                        style: textTheme.subtitle2,
                      )
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Text('Region:  ',
                        style: textTheme.subtitle1,
                      ),
                      Text(tender.region.name.en,
                        style: textTheme.subtitle2,
                      )
                    ],
                  ),
                  // const SizedBox(height: 10),
                  const Divider(),
                  categoriesBuilder(tender.categories),
                  const Divider(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      child: const Text('Close',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: buttonStyle('#1c2e59'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget categoriesBuilder(List<Category> categories) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Icon(Icons.folder_rounded,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(categories[index].name.en,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textTheme.subtitle2,
              ),
            )
          ],
        );
      }
    );
  }
}