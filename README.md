# it-question-2

**Grade 11 Information Technology (South Africa, CAPS)**: Question 2, Database Manipulation, answered in **Delphi**, with step-by-step guides to help you study for the exam.

Everything is written in simple, clear language.

---

## What is in this repo

```
it-question-2/
├── README.md                          <- you are here
├── questions/
│   └── question-2-database/
│       ├── QUESTION.md                <- the full question (2.1 to 2.6)
│       └── Question2_Answers.pas      <- all 6 answers, with comments
├── walkthrough/                       <- HOW to answer each question
│   ├── README.md
│   ├── 00-before-you-start.md
│   ├── 2.1-add-record.md
│   ├── 2.2-errors-in-delivery.md
│   ├── 2.3-items-in-cart.md
│   ├── 2.4-online-transactions.md
│   ├── 2.5-september-transactions.md
│   └── 2.6-gender-stats.md
└── docs/
    └── research/
        └── sa-grade11-it-coding-conventions.md   <- the DBE rules the code follows
```

## How to study with this

1. **Read the question:** [`questions/question-2-database/QUESTION.md`](questions/question-2-database/QUESTION.md)
2. **Read [`walkthrough/00-before-you-start.md`](walkthrough/00-before-you-start.md)**. It covers the Delphi IDE basics and the 4 patterns.
3. **Work through each walkthrough in order** (2.1 to 2.6). Try to write the code yourself *before* you look at the answer.
4. **Check against the answers:** [`Question2_Answers.pas`](questions/question-2-database/Question2_Answers.pas)
5. **Practise again** on a blank project without looking. That is how you will do it in the exam.

## The questions at a glance

| Question | What it asks | Pattern used | Walkthrough |
|---|---|---|---|
| 2.1 Add Record | Add one new invoice | A: Add a row | [2.1](walkthrough/2.1-add-record.md) |
| 2.2 Errors in Delivery | Show invoices where items are missing | B: Visit every row | [2.2](walkthrough/2.2-errors-in-delivery.md) |
| 2.3 Items in Cart | Warn a customer who has no invoice | C: Search and stop | [2.3](walkthrough/2.3-items-in-cart.md) |
| 2.4 Online Transactions | Percentage online vs in store | B + D: Count | [2.4](walkthrough/2.4-online-transactions.md) |
| 2.5 September Transactions | Find a customer by name, show their September invoices | C, then B (two tables) | [2.5](walkthrough/2.5-september-transactions.md) |
| 2.6 Gender Stats | Count males and females from ID numbers | B + D + `Copy` | [2.6](walkthrough/2.6-gender-stats.md) |

## The 4 patterns (learn these!)

Almost every database question uses one of these.

| Pattern | When to use it | The code shape |
|---|---|---|
| **A: Add a row** | "add a record" | `Append` → fill in each field → `Post` |
| **B: Visit every row** | "find each", "display all" | `First` → `while not Eof do` → ... → `Next` |
| **C: Search and stop** | "check if", "verify", "exists" | Same loop with `and not bFound`, then check `bFound` **after** the loop |
| **D: Count** | "how many", "percentage" | Counter := 0 before the loop, `Inc(...)` inside, maths **after** |

## How to use the answers in Delphi

1. Open the Question 2 project (the `.dpr` file) in Delphi.
2. Write your **name or exam number as a comment on line 1**.
3. Add **`DateUtils`** to the `uses` list. 2.5 needs it for `MonthOf`.
4. On the form, **double-click each button** to make its OnClick procedure.
5. Type (or copy) the code from `Question2_Answers.pas` between `begin` and `end;`.
6. Press **F9** to run and test.

Works with Delphi 10 to 12, including the free **Community Edition**. The database is Microsoft Access, connected with ADO (`TADOTable`).

## Coding rules this code follows

These come from DBE documents (CAPS, the NSC exam papers and memos, and the PAT guidelines). Full details and sources are in [`docs/research/sa-grade11-it-coding-conventions.md`](docs/research/sa-grade11-it-coding-conventions.md).

**Naming (this earns marks):**

| Type | Starts with | Example |
|---|---|---|
| Integer | `i` | `iCount` |
| Real | `r` | `rOnlinePercent` |
| String | `s` | `sName` |
| Boolean | `b` | `bFound` |
| Components | 3 letters | `btnQ2_1`, `redQ2`, `edtName`, `tblInvoices` |

**Exam rules:**
1. Your **exam number goes in a comment on line 1** of every unit.
2. **Do not use `Locate`, `Filter` or `Sort`.** Write your own search loop.
3. Your code must **work with any data**. Never type in the answer.
4. **Answer only what is asked.** Extra checks and messages earn no marks.

## Things to know about this question paper

The question paper has a few mistakes. The answers deal with them like this:

| Where | Problem | What we did |
|---|---|---|
| Table names | It says `tblCustomer` in one place and `tblCustomers` in another | Used `tblCustomers`, as the paper instructs |
| OnlineTransaction | Described as a Number, but it is a Yes/No tick box | Treated it as True/False |
| 2.2 | The example output picture is missing | Used a clear layout: `Invoice ID: 102  Items missing: 1` |
| 2.4 | The caption says 3 and 2 (60%/40%), but the picture shows 75%/25% | The code works out the real percentage from the data |
| 2.5 | It says "name", but the examples say "Customer ID" | Searched by first name, as the instructions say |
| 2.5 | The example shows "No" for invoices that are ticked | Shows the real value (Yes/No) |
| 2.5 | "Date of Transaction2024/09/04" is missing a colon | Added the colon |

## Important notes

- The code has **not been compiled here** (there was no Delphi on this computer). Run it in Delphi and test it with the sample data before you rely on it.
- The research looked at **DBE (CAPS)** only, not IEB.
- Grade 11 exams and PATs are set by provinces and schools, so your teacher's rules come first if they are different.
