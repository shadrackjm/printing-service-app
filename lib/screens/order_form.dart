import 'package:flutter/material.dart';
import 'package:print_services_app/components/my_button.dart';
import 'package:print_services_app/constant.dart';
import 'package:print_services_app/models/api_response.dart';
import 'package:print_services_app/models/services.dart';
import 'package:print_services_app/services/order_service.dart';

class OrderForm extends StatelessWidget {
  OrderForm({super.key, required this.services});
  final ServiceProvided services;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController copiesController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final bool loading = false;

  void _createOrder() async {
    ApiResponse response = await makeOrder();

    if (response.error == null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text(
          services.serviceName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    services.serviceDescription,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: idController,
                    decoration: kinputDecoration('${services.id}'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: copiesController,
                    validator: (val) => val!.isEmpty ? 'Required' : null,
                    // onchange
                    onChanged: (value) {
                      int result = int.parse(value); //change into an integer
                      int amount = services.price;
                      int newresult = result * amount;
                      amountController.text =
                          newresult.toString(); // change again to string
                    },
                    decoration: kinputDecoration('Number of Copies'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: amountController,
                    decoration: kinputDecoration('${services.price}'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          // send data to the service
                          _createOrder();
                        }
                      },
                      label: 'Pay'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
