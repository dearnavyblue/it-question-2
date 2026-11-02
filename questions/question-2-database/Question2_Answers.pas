// Name and Surname / Exam number: ____________   <- ALWAYS line 1!
//   (DBE rule: your name or exam number must be a comment on the
//   first line of every unit you code.)
// =====================================================================
// QUESTION 2 - DATABASE MANIPULATION : ANSWERS
// =====================================================================
// How to use this file:
//   Copy each procedure into the Question 2 unit (the form frmQ2).
//   Make sure the "uses" clause at the top of the unit has DateUtils
//   in it. Question 2.5 needs it for MonthOf.
//
// Tips that work for every database question:
//   * A table is like a list of rows. Each row is one "record".
//   * tblInvoices.First  = jump to the first row.
//   * tblInvoices.Next   = move down one row.
//   * tblInvoices.Eof    = "End Of File". It becomes True when we
//                          have gone past the last row.
//   * tblInvoices['NumberOrdered'] = read the value in that column
//                                    for the row we are on now.
//   * .FieldByName('X').AsString   = read column X as text, which is
//                                    handy when we want to show it.
//   * EXAM RULE: Do NOT use Locate, Filter or Sort on the table.
//     You must search with your own loop (First / Next / Eof), like
//     the answers below do.
//   * EXAM RULE: Your code must work with ANY data, not just the
//     example rows. Never type in answers like "75%". Let the loop
//     work them out.
//   * EXAM RULE: Answer only what is asked. Extra checks and messages
//     that the question did not ask for get no marks.
// =====================================================================


// =====================================================================
// 2.1 - Add Record                                           (3 marks)
// Goal: put one new row into tblInvoices.
// =====================================================================
procedure TfrmQ2.btnQ2_1Click(Sender: TObject);
begin
  // Step 1: Make a new, empty row at the end of the table.
  tblInvoices.Append;

  // Step 2: Fill in each box (field) of the new row.
  tblInvoices['InvoiceID'] := 105;
  tblInvoices['CustomerID'] := 5;
  tblInvoices['NumberOrdered'] := 10;
  tblInvoices['NumberDelivered'] := 10;
  tblInvoices['OnlineTransaction'] := True;

  // Step 3: Save the row. If you forget Post, nothing is saved!
  tblInvoices.Post;

  // The question does not ask for a message, so we do not add one.
  // (Extra things that were not asked for get no marks.)
end;


// =====================================================================
// 2.2 - Errors in Delivery                                   (7 marks)
// Goal: find every invoice where we did NOT deliver everything that was
// ordered, and show how many items are missing.
// =====================================================================
procedure TfrmQ2.btnQ2_2Click(Sender: TObject);
var
  iMissing: Integer; // how many items did not arrive
