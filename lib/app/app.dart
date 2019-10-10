import 'package:flutter/material.dart';
import 'package:my_wallet/app/user/user.dart';
import 'package:my_wallet/app/wallet/wallet.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int page = 0;
  PageController _pageController = PageController(initialPage: 0);

  changePage(int index) {
    this.setState(() {
      this.page = index;
    });
    this._pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.decelerate);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: PageView(
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Wallet(),
          User(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Container(
          height: 55.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  this.changePage(0);
                },
                child: Container(
                  width: size.width / 2 - 35,
                  child: IconButton(
                    icon: Icon(Icons.account_balance_wallet, size: 26.0),
                    onPressed: null,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  this.changePage(1);
                },
                child: Container(
                  width: size.width / 2 - 35,
                  child: IconButton(
                    icon: Icon(Icons.person_outline, size: 26.0),
                    onPressed: null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
        disabledElevation: 2.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}