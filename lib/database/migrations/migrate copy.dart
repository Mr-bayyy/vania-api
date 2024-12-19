import 'dart:io';

import 'package:vania/vania.dart';
import 'customers.dart';
import 'orders.dart';
import 'vendors.dart';
import 'products.dart';
import 'orderitems.dart';
import 'productnotes.dart';
import 'users.dart';
import 'personal_access_tokens.dart';
import 'todos.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
		 await Customers().up();
    await Orders().up();

    await Vendors().up();
		 await Products().up();
		 await Orderitems().up();
		 await Productnotes().up();
		 await Users().up();
		 await PersonalAccessTokens().up();
		 await Todos().up();
	}

  dropTables() async {
		 await Todos().down();
		 await PersonalAccessTokens().down();
		 await Users().down();
		 await Productnotes().down();
		 await Orderitems().down();
		 await Products().down();
		 await Vendors().down();
    await Orders().down();
    await Customers().down();
	 }
}
