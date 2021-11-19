import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:innenu/utils/utils.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

part 'phone.g.dart';

final _logger = Logger('component.phone');

@JsonSerializable()
class PhoneComponent extends StatelessWidget {
  const PhoneComponent(
    this.phoneNumber,
    this.givenName, {
    this.familyName = '',
    this.displayName = '',
    this.homeNumber = '',
    this.hostNumber = '',
    this.workNumber = '',
    this.company = '',
    this.note = '',
    this.region = '',
    this.city = '',
    this.street = '',
    this.postcode = '',
    this.jobTitle = '',
    this.email = '',
  });

  factory PhoneComponent.fromJson(Map<String, dynamic> json) =>
      _$PhoneComponentFromJson(json);

  /// 号码
  @JsonKey(defaultValue: '', name: 'num')
  final String phoneNumber;

  /// 名字
  @JsonKey(name: 'fName')
  final String givenName;

  /// 姓氏
  @JsonKey(defaultValue: '', name: 'lName')
  final String familyName;

  /// 工作电话
  @JsonKey(defaultValue: '', name: 'workNum')
  final String workNumber;

  /// 公司电话
  @JsonKey(defaultValue: '', name: 'hostNum')
  final String hostNumber;

  /// 住宅电话
  @JsonKey(defaultValue: '', name: 'homeNum')
  final String homeNumber;

  /// 公司
  @JsonKey(defaultValue: '', name: 'org')
  final String company;

  /// 备注
  @JsonKey(defaultValue: '', name: 'remark')
  final String note;

  /// 昵称
  @JsonKey(defaultValue: '', name: 'nickName')
  final String displayName;

  /// 省份
  @JsonKey(defaultValue: '', name: 'province')
  final String region;

  /// 城市
  @JsonKey(defaultValue: '')
  final String city;

  /// 城市
  @JsonKey(defaultValue: '')
  final String street;

  /// 城市
  @JsonKey(defaultValue: '', name: 'postCode')
  final String postcode;

  /// 城市
  @JsonKey(defaultValue: '', name: 'title')
  final String jobTitle;

  /// 电子邮件
  @JsonKey(defaultValue: '', name: 'email')
  final String email;

  Map<String, dynamic> toJson() => _$PhoneComponentToJson(this);

  /// 拨打电话
  void _makePhoneCall() {
    final url = 'tel:$phoneNumber';

    launcher.canLaunch(url).then((canLaunch) {
      if (canLaunch) {
        launcher.launch(url);
      } else {
        _logger.warning('Phone: can not make phone call');
      }
    });
  }

  /// 添加联系人
  void _addContact(BuildContext context) {
    UI.modal<void>(
      context,
      content: '是否要添加联系人$familyName$givenName?',
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            checkAndAskPermission(context, 'contact').then((success) {
              if (success) {
                // Insert new contact
                final newContact = Contact()
                  ..name.first = givenName
                  ..phones = [
                    Phone(phoneNumber, label: PhoneLabel.main),
                    if (homeNumber.isNotEmpty)
                      Phone(homeNumber, label: PhoneLabel.home),
                    if (workNumber.isNotEmpty)
                      Phone(workNumber, label: PhoneLabel.work),
                    if (hostNumber.isNotEmpty)
                      Phone(hostNumber, label: PhoneLabel.companyMain),
                  ];
                ;

                if (displayName.isNotEmpty) {
                  newContact.displayName = displayName;
                }

                if (familyName.isNotEmpty) {
                  newContact.name.last = familyName;
                }

                if (company.isNotEmpty || jobTitle.isNotEmpty) {
                  newContact.organizations = [
                    Organization(company: company, title: jobTitle)
                  ];
                }

                if (email.isNotEmpty) {
                  newContact.emails = [Email(email)];
                }

                if (note.isNotEmpty) {
                  newContact.notes = [Note(note)];
                }

                if (region.isNotEmpty ||
                    city.isNotEmpty ||
                    street.isNotEmpty ||
                    postcode.isNotEmpty) {
                  newContact.addresses = [
                    Address(
                      '',
                      state: region,
                      city: city,
                      street: street,
                      postalCode: postcode,
                    )
                  ];
                }

                newContact.insert().then((contact) {
                  Navigator.pop(context);
                  UI.tip(context, content: '添加联系人成功');
                });
              } else {
                UI.tip(context, content: '授权失败');
              }
            });
          },
          child: const Text('确定'),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.phone),
            ),
            Expanded(
              child: Text(
                phoneNumber.toString(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: _makePhoneCall,
            ),
            IconButton(
                icon: const Icon(Icons.contact_phone),
                onPressed: () {
                  _addContact(context);
                }),
          ],
        ),
      );
}