begin
  redQ2.Clear; // start with a clean output box

  // Step 1: Go to the first row.
  tblInvoices.First;

  // Step 2: Look at every row, one by one, until the end.
  while not tblInvoices.Eof do
  begin
    // Step 3: Check if "ordered" and "delivered" are different.
    if tblInvoices['NumberOrdered'] <> tblInvoices['NumberDelivered'] then
    begin
      // Step 4: Missing = what they ordered - what they got.
      iMissing := tblInvoices['NumberOrdered'] - tblInvoices['NumberDelivered'];

      // Step 5: Show the invoice number and the missing items.
      redQ2.Lines.Add('Invoice ID: ' + tblInvoices.FieldByName('InvoiceID').AsString
        + #9 + 'Items missing: ' + IntToStr(iMissing));
      // (#9 is a TAB. It lines up the output in neat columns.)
    end;

    // Step 6: Move to the next row. If you forget this, the loop
    // never ends!
    tblInvoices.Next;
  end;
end;


// =====================================================================
// 2.3 - Items in Cart
// Goal: ask for a Customer ID. If that customer has NO invoice, then
// they have not cleared their cart, so warn them.
// Idea: we search the invoices for the ID. If we never find it, the
// cart was not cleared.
// =====================================================================
procedure TfrmQ2.btnQ2_3Click(Sender: TObject);
var
  iCustomerID: Integer; // the ID the user types in
  bFound: Boolean;      // True once we find an invoice for this ID
begin
  // Step 1: Ask the user for the ID. InputBox gives back text, so
  // StrToInt changes the text into a number.
  iCustomerID := StrToInt(InputBox('Items in Cart', 'Enter the Customer ID:', ''));

  // Step 2: Get ready to search. We have not found anything yet.
  bFound := False;
  tblInvoices.First;

  // Step 3: Search row by row. Stop early once we find it, because
  // there is no need to keep looking.
  while (not tblInvoices.Eof) and (not bFound) do
  begin
    if tblInvoices['CustomerID'] = iCustomerID then
      bFound := True
    else
      tblInvoices.Next;
  end;

  // Step 4: No invoice found means the cart is not cleared, so we
  // show a WARNING box (the yellow triangle).
  // If we did find an invoice, we show nothing at all.
  if not bFound then
    MessageDlg('You have not cleared your cart', mtWarning, [mbOK], 0);
end;


// =====================================================================
// 2.4 - Online Transactions
// Goal: count how many invoices were online and how many were in the
// store, then show each one as a percentage.
// Percentage = (part / total) * 100
// =====================================================================
procedure TfrmQ2.btnQ2_4Click(Sender: TObject);
var
  iOnline, iInStore, iTotal: Integer; // counters
  rOnlinePercent, rInStorePercent: Real;    // the percentages
begin
  redQ2.Clear;

  // Step 1: Counters always start at 0.
  iOnline := 0;
  iInStore := 0;

  // Step 2: Go through every row and add 1 to the right counter.
  tblInvoices.First;
  while not tblInvoices.Eof do
  begin
    if tblInvoices['OnlineTransaction'] = True then
      Inc(iOnline)   // Inc means "add 1"
    else
      Inc(iInStore);

    tblInvoices.Next;
  end;

  // Step 3: Work out the total.
  iTotal := iOnline + iInStore;

  // Step 4: We can never divide by 0, so check there are rows first.
  // (This check was not asked for, so it earns no marks. We keep it
  // because without it the program crashes when the table is empty.)
  if iTotal > 0 then
  begin
    rOnlinePercent := iOnline / iTotal * 100;
    rInStorePercent := iInStore / iTotal * 100;

    // Step 5: Show the answer. FloatToStrF(..., ffFixed, 5, 0) turns
    // the number into text with 0 decimal places, e.g. 75.
    redQ2.Lines.Add('Percentage of Online Transactions vs In Store Transactions');
    redQ2.Lines.Add('Online:' + FloatToStrF(rOnlinePercent, ffFixed, 5, 0) + '%');
    redQ2.Lines.Add('In Store:' + FloatToStrF(rInStorePercent, ffFixed, 5, 0) + '%');
  end
  else
    redQ2.Lines.Add('There are no transactions yet');
end;


// =====================================================================
// 2.5 - September Transactions
// Goal: ask for a customer's name. If they exist, show all their
// invoices from September. If they do not exist, ask again.
// This uses TWO tables:
//   1. tblCustomers : turn the NAME into a CustomerID.
//   2. tblInvoices  : use that CustomerID to find their invoices.
//      (The CustomerID is the "link" between the two tables.)
// =====================================================================
procedure TfrmQ2.btnQ2_5Click(Sender: TObject);
var
  sName: String;          // the name the user types
  sOnline: String;        // "Yes" or "No" for showing online
  iCustomerID: Integer;   // the ID of the customer we found
  bFound: Boolean;        // did we find the customer?
  bHasSeptember: Boolean; // did we find any September invoice?
begin
  redQ2.Clear;
  bFound := False;
  iCustomerID := 0;

  // PART A: Find the customer. Keep asking until we find them.
  // If the user presses Cancel, sName is empty and we stop asking.
  repeat
    sName := Trim(InputBox('September Transactions',
      'Enter the customer''s first name:', ''));
    // (Two single quotes '' inside text make one ' on the screen.)

    if sName <> '' then
    begin
      tblCustomers.First;
      while (not tblCustomers.Eof) and (not bFound) do
      begin
        // UpperCase on both sides means "jenny" and "Jenny" match.
        if UpperCase(tblCustomers['FirstName']) = UpperCase(sName) then
        begin
          bFound := True;
          iCustomerID := tblCustomers['CustomerID']; // remember the ID
        end
        else
          tblCustomers.Next;
      end;

      if not bFound then
        ShowMessage('Account Not Found! Search Again');
    end;
  until bFound or (sName = '');

  // PART B: Show this customer's September invoices.
  if bFound then
  begin
    bHasSeptember := False;

    tblInvoices.First;
    while not tblInvoices.Eof do
    begin
      // Two things must be true:
      //   1. The invoice belongs to our customer.
      //   2. The month of the date is 9 (September).
      //      MonthOf takes a date and gives back the month number.
      if (tblInvoices['CustomerID'] = iCustomerID) and
        (MonthOf(tblInvoices['DateofTransaction']) = 9) then
      begin
        bHasSeptember := True;

        // OnlineTransaction is True or False. Change it to Yes or No
        // so it is easy for people to read.
        if tblInvoices['OnlineTransaction'] = True then
          sOnline := 'Yes'
        else
          sOnline := 'No';

        redQ2.Lines.Add('Invoice ID:' + tblInvoices.FieldByName('InvoiceID').AsString);
        redQ2.Lines.Add('Customer ID:' + tblInvoices.FieldByName('CustomerID').AsString);
        redQ2.Lines.Add('Number Ordered:' + tblInvoices.FieldByName('NumberOrdered').AsString);
        redQ2.Lines.Add('Number Delivered:' + tblInvoices.FieldByName('NumberDelivered').AsString);
        redQ2.Lines.Add('Online Transaction: ' + sOnline);
        // FormatDateTime shows the date the way we want: 2024/09/04
        redQ2.Lines.Add('Date of Transaction:' +
          FormatDateTime('yyyy/mm/dd', tblInvoices['DateofTransaction']));
        redQ2.Lines.Add(''); // empty line between invoices
      end;

      tblInvoices.Next;
    end;

    // If we went through every row and found nothing, say so.
    if not bHasSeptember then
      redQ2.Lines.Add('No Transactions For September');
  end;
end;


// =====================================================================
// 2.6 - Gender Stats                                        (10 marks)
// Goal: count how many customers are male and how many are female.
// How? A South African ID number hides the gender inside it:
//
//     9 8 0 5 1 2 | 0 3 2 6 | 0 8 5
//     Y Y M M D D | S S S S | ...
//     birthday    | gender  |
//      (1 to 6)   | (7 to 10)
//
//   SSSS from 0000 to 4999 = female
//   SSSS from 5000 to 9999 = male
// =====================================================================
procedure TfrmQ2.btnQ2_6Click(Sender: TObject);
var
  sIDNumber: String;  // the whole ID number, e.g. '9805120326085'
  iGender: Integer;   // the 4 gender digits as a number, e.g. 326
  iMales: Integer;    // counter for males
  iFemales: Integer;  // counter for females
begin
  redQ2.Clear;

  // Step 1: Counters always start at 0.
  iMales := 0;
  iFemales := 0;

  // Step 2: Look at every customer, one by one.
  tblCustomers.First;
  while not tblCustomers.Eof do
  begin
    // Step 3: Read this customer's ID number. It is stored as text.
    sIDNumber := tblCustomers['IDNumber'];

    // Step 4: Cut out the 4 gender digits.
    // Copy(text, start, how many) means: start at letter 7 and
    // take 4 letters. '9805120326085' gives '0326'.
    // StrToInt turns '0326' into the number 326 so we can compare it.
    iGender := StrToInt(Copy(sIDNumber, 7, 4));

    // Step 5: Below 5000 is female. 5000 and up is male.
    if iGender < 5000 then
      Inc(iFemales)
    else
      Inc(iMales);

    // Step 6: Go to the next customer. Do not forget this line!
    tblCustomers.Next;
  end;

  // Step 7: Show the answer exactly like the example output.
  redQ2.Lines.Add('Number of Males=' + IntToStr(iMales));
  redQ2.Lines.Add('Number of Females=' + IntToStr(iFemales));
end;
