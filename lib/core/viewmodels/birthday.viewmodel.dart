import 'package:geburtstags_app/core/enum/view_state.dart';
import 'package:geburtstags_app/core/models/birthday.model.dart';
import 'package:geburtstags_app/core/repositories/birthday.repo.dart';
import 'package:geburtstags_app/core/viewmodels/base.viewmodel.dart';
import 'package:geburtstags_app/locator.dart';

class BirthdayViewModel extends BaseViewModel {
  final BirthdayRepo _repo = locator<BirthdayRepo>();

  Future<Birthday> getBirthdayList(Birthday birthday) async {
      setState(ViewState.busy);
    await _repo.getAll();
      setState(ViewState.idle);
    return birthday;
  }

  Future<Birthday> addBirthday(Birthday birthday) async {
      setState(ViewState.busy);
    await _repo.insert(birthday);
      setState(ViewState.idle);
    return birthday;
  }

  Future<void> updateBirthday(Birthday oldData, Birthday newData) async {
    setState(ViewState.busy);
    await _repo.update(oldData, newData);
    setState(ViewState.idle);
  }

  Future<void> removeBirthday(Birthday birthday) async {
    setState(ViewState.busy);
    await _repo.delete(birthday);
    setState(ViewState.idle);
  }
}
