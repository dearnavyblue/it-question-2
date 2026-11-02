# Question 2 – Database Manipulation (context)

Transcribed from the question paper the user supplied on 2026-11-02, screenshots included.

## Tables

The paper's table description says `tblCustomer`, but the code must use `tblCustomers`.

**tblCustomers**

| Field | Data type | Description |
|---|---|---|
| CustomerID (PK) | AutoNumber | Unique identifier for each customer |
| FirstName | Short Text | Customer's first name |
| Surname | Short Text | Customer's surname |
| IDNumber | Short Text | Customer's identification number |

Sample records:

| CustomerID | FirstName | Surname | IDNumber |
|---|---|---|---|
| 1 | Kate | Willow | 9805120326085 |
| 2 | Jenny | Moss | 0102250323288 |

**tblInvoices**

| Field | Data type | Description |
|---|---|---|
| InvoiceID (PK) | Number | Unique identifier for each invoice record |
| CustomerID (FK) | Number | Customer responsible for the transaction |
| NumberOrdered | Number | Quantity of items ordered |
| NumberDelivered | Number | Quantity of the ordered items that was delivered |
| OnlineTransaction | Number in the description, but a Yes/No checkbox in the screenshot | Whether the transaction was done online |
| DateofTransaction | Date/Time | Date of the transaction |

Sample records:

| InvoiceID | CustomerID | NumberOrdered | NumberDelivered | OnlineTransaction | DateofTransaction |
|---|---|---|---|---|---|
| 101 | 2 | 5 | 5 | True | 2024/09/04 |
| 102 | 2 | 4 | 3 | True | 2024/09/05 |

Relationship: tblCustomers.CustomerID 1 → ∞ tblInvoices.CustomerID, with referential integrity enforced.

## Setup

- Connection code is provided. `tblCustomers` and `tblInvoices` are `TADOTable` objects that are already connected.
- The form is `frmQ2`. It has two grids, one per table, buttons `btnQ2_1` to `btnQ2_6`, and the rich edit `redQ2` for output.
- Buttons: 2.1 Add Record, 2.2 Errors in Delivery, 2.3 Items in Cart, 2.4 Online Transactions, 2.5 September Transactions, 2.6 Gender Stats.

## Sub-questions

**2.1 Add Record (3).** In `btnQ2_1` OnClick, add this record to tblInvoices: InvoiceID 105, CustomerID 5, NumberOrdered 10, NumberDelivered 10, OnlineTransaction True.

**2.2 Errors in Delivery (7).** In `btnQ2_2` OnClick:
- Go to the first record of tblInvoices.
- Find every record where NumberDelivered ≠ NumberOrdered.
- For each one, show the InvoiceID and the number of missing items in `redQ2`.
- The example output screenshot was not supplied.

**2.3 Items in Cart.** In `btnQ2_3` OnClick:
- Read a CustomerID from an input box.
- If that customer has no invoice, their cart is not cleared. Show a warning dialog in that case, e.g. "You have not cleared your cart" for customer 4. Use `MessageDlg(..., mtWarning, [mbOK], 0)`.
- Show nothing if the customer has an invoice.

**2.4 Online Transactions.** In `btnQ2_4` OnClick, work out the percentage of online and in-store transactions and show them in `redQ2`:

```
Percentage of Online Transactions vs In Store Transactions
Online:75%
In Store:25%
```

The paper's caption says "3 online and 2 in store for a total of 5", which would give 60% / 40%. That doesn't match the 75% / 25% shown, so the example output is internally inconsistent.

**2.5 September Transactions.** In `btnQ2_5` OnClick:
- Read a customer's **name** from an input box.
- Check that the customer exists. If not, show "Account Not Found! Search Again" and ask again.
- Show every invoice for that customer dated in **September** in `redQ2`, using this format:

```
Invoice ID:101
Customer ID:2
Number Ordered:5
Number Delivered:5
Online Transaction: No
Date of Transaction2024/09/04
<blank line between invoices>
```

- If the customer has no September invoices, show `No Transactions For September` in `redQ2`.

The 2.5 paper has some inconsistencies:
- The instructions say to search by *name*, but the examples are labelled by Customer ID (2, 3, 10).
- The example shows "Online Transaction: No" for invoices 101 and 102, but their checkbox is ticked in the sample data.
- The date line has no colon, which is most likely a typo.

**2.6 Gender Stats (10).** In `btnQ2_6` OnClick:
- Go through tblCustomers and take each customer's IDNumber.
- Digits 1–6 are the birth date (YYMMDD). Digits 7–10 (SSSS) give the gender: 0000–4999 is female, 5000–9999 is male.
- Count the males and females.
- Show the counts in `redQ2`. The example for 5 profiles is:

```
Number of Males=2
Number of Females=3
``` Gender comes from digit 7 of the SA ID number: 0–4 is female, 5–9 is male.
