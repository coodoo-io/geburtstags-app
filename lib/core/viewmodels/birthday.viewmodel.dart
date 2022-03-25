import 'package:geburtstags_app/core/enum/view_state.dart';
import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:geburtstags_app/core/repositories/birthday.repo.dart';
import 'package:geburtstags_app/core/viewmodels/base.viewmodel.dart';
import 'package:geburtstags_app/locator.dart';

class BirthdayViewModel extends BaseViewModel {
  final BirthdayRepo _repo = locator<BirthdayRepo>();

  List<List<Birthday>> birthdays get birthdays => _repo.fetchAll();
// birthdays: repoBirthdayList,
//         next5Birthdays: BirthdayUtil.calcNextFiveBirthdays(repoBirthdayList),
//         todaysBirthdays: BirthdayUtil.calcTodaysBirthdays(repoBirthdayList));

  Future<Birthday> addBirthday(Birthday birthday) async {
      setState(ViewState.Busy);
    await _repo.insert(birthday);
      setState(ViewState.Idle);
    return birthday;
  }

  Future<void> updateBirthday(Birthday oldData, Birthday newData) async {
    setState(ViewState.Busy);
    await _repo.update(oldData, newData);
    setState(ViewState.Idle);
  }

  Future<void> removeBirthday(Birthday birthday) async {
    setState(ViewState.Busy);
    await _repo.delete(birthday);
    setState(ViewState.Idle);
  }
}
