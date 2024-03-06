import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/constants/colors.dart';
import 'package:project/ui/reservations/movie_booking/presentation/widget/seat_widget.dart';
import 'package:project/ui/reservations/movie_booking/presentation/widget/date_widget.dart';
import 'package:project/ui/reservations/movie_booking/presentation/widget/time_widget.dart';
import 'package:project/services/date_time_extension.dart';



class MovieBookingScreen extends StatefulWidget {
  const MovieBookingScreen({super.key});

  @override
  State<MovieBookingScreen> createState() => _MovieBookingScreenState();
}

class _MovieBookingScreenState extends State<MovieBookingScreen> {
  final selectedSeat = ValueNotifier<List<String>>([]);
  final selectedDate = ValueNotifier<DateTime>(DateTime.now());
  final selectedTime = ValueNotifier<TimeOfDay?>(null);
  final CollectionReference bookingCollection = FirebaseFirestore.instance.collection('ticketBookings');

  List<String> bookedSeats = [];
  @override
  void initState() {
    super.initState();
    fetchBookedSeats();
  }
  Future<void> fetchBookedSeats() async {
    try {
      QuerySnapshot querySnapshot = await bookingCollection.get();
      List<String> allBookedSeats = [];
      querySnapshot.docs.forEach((doc) {
        List<dynamic> seats = doc.get('seats');
        allBookedSeats.addAll(seats.map((seat) => seat.toString()));
      });
      setState(() {
        bookedSeats = allBookedSeats;
      });
    } catch (e) {
      print('Error fetching booked seats: $e');
    }
  }
  void handleSeatSelection(String seat) {
    if (bookedSeats.contains(seat)) {
      // Seat is already booked, can't select it
      return;
    }
    // Toggle seat selection
    setState(() {
      if (selectedSeat.value.contains(seat)) {
        selectedSeat.value = List.from(selectedSeat.value)
          ..remove(seat);
      } else {
        selectedSeat.value = List.from(selectedSeat.value)
          ..add(seat);
      }
    });
  }

  Future<bool> bookTickets() async {
    try{
      List<String> selectedSeats = selectedSeat.value;
      DateTime selectedDate = this.selectedDate.value;
      TimeOfDay? selectedTime = this.selectedTime.value;
      int totalPrice = selectedSeats.length * 1000;

      bookingCollection
          .add({
        'seats': selectedSeats,
        'date': selectedDate,
        'time': selectedTime != null
            ? '${selectedTime.hour}:${selectedTime.minute}'
            : null,
        'totalPrice': totalPrice,
        'timestamp': Timestamp.now(),
        'isBooked': true,
      })
          .then((value) => print('Booking successful!'))
          .catchError((error) => print('Error booking tickets: $error'));
      return true;
    }
    catch(e){
      print('Error booking tickets: $e');
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Select Seat",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ValueListenableBuilder<List<String>>(
            valueListenable: selectedSeat,
            builder: (context, value, _) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      alignment: Alignment.center,
                      child: Text(
                        "Screen 1",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    const Expanded(child: SizedBox()),

                    /// 8 seat horizontal
                    /// and 5 seat vertical
                    for (int i = 1; i <= 5; i++) ...[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int j = 1; j <= 8; j++) ...[
                            SeatWidget(
                              seatNumber: "${String.fromCharCode(i + 64)}$j",
                              width: (MediaQuery.of(context).size.width -
                                      48 -
                                      66) /
                                  8,
                              height: (MediaQuery.of(context).size.width -
                                      48 -
                                      66) /
                                  8,
                              isAvailable: !bookedSeats.contains("${String.fromCharCode(i + 64)}$j"), // Check if the seat is not booked
                              isSelected: value.contains(
                                "${String.fromCharCode(i + 64)}$j",
                              ),
                              isBooked: bookedSeats.contains("${String.fromCharCode(i + 64)}$j"), // Pass if the seat is booked
                              onTap: () {
                                handleSeatSelection("${String.fromCharCode(i + 64)}$j");
                              },
                            ),
                            // make gap, and in the center wider gap
                            if (i != 8) SizedBox(width: j == 4 ? 16 : 4)
                          ]
                        ],
                      ),
                      if (i != 5) const SizedBox(height: 6)
                    ],
                    const Expanded(child: SizedBox()),
                    const SeatInfoWidget(),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(48),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Date",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width /2.7,),
                      ValueListenableBuilder<DateTime>(
                        valueListenable: selectedDate,
                        builder: (context, value, _) {
                          return
                              SizedBox(
                                height: 96,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: List.generate(
                                    1,
                                    (index) {
                                      final date = DateTime.now().add(
                                        Duration(days: index),
                                      );
                                      return InkWell(
                                        onTap: () {
                                          selectedDate.value = date;
                                        },
                                        child: DateWidget(
                                          date: date,
                                          isSelected:
                                              value.simpleDate == date.simpleDate,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                  ValueListenableBuilder<TimeOfDay?>(
                    valueListenable: selectedTime,
                    builder: (context, value, _) {
                          //SizedBox(width: MediaQuery.of(context).size.width /2,),
                          return Row(
                            children: [
                              SizedBox(width: MediaQuery.of(context).size.width /2.77),
                              SizedBox(
                                      height: 48,
                                      width: MediaQuery.of(context).size.width,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                          1,
                                          (index) {
                                            final time = TimeOfDay(
                                              hour: 12 + (index * 2),
                                              minute: 0,
                                            );
                                            return InkWell(
                                              onTap: () {
                                                selectedTime.value = time;
                                              },
                                              child: TimeWidget(
                                                time: time,
                                                isSelected: value == time,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ),
                            ],
                          );
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Price",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 16),
                            ValueListenableBuilder<List<String>>(
                              valueListenable: selectedSeat,
                              builder: (context, value, _) {
                                return Text(
                                  "\PKR ${value.length * 1000}",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            if (selectedSeat.value.isEmpty ||
                                selectedDate.value == null ||
                                selectedTime.value == null) {
                              // Show snackbar for validation error
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'Please select seat, date, and time.',
                                  contentType: ContentType.failure,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                              return; // Stop further execution
                            }

                            try {
                              bookTickets().then((result) {
                                if (result) {
                                  // Show snackbar on successful booking
                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'Success',
                                      message: 'Tickets booked successfully!',
                                      contentType: ContentType.success,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);

                                  // Pop back to the homepage after successful booking
                                  Navigator.pop(context);
                                } else {
                                  // Show snackbar for failure
                                  final snackBar = SnackBar(
                                    elevation: 0,
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    content: AwesomeSnackbarContent(
                                      title: 'On Snap!',
                                      message: 'Sorry, booking failed! Please try again.',
                                      contentType: ContentType.failure,
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(snackBar);
                                }
                              });
                            } catch (e) {
                              // Show snackbar for any exceptions
                              final snackBar = SnackBar(
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.transparent,
                                content: AwesomeSnackbarContent(
                                  title: 'Error',
                                  message: 'An error occurred. Please try again later.',
                                  contentType: ContentType.failure,
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(32),
                            ),
                            padding: const EdgeInsets.all(16),
                            alignment: Alignment.center,
                            child: Text(
                              "Book Now",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),



                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }

}
