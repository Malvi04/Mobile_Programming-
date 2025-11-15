import '../models/book_model.dart';

class BookController {
  List<BookLoan> loans = [];

  void addLoan(String name, String bookTitle, DateTime loanDate) {
    loans.add(BookLoan(
      name: name,
      bookTitle: bookTitle,
      loanDate: loanDate,
    ));
  }
}