import 'package:dropdown_flutter/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:meeti_success_in_every_word_201_t/m/color_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/moti_m.dart';
import 'package:meeti_success_in_every_word_201_t/m/sceen_prov.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/communication_styles_info.dart';
import 'package:meeti_success_in_every_word_201_t/m_scr/edit_profit_assessment.dart';
import 'package:provider/provider.dart';

class AddEditScenario extends StatefulWidget {
  final Scenrio? scenario;

  const AddEditScenario({super.key, this.scenario});

  @override
  State<AddEditScenario> createState() => _AddEditScenarioState();
}

class _AddEditScenarioState extends State<AddEditScenario> {
  final _frmKy = GlobalKey<FormState>();

  final TextEditingController _nmCntrlr = TextEditingController();
  final TextEditingController _dscrptnCntrlr = TextEditingController();
  final TextEditingController _evntGlCntrlr = TextEditingController();
  final TextEditingController _mntryGlCntrlr = TextEditingController();
  final TextEditingController _dtCntrlr = TextEditingController();
  final TextEditingController _tmCntrlr = TextEditingController();

  String? _bsnsSty;
  DateTime _slctdDt = DateTime.now();
  DateTime _slctdTm = DateTime.now();
  bool? _isRated;
  String? _assessmentText;
  String? _assessmentProfit;

  bool _sFrmVld = false;

  @override
  void initState() {
    super.initState();

    if (widget.scenario != null) {
      _nmCntrlr.text = widget.scenario!.nme;
      _dscrptnCntrlr.text = widget.scenario!.descrption;
      _evntGlCntrlr.text = widget.scenario!.evntGoal;
      _mntryGlCntrlr.text = widget.scenario!.mnetaryGoal;
      _bsnsSty = widget.scenario!.businesStyle;
      _slctdDt = widget.scenario!.slectedDate;
      _slctdTm = widget.scenario!.slectedTime;
      _isRated = widget.scenario!.isRated;
      _assessmentText = widget.scenario!.assessmentText;
      _assessmentProfit = widget.scenario!.assessmentProfit;

      _dtCntrlr.text = DateFormat('dd.MM.yyyy').format(_slctdDt);
      _tmCntrlr.text = DateFormat('HH:mm').format(_slctdTm);

      _chckFrmVldty();
    }

    _nmCntrlr.addListener(_chckFrmVldty);
    _dscrptnCntrlr.addListener(_chckFrmVldty);
    _evntGlCntrlr.addListener(_chckFrmVldty);
    _dtCntrlr.addListener(_chckFrmVldty);
    _tmCntrlr.addListener(_chckFrmVldty);
  }

