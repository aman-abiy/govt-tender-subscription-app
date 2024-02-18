import 'package:alpha_tenders_mobile_app/models/Tender.dart';
import 'package:alpha_tenders_mobile_app/style/hex_color.dart';
import 'package:alpha_tenders_mobile_app/style/text_theme.dart';
import 'package:alpha_tenders_mobile_app/utils/date_parser.dart';
import 'package:alpha_tenders_mobile_app/utils/routes.dart';
import 'package:alpha_tenders_mobile_app/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class TenderCard extends StatefulWidget {
  final Tender tender;
  
  const TenderCard(this.tender, {Key key}) : super(key: key);

  @override
  State<TenderCard> createState() => _TenderCardState();
}

class _TenderCardState extends State<TenderCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.TENDER_DETAIL, arguments: widget.tender);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          border: Border.all(color: HexColor('#e6e4e1'))
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.tender.title,
                    style: textTheme.headline3,
                    textAlign: TextAlign.left,
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Flexible(
                        child: Text('Opening Date:  ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle1,
                        ),
                      ),
                      Flexible(
                        child: Text(widget.tender.bidOpeningDateText ?? DateParser.getDate(widget.tender.bidOpeningDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle2,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Flexible(
                        child: Text('Closing Date:  ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle1,
                        ),
                      ),
                      Flexible(
                        child: Text(widget.tender.bidClosingDateText ?? DateParser.getDate(widget.tender.bidClosingDate),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle2,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Row(
                    children: [
                      Flexible(
                        child: Text('Published On:  ',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle1,
                        ),
                      ),
                      Expanded(
                        child: Text('${widget.tender.tenderSources[0].name.en} (${DateParser.getDate(widget.tender.createdAt)})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.subtitle2,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                  color: HexColor('#f5f4f2'),
                  border: Border.all(color: HexColor('#e6e4e1'))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Status:  ', 
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: HexColor('#6c757d'),
                            fontSize: 13,
                            letterSpacing: 0.4
                          ),
                        ),
                        StatusChip(widget.tender.bidClosingDate)
                      ],
                    ),
                    Text(timeago.format(DateTime.fromMillisecondsSinceEpoch(widget.tender.createdAt)), 
                      style: TextStyle(
                        color: HexColor('#6c757d'),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}