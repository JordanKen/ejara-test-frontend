import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:money/constants/colors.dart';
import 'package:money/constants/font_family.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  SearchBar({
    Key? key,
    @required this.onCancelSearch,
    @required this.onSearchQueryChanged,
  }) : super(key: key);

  final VoidCallback? onCancelSearch;
  final Function(String)? onSearchQueryChanged;

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> with SingleTickerProviderStateMixin {
  String searchQuery = '';
  TextEditingController _searchFieldController = TextEditingController();

  clearSearchQuery() {
    _searchFieldController.clear();
    widget.onSearchQueryChanged!('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: TextFormField(
          controller: _searchFieldController,
          cursorColor: AppColors.primarycolor,
          textAlignVertical: TextAlignVertical.center,
          style:TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.normal,
              fontFamily: FontFamily.latoRegular,
              color: AppColors.accentcolor,
              decoration: TextDecoration.none,
              fontSize: 15
          ),
          onChanged:(String? val){},
          validator:(String? val){},
          decoration: InputDecoration(
            filled: false,
            focusColor: Colors.white,
            hintText: 'Search...',
            hintStyle: TextStyle(
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontFamily: FontFamily.latoRegular,
                color: AppColors.accentcolor,
                fontSize: 14
            ),
            //fillColor: AppColors.backgroundlight,
            suffixIcon: IconButton(
              splashRadius: 20,
              icon: Icon(Icons.delete,
                color: AppColors.accentcolor,
              ),
              onPressed: () { clearSearchQuery();},
            ),
            prefixIcon: IconButton(
              splashRadius: 20,
              icon: Icon(Icons.arrow_back, color: AppColors.accentcolor,),
              onPressed: widget.onCancelSearch,
            ),
            contentPadding: EdgeInsets.only(top: 10,left: 15,bottom: 10),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            /*focusedBorder:OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primarycolor.withOpacity(0.5),width: 0.6)
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5),width: 0.6)
            ),*/
          ),
        ),
      ),
    );
  }
}
