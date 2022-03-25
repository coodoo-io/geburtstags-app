import 'package:flutter/material.dart';
import 'package:geburtstags_app/core/enum/view_state.dart';
import 'package:geburtstags_app/core/viewmodels/birthday.viewmodel.dart';
import 'package:geburtstags_app/ui/views/base.view.dart';
import 'package:geburtstags_app/ui/widgets/birthday_form.dart';
import 'package:intl/intl.dart';

class BirthdaysView extends StatelessWidget {
  const BirthdaysView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<BirthdayViewModel>(
      onModelReady: (model) => model.getBirthdayList(),
      builder: (BuildContext context, BirthdayViewModel model, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Geburtstage"),
          ),
          body: model.state == ViewState.busy
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: model.birthdays.length,
                  itemBuilder: (context, index) {
                    final birthday = model.birthdays[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        model.removeBirthday(birthday);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${birthday.name} gelöscht.")),
                        );
                      },
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/birthdays/detail', arguments: birthday);
                        },
                        title: Text(birthday.name),
                        trailing: Text(
                          DateFormat('dd.MM.yyyy').format(birthday.date),
                        ),
                      ),
                    );
                  },
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) {
                    return const BirthdayForm();
                  },
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