  void _onRatingTap(bool value) async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfitAssessment(
          name: _nmCntrlr.text,
          currentRating: _isRated,
          initialImpressions: _assessmentText,
          initialProfit: _assessmentProfit,
        ),
      ),
    );

    if (result != null) {
      if (result['delete'] == true) {
        setState(() {
          _isRated = null;
          _assessmentText = null;
          _assessmentProfit = null;
        });
      } else {
        setState(() {
          _isRated = result['rating'];
          _assessmentText = result['impressions'];
          _assessmentProfit = result['profit'];
        });
      }
    }
  }

  @override
  void dispose() {
    _nmCntrlr.dispose();
    _dscrptnCntrlr.dispose();
    _evntGlCntrlr.dispose();
    _mntryGlCntrlr.dispose();
    _dtCntrlr.dispose();
    _tmCntrlr.dispose();
    super.dispose();
  }

  void _chckFrmVldty() {
    final sVld = _nmCntrlr.text.isNotEmpty &&
        _dscrptnCntrlr.text.isNotEmpty &&
        _evntGlCntrlr.text.isNotEmpty &&
        _dtCntrlr.text.isNotEmpty &&
        _tmCntrlr.text.isNotEmpty &&
        _bsnsSty != 'Select business style';

    if (sVld != _sFrmVld) {
      setState(() {
        _sFrmVld = sVld;
      });
    }
  }

  Future<void> _shwDtPckr() async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.r)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MMotiBut(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: ColorM.blue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  MMotiBut(
                    onPressed: () {
                      _dtCntrlr.text =
                          DateFormat('dd.MM.yyyy').format(_slctdDt);
                      Navigator.pop(context);
                      _chckFrmVldty();
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: ColorM.blue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _slctdDt,
                onDateTimeChanged: (DateTime nwDt) {
                  _slctdDt = nwDt;
                },
                dateOrder: DatePickerDateOrder.dmy,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _shwTmPckr() async {
    await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0.r)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MMotiBut(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: ColorM.blue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  MMotiBut(
                    onPressed: () {
                      _tmCntrlr.text = DateFormat('HH:mm').format(_slctdTm);
                      Navigator.pop(context);
                      _chckFrmVldty();
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: ColorM.blue,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 200.h,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: _slctdTm,
                onDateTimeChanged: (DateTime nwTm) {
                  _slctdTm = nwTm;
                },
                use24hFormat: true,
              ),
            ),
          ],
        );
      },
    );
  }

  DropdownFlutter _shwBsnsStylPckr() {
    final bsnsStls = [
      'Friendly style',
      'Neutral style',
      'Aggressive style',
    ];

    return DropdownFlutter<String>(
      closedHeaderPadding: REdgeInsets.all(16.r),
      expandedHeaderPadding: REdgeInsets.all(16.r),
      hintText: 'Select business style',
      hideSelectedFieldWhenExpanded: false,
      excludeSelected: false,
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Row(
          children: [
            Text(
              item,
              style: TextStyle(
                color: ColorM.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_on : Icons.radio_button_off,
              color: ColorM.blue,
            )
          ],
        );
      },
      decoration: CustomDropdownDecoration(
        listItemDecoration:
            ListItemDecoration(selectedColor: Colors.transparent),
        closedSuffixIcon: Icon(
          CupertinoIcons.chevron_down,
          color: ColorM.blue,
        ),
        expandedSuffixIcon: Icon(
          CupertinoIcons.chevron_up,
          color: ColorM.blue,
        ),
        closedFillColor: Color(0xFF252B30),
        expandedFillColor: Color(0xFF252B30),
        headerStyle: TextStyle(
          color: ColorM.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        listItemStyle: TextStyle(
          color: ColorM.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: TextStyle(
          color: ColorM.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
      items: bsnsStls,
      initialItem: _bsnsSty,
      onChanged: (value) {
        setState(() {
          _bsnsSty = value;
        });
      },
    );
  }

  void _svScnr() {
    if (!_sFrmVld) return;

    final prvdr = Provider.of<ScenrioProvaider>(context, listen: false);

    final isEdit = widget.scenario != null;

    final updatedScenrio = isEdit
        ? widget.scenario!.cpyWith(
            nme: _nmCntrlr.text,
            descrption: _dscrptnCntrlr.text,
            evntGoal: _evntGlCntrlr.text,
            mnetaryGoal:
                _mntryGlCntrlr.text.isEmpty ? '0' : _mntryGlCntrlr.text,
            businesStyle: _bsnsSty ?? 'Friendly style',
            slectedDate: _slctdDt,
            slectedTime: _slctdTm,
            isRated: _isRated,
            assessmentText: _assessmentText,
            assessmentProfit: _assessmentProfit,
          )
        : Scenrio(
            idd: DateTime.now().millisecondsSinceEpoch,
            nme: _nmCntrlr.text,
            descrption: _dscrptnCntrlr.text,
            evntGoal: _evntGlCntrlr.text,
            mnetaryGoal:
                _mntryGlCntrlr.text.isEmpty ? '0' : _mntryGlCntrlr.text,
            businesStyle: _bsnsSty ?? 'Friendly style',
            slectedDate: _slctdDt,
            slectedTime: _slctdTm,
            isRated: _isRated,
            assessmentText: _assessmentText,
            assessmentProfit: _assessmentProfit,
          );

    if (isEdit) {
      prvdr.updteScenrio(updatedScenrio);
    } else {
      prvdr.adScenrio(updatedScenrio);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorM.background,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: ColorM.background,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: ColorM.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            widget.scenario == null ? 'New scenario' : 'Edit scenario',
            style: TextStyle(
              color: ColorM.white,
              fontWeight: FontWeight.w500,
              fontSize: 20.sp,
            ),
          ),
          actions: [
            if (widget.scenario != null)
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: MMotiBut(
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text('Deleted your scenario?'),
                          content: const Text(
                              "You won't be able to recover your scenario"),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                final prvdr = Provider.of<ScenrioProvaider>(
                                    context,
                                    listen: false);
                                prvdr.dletScenrio(widget.scenario!.idd);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: SvgPicture.asset(
                    'assets/icons/dele.svg',
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: MMotiBut(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CommunicationStylesInfo(),
                    ),
                  );
                },
                child: SvgPicture.asset(
                  'assets/icons/info.svg',
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Form(
              key: _frmKy,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bldTxtFld(
                    controller: _nmCntrlr,
                    hintText: 'Name',
                    maxLength: 31,
                  ),
                  SizedBox(height: 16.h),
                  _bldTxtFld(
                    controller: _dscrptnCntrlr,
                    hintText: 'Description of event',
                    maxLength: 160,
                  ),
                  SizedBox(height: 16.h),
                  _bldTxtFld(
                    controller: _evntGlCntrlr,
                    hintText: 'Event goal',
                    maxLength: 35,
                  ),
                  SizedBox(height: 16.h),
                  _bldTxtFld(
                    controller: _mntryGlCntrlr,
                    hintText: 'Monetary goal',
                    keyboardType: TextInputType.number,
                    isRequired: false,
                  ),
                  SizedBox(height: 16.h),
                  _shwBsnsStylPckr(),
                  SizedBox(height: 16.h),
                  _bldTxtFld(
                    controller: _dtCntrlr,
                    hintText: 'Select date',
                    onTap: _shwDtPckr,
                  ),
                  SizedBox(height: 16.h),
                  _bldTxtFld(
                    controller: _tmCntrlr,
                    hintText: 'Select time',
                    onTap: _shwTmPckr,
                  ),
                  if (widget.scenario != null) ...[
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF252B30),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How did your negotiations go?',
                            style: TextStyle(
                              color: ColorM.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _onRatingTap(true),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: _isRated == true
                                          ? ColorM.blue.withOpacity(0.2)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: _isRated == true
                                            ? ColorM.blue
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          color: _isRated == true
                                              ? ColorM.blue
                                              : ColorM.white.withOpacity(0.7),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          'Good',
                                          style: TextStyle(
                                            color: _isRated == true
                                                ? ColorM.blue
                                                : ColorM.white.withOpacity(0.7),
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _onRatingTap(false),
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: _isRated == false
                                          ? Colors.red.withOpacity(0.2)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: _isRated == false
                                            ? Colors.red
                                            : Colors.transparent,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.thumb_down,
                                          color: _isRated == false
                                              ? Colors.red
                                              : ColorM.white.withOpacity(0.7),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          'Bad',
                                          style: TextStyle(
                                            color: _isRated == false
                                                ? Colors.red
                                                : ColorM.white.withOpacity(0.7),
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: 32.h),
                  _bldSvBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bldTxtFld({
    required TextEditingController controller,
    required String hintText,
    int maxLength = 100,
    TextInputType keyboardType = TextInputType.text,
    bool isRequired = true,
    Function()? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF252B30),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextFormField(
        readOnly: onTap != null,
        onTap: onTap,
        controller: controller,
        maxLength: maxLength,
        maxLines: null,
        keyboardType: keyboardType,
        style: TextStyle(
          color: ColorM.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: onTap != null
              ? Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: Icon(
                    Icons.chevron_right,
                    color: ColorM.blue,
                    size: 24.sp,
                  ),
                )
              : null,
          hintText: hintText,
          hintStyle: TextStyle(
            color:
                onTap != null ? ColorM.white : ColorM.white.withOpacity(0.53),
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          counterText: '',
          contentPadding: EdgeInsets.all(16.r),
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _bldSvBtn() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _sFrmVld ? _svScnr : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorM.blue,
          disabledBackgroundColor: ColorM.blue.withOpacity(0.5),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Save',
          style: TextStyle(
            color: ColorM.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
