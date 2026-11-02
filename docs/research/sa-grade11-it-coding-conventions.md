# South African Grade 11 IT (CAPS / DBE): coding conventions reference

Researched 2026-11-02. Scope: **DBE CAPS Information Technology only, using Delphi**. IEB is out of scope at the user's request. Use this as a style and scope brief for writing Delphi code that a Grade 11 learner would write and that would mark well against DBE marking guidelines and PAT rubrics.

Legend for how authoritative each item is:
- **[DBE-mandated]**: stated in a DBE policy or assessment document (CAPS, Examination Guidelines, PAT guidelines, NSC question papers or marking guidelines).
- **[DBE-published practice]**: shown or taught in DBE-published material (the DBE Grade 11 Practical Book, or code in DBE marking guidelines) but not stated as a rule.
- **[Classroom convention]**: widely taught, not in official policy.

---

## 1. Summary

- **Language and IDE: Delphi (Object Pascal), in Embarcadero Delphi / RAD Studio.** CAPS does not name a language. It only requires a visual, event-driven IDE with a GUI builder that supports both structured and OO programming ([CAPS IT, PDF p.10](#s1)). DBE fixed the language through **Circular S9 of 2015**: "As from November 2017, the DBE will only use Object Pascal (Delphi) for assessment in the NSC examinations" ([Exam Guidelines 2021, p.4](#s2)). The November 2024 NSC Paper 1 and the 2026 Grade 12 PAT are both still Delphi-only ([S4](#s4), [S3](#s3)). **I found no DBE announcement of a move to Python or any other language**, as of 2026-11-02. See §3.1 for the history and §5 for open questions.
- **Database:** Microsoft Access (`.mdb`/`.accdb`) through ADO components (`TADOConnection`, `TADOTable`, `TADOQuery`), usually in a data module ([S2 p.4](#s2); [S5 ch.8](#s5)).
- **Naming is Hungarian-style.**
  - Components take a 3-letter type prefix plus a meaningful name (`btnCalculate`, `edtName`, `redOutput`).
  - Variables take a 1-letter type prefix (`iCount`, `sName`, `rAverage`, `bFound`, `cLetter`).
  - Arrays use `arr`, objects `obj`, text-file variables `t`, database tables `tbl`.
  - Class fields use `f` and types use `T` (Grade 12 OOP).
  - Constants are in UPPERCASE.
  - The 2026 PAT rubric awards marks explicitly for "Proper naming convention of variables, e.g. iNumber, sName" and "Correct prefix for components, e.g. edt, red, cmb" ([PAT 2026, p.21](#s3)).
- **Comments:** put your **name, or examination number, as a comment on the first line** of every unit you code, add a comment heading for each question or section, and comment complex code ([S4 p.2](#s4); [S3 p.15](#s3); [S5 ch.1](#s5)).
- **Grade 11 programming scope** ([CAPS PDF pp.27–32](#s1)):
  - nested loops
  - **1-D arrays** and parallel arrays, with linear search and a sort written from first principles
  - built-in string and date methods
  - **text files** (AssignFile/Reset/Rewrite/Append, delimited lines, try/except or FileExists)
  - **user-defined procedures and functions with value parameters** ("Procedures – without reference parameters")
  - basic input validation
  - multi-form GUIs and dynamic instantiation of components
  - single-table **database access through dataset code** (`First`/`Next`/`Eof`/`Insert`/`Edit`/`Post`)
  - FloatToStrF/Format output

  **Not Grade 11:** user-defined classes and objects, 2-D arrays, and SQL embedded in Delphi code. These are all Grade 12 ([CAPS PDF pp.35–36](#s1)). Grade 11 has SQL-style queries only as database theory: a join on two tables at most.
- **Marks go to:** meaningful names with correct prefixes, correct local vs global scope, modular design using your own procedures and functions, validation with clear error messages and exception handling, formatted and readable output, comments, and a user-friendly GUI ([PAT 2026 rubric pp.21–24](#s3)). In exams, marks go only to what was asked ("if the question does not ask for data validation, no marks will be awarded for data validation"). Search, sort and text-file handling must be done from first principles ([S4 p.2](#s4); [S2 p.9](#s2)).

---

## 2. Cheat-sheet

### 2.1 Component prefixes

Source: [DBE Grade 11 Practical Book, Annexure B "Naming convention of components"](#s5) [DBE-published practice]. The DBE PAT rubric mandates "correct prefix for components", with the examples edt, red and cmb ([S3 p.21](#s3)) [DBE-mandated], but it does not publish a full table. Where NSC papers use a different prefix, the table notes it.

| Component | Prefix | Example | Notes |
|---|---|---|---|
| TForm | `frm` | `frmMain` → class `TfrmMain` | |
| TButton | `btn` | `btnCalculate` | |
| TBitBtn | `btt` | `bttClose` | |
| TLabel | `lbl` | `lblResult` | |
| TEdit | `edt` | `edtName` | |
| TMemo | `mem` | `memOutput` | |
| TRichEdit | `red` | `redOutput` | NSC uses this heavily |
| TListBox | `lst` | `lstNames` | |
| TComboBox | `cmb` | `cmbProvince` | |
| TCheckBox | `chk` | `chkMember` | NSC 2023 and 2024 papers use `chb` |
| TRadioButton | `rad` | `radMale` | |
| TRadioGroup | `rgp` | `rgpSize` | |
| TPanel | `pnl` | `pnlTotal` | |
| TGroupBox | `gbx` | `gbxInput` | Not in Annexure B; used in NSC 2023 |
| TSpinEdit | `sed` | `sedQuantity` | NSC papers also use `spn` |
| TImage | `img` | `imgLogo` | |
| TShape | `shp` | `shpBall` | |
| TStringGrid | `sgd` | `sgdMarks` | |
| TPageControl / TTabSheet | `pgc` / `tsh` | `pgcMain`, `tshReports` | `tsh` comes from NSC 2023 |
| TProgressBar / TStatusBar | `prb` / `stb` | | |
| TTimer | `tmr` | `tmrClock` | |
| TMainMenu | `mnu` | `mnuMain` | |
| TCalendar | `cld` | | |
| TADOConnection | `con` | `conDB` | |
| TADOTable | `tbl` | `tblLearners` | Must match the DB table name |
| TADOQuery | `qry` | `qryReport` | |
| TDataSource | `dsr` | `dsrLearners` | |
| TDBGrid | `dbg` | `dbgLearners` | |
| TDBNavigator / TDBText | `dbn` / `dbt` | | |

### 2.2 Variable and identifier prefixes

| Kind | Convention | Example | Source |
|---|---|---|---|
| Integer | `i` | `iCount`, `iAge` | Book Annex A [DBE-published]; PAT rubric names `iNumber` [DBE-mandated] |
| Real / Double | `r` | `rAverage`, `rPrice` | Book Annex A; NSC 2023 MG |
| String | `s` | `sName`, `sLine` | Book Annex A; PAT rubric names `sName` |
| Char | `c` | `cLetter` | Book Annex A |
| Boolean | `b` | `bFound`, `bValid` | Book Annex A; NSC 2023 MG |
| Array | `arr` + plural noun | `arrNames`, `arrMarks` | Book ch.3 ("We add the prefix arr"); NSC 2023/2024 |
| TextFile variable | `t` | `tFile`, `tLearners` | Book ch.5; NSC 2023 MG |
| Object instance | `obj` | `objSchool` | NSC 2023/2024 (Grade 12) |
| Class type | `T` + PascalCase | `TSchool`, `TfrmQuestion1` | Delphi standard; NSC MG |
| Class field (attribute) | `f` + PascalCase | `fSchoolName` | NSC 2023 and 2024 (Grade 12) |
| Constant | UPPERCASE | `PLAYERS = 11`, `CURRENTYEAR`, `VAT = 0.15` | NSC 2023 MG p.12; NSC 2024 p.5; Book ch.5 |
| Loop counters | `I`, `J`, or `iRow`/`iCol` | | NSC 2023 MG (both styles are accepted) |
| DB table | `tbl` + PascalCase plural | `tblSuppliers` | **PAT 2026 p.14** [DBE-mandated for PAT] |
| DB field | PascalCase, **no spaces** | `LecturerID`, `DateOfBirth` | PAT 2026 p.14 warns that spaces cause problems; NSC MGs |
| Unit file | `<Name>_U.pas` | `Question1_U.pas`, `School_U.pas` | NSC papers. The Grade 11 Book uses lowercase `_u` |
| Project file | `<Name>_P.dpr` | `Question1_P.dpr` | NSC papers. The Book uses `_p` |
| Procedures/functions | Descriptive verb phrase | `SumOfNumbers`, `calcFunding`, `isValidDate` | Book ch.6 (PascalCase); NSC MG (camelCase). No single rule exists |

General identifier rules from Book Annex A.3 [DBE-published practice]:
- Names are unique.
- A name starts with a letter, followed by letters, digits or `_`.
- Names describe their data.
- Use camel case.
- Component names start with three letters describing the component.
- Variable names start with a single letter describing the type.

### 2.3 Example: Grade 11-scope Delphi unit showing the conventions

The example is limited to Grade 11 CAPS scope: text file, parallel 1-D arrays, user-defined procedure and function with value parameters, validation, try/except, a hand-written sort, and formatted output. It has no user-defined class, which is Grade 12.

```delphi
// Name: Lesedi Mokoena   Exam no: 1234567890123
// Grade 11 IT - Tuck Shop Sales
unit TuckShop_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Spin;

type
  TfrmTuckShop = class(TForm)
    btnLoad: TButton;
    btnSort: TButton;
    btnAddSale: TButton;
    edtItem: TEdit;
    sedQuantity: TSpinEdit;
    redOutput: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnAddSaleClick(Sender: TObject);
  private
    procedure DisplaySales;
    function CalcTotal(rPrice: Real; iQty: Integer): Real;
  public
  end;

var
  frmTuckShop: TfrmTuckShop;

implementation

{$R *.dfm}

const
  MAX_ITEMS = 50;
  VAT = 0.15;

var
  // Global: shared by several event handlers
  arrItems: array [1 .. MAX_ITEMS] of String;
  arrPrices: array [1 .. MAX_ITEMS] of Real;   // parallel to arrItems
  iCount: Integer;

// ==============================================================
// User-defined function: total incl. VAT for one sale
// ==============================================================
function TfrmTuckShop.CalcTotal(rPrice: Real; iQty: Integer): Real;
begin
  Result := rPrice * iQty * (1 + VAT);
end;

// ==============================================================
// User-defined procedure: display arrays in columns
// ==============================================================
procedure TfrmTuckShop.DisplaySales;
var
  I: Integer;
begin
  redOutput.Clear;
  redOutput.Lines.Add(Format('%-20s%10s', ['Item', 'Price']));
  for I := 1 to iCount do
    redOutput.Lines.Add(Format('%-20s%10s',
      [arrItems[I], FloatToStrF(arrPrices[I], ffCurrency, 8, 2)]));
end;

procedure TfrmTuckShop.FormCreate(Sender: TObject);
begin
  iCount := 0;
end;

// ==============================================================
// Load items from a delimited text file, e.g.  Pie#18.50
// ==============================================================
procedure TfrmTuckShop.btnLoadClick(Sender: TObject);
var
  tFile: TextFile;
  sLine: String;
  iPosHash: Integer;
begin
  if not FileExists('Items.txt') then
  begin
    ShowMessage('The file Items.txt could not be found.');
    Exit;
  end;

  AssignFile(tFile, 'Items.txt');
  Reset(tFile);
  iCount := 0;
  while (not Eof(tFile)) and (iCount < MAX_ITEMS) do
  begin
    Readln(tFile, sLine);
    iPosHash := Pos('#', sLine);
    Inc(iCount);
    arrItems[iCount] := Copy(sLine, 1, iPosHash - 1);
    arrPrices[iCount] := StrToFloat(Copy(sLine, iPosHash + 1, Length(sLine)));
  end;
  CloseFile(tFile);
  DisplaySales;
end;

// ==============================================================
// Bubble sort on price (first principles), keeping arrays parallel
// ==============================================================
procedure TfrmTuckShop.btnSortClick(Sender: TObject);
var
  I, J: Integer;
  rTemp: Real;
  sTemp: String;
begin
  for I := 1 to iCount - 1 do
    for J := I + 1 to iCount do
      if arrPrices[I] > arrPrices[J] then
      begin
        rTemp := arrPrices[I];
        arrPrices[I] := arrPrices[J];
        arrPrices[J] := rTemp;
        sTemp := arrItems[I];
        arrItems[I] := arrItems[J];
        arrItems[J] := sTemp;
      end;
  DisplaySales;
end;

// ==============================================================
// Linear search with a flag, plus input validation
// ==============================================================
procedure TfrmTuckShop.btnAddSaleClick(Sender: TObject);
var
  sItem: String;
  iQty, I: Integer;
  bFound: Boolean;
begin
  sItem := Trim(edtItem.Text);
  if sItem = '' then
  begin
    ShowMessage('Please enter an item name.');
    edtItem.SetFocus;
    Exit;
  end;

  iQty := sedQuantity.Value;
  if iQty <= 0 then
  begin
    ShowMessage('Quantity must be greater than 0.');
    Exit;
  end;

  bFound := False;
  I := 1;
  while (I <= iCount) and (not bFound) do
    if UpperCase(arrItems[I]) = UpperCase(sItem) then
      bFound := True
    else
      Inc(I);

  if bFound then
    redOutput.Lines.Add(sItem + ': ' +
      FloatToStrF(CalcTotal(arrPrices[I], iQty), ffCurrency, 8, 2))
  else
    ShowMessage(sItem + ' is not on the menu.');
end;

end.
```

**Layout conventions visible in DBE marking-guideline code** ([S6](#s6), [S4](#s4)) [DBE-published practice; no DBE rule found]:
- 2-space indentation.
- `begin` on its own line, `end;` aligned with the statement that opened the block.
- One statement per line.
- A `// ====` banner comment naming each question or section.
- Long expressions broken across lines with `+` concatenation.

The memos are not perfectly consistent about case (`integer`/`Integer`, `NOT`/`not`), so case is not marked.

---

## 3. Detailed findings

### 3.1 Prescribed language and IDE (current state and history)

| Date | Event | Source |
|---|---|---|
| 2006–2013 | IT CAPS/NCS taught in either Java or Delphi, depending on province | DBE Implementation Plan for Standardising Programming Language (c.2014) [S9](#s9), §1 |
| Oct 2013 | DBE Circular S9 of 2013 standardises on Delphi, effective for NSC Nov 2016 | ITWeb [S10](#s10); IT-Online [S11](#s11) |
| 12 Dec 2013 | Circular S9 of 2013 withdrawn by Circular S15 of 2013 after industry backlash | htxt.co.za [S12](#s12); MyBroadband [S13](#s13) |
| c.2014 | DBE implementation plan: Delphi from Grade 11 in 2015 and Grade 12 in 2016, with teacher training in 2014/15 | [S9](#s9), §4.2 and timeline table (secondary-hosted copy) |
| 2015 | **Circular S9 of 2015**: "As from November 2017, the DBE will only use Object Pascal (Delphi) for assessment in the NSC examinations." | [S2 p.4](#s2) [DBE-mandated] |
| 2021 | Exam Guidelines require Embarcadero Delphi 2010 for preparing NSC learner files, and Access 2007 or later. Later Delphi versions may be used if the school ensures compatibility | [S2 p.4](#s2) |
| 2023/24 | Grade 11 ATP lists "Delphi programming software (Version 10, 10.3, 10.4)" | [S8 p.5](#s8) |
| Nov 2024 | NSC P1: "The Delphi programming language must be used". The candidate info sheet offers Delphi 10 / XE / 10.3 / Community / 11 / 12 | [S4 pp.2, last](#s4) |
| 2026 | Grade 12 PAT: "A working, fully documented Delphi application"; the learner needs "The Delphi IDE" | [S3 pp.4, 9](#s3) |

**Conclusion:** Delphi is the only language DBE assesses. CAPS itself is language-neutral ([S1 PDF p.10](#s1)), so a future switch would not need a CAPS rewrite, only a new circular. I found no such circular and no announced Python transition in my searches of education.gov.za or South African tech press. The only Python references are 2013-era lobbying ([S10](#s10)). Treat "no change" as current, with the caveat in §5.

Practical IDE choice: Delphi Community Edition, or any 10.x–12. Code should stay compatible with older Delphi: VCL, ADO components and classic `TextFile` I/O, with no inline `var` declarations and no generics.

### 3.2 Naming conventions

- **Mandated by DBE (PAT):**
  - The 2026 PAT rubric's "DATA DICTIONARY – Variables and components" criterion (4 marks) has four aspects: variety of appropriate variable types; correct use of local and global variables; "Proper naming convention of variables, e.g. iNumber, sName"; and "Correct prefix for components, e.g. edt, red, cmb" ([S3 p.21](#s3)).
  - The coding instructions also require learners to "Rename relevant components to add to readability and documentation of your code" ([S3 p.15](#s3)).
  - Database tables must be named "with the prefix 'tbl', e.g. tblSuppliers", and learners are warned about spaces in field names ([S3 p.14](#s3)).
- **CAPS:** Grade 10 Term 1 lists "Variable naming conventions" as content ([S1 PDF p.20](#s1)) but does not define them. Grade 10 also covers "File-naming conventions" under Systems Technologies.
- **DBE-published detail:** the Grade 11 Practical Book (publisher "Basic Education", 2019, ISBN 978-1-928388-53-1) gives the component-prefix table (Annexure B) and the variable rules (Annexure A.3: i/r/s/c/b prefixes and camel case) ([S5](#s5)). This is the most detailed DBE statement I found.
- **NSC exam practice:**
  - Component names on exam papers follow `<prefix>Q<question>_<sub>`, for example `btnQ1_1`, `edtQ1_3`, `redQ3`, `tblCourses`, `rgpQ3_2_1`.
  - Forms are `TfrmQuestionN`.
  - Units and projects are `QuestionN_U.pas` and `QuestionN_P.dpr`.
  - Class units are named after the class, for example `School_U.pas` and `MRecord_U.pas` ([S6](#s6), [S4](#s4), [S7](#s7)).
  - The `Q1_1` style exists only to tie the code to exam questions. Use meaningful names in a PAT.
- **Fields and classes (Grade 12):** NSC OOP questions declare attributes as `fName` in a `private` section, with methods `getX`, `setX`/`updateX` and `toString`, and a parameterised `constructor Create(...)` ([S6 p.17](#s6); [S4 p.17](#s4); [S2 p.8](#s2)).

### 3.3 Layout and comments

- **Mandated, exams:** "Make sure that your examination number appears as a comment in every program that you code, as well as on every event indicated." Each question also says "Enter your examination number as a comment in the first line of the ... file" ([S4 pp.2, 4](#s4); [S7 p.2](#s7)) [DBE-mandated].
- **Mandated, PAT:** "Project notes related to the programming code should be embedded as comments in the code. Document the code so that other programmers will be able to interpret the code and understand the purpose of individual pieces of code. It should also include comments to explain sections of complex code." ([S3 p.15](#s3)). The rubric's Documentation criterion (4 marks) runs from "Code clearly annotated to fully explain all necessary parts" down to "No comments" ([S3 p.24](#s3)).
- **CAPS:** Grade 10 Term 4 includes "Document the solution by adding comments" ([S1 PDF p.25](#s1)).
- **Grade 11 Book:** activities say "Add your name and surname as a comment in the first line of the Question1_1_u.pas file" ([S5 ch.1](#s5)).
- **Indentation, begin/end placement and one statement per line:** **I found no DBE rule.** The DBE marking-guideline code consistently uses 2-space indentation, `begin`/`end` on their own lines and one statement per line ([S6](#s6)). Classroom convention follows the Delphi IDE defaults. Treat these as [DBE-published practice], not marked criteria.

### 3.4 Grade 11 programming scope (what to use and what to avoid)

From CAPS Grade 11 ([S1 PDF pp.26–32](#s1)) [DBE-mandated]. The 2023/24 ATP orders the topics slightly differently ([S8](#s8)).

| Topic | Grade 11 expectation | Source |
|---|---|---|
| Loops | Nested loops; sentinel/flag-controlled loops | CAPS PDF p.24, p.27 |
| Arrays | **1-D only**: traverse, aggregates, **linear search**, **a sorting algorithm**, **parallel arrays**. The ATP adds binary search and bubble sort. **2-D arrays are Grade 12** | CAPS PDF p.27, p.36; ATP p.1 |
| Strings | Built-in string methods (`Pos`, `Copy`, `Insert`, `Delete`, `Length`). In Grade 10 these were done "from first principles" | CAPS PDF p.27, p.24 |
| Dates | Date/time objects, formatting, calculations, `TimeToStr`, `DateToStr`, `IsLeapYear` | CAPS PDF p.27 |
| Text files | "Extend the use of textfiles on delimited strings". Text-based reports with correctly formatted data. Exceptions on file I/O (from Grade 10) | CAPS PDF p.29, p.24 |
| Methods | "User defined methods with and without parameter passing; Procedures – without reference parameters; Functions; Arguments vs parameters". "Apply simple parameter passing and return values using class methods as part of the form class" | CAPS PDF p.29, p.31 |
| GUI | Multi-form/multi-screen GUI; dynamic instantiation of components | CAPS PDF p.29, p.31 |
| Database (code) | Connect to a **single-table** DB by path in code; navigate records; read, modify and insert fields and records with dataset methods; dataset event handlers only in the PAT | CAPS PDF p.31 |
| Database (theory) | Table design, PK/FK, 1:M, simple ERD, query with a join of at most 2 tables | CAPS PDF p.30 |
| Validation | Grade 10: "Basic validation techniques (input and processing), e.g. test for negative number". Grade 11 data theory: format, type, range and check-digit checks | CAPS PDF p.22, p.30 |
| Debugging/testing | Watches, trace tables, manual output comparison; typical, erroneous and boundary data | CAPS PDF pp.22, 31; PAT p.15 |
| Output formatting | Grade 10 "Formatting of output (fixed, currency)": `FloatToStrF(r, ffFixed, w, d)` and `ffCurrency`, plus `Format('%-20s%10.2f', [...])` | CAPS PDF p.20; Book Annex A; NSC 2023 MG |
| OOP | Grade 11: event-driven code "within the OOP paradigm" using the form class. **User-defined classes, constructors, accessors, mutators and toString are Grade 12** | CAPS PDF p.31, pp.35–36 |
| SQL in code | Grade 12 (`ADOQuery` with SELECT, INSERT, UPDATE, DELETE, GROUP BY and so on) | CAPS PDF p.35; Exam Guidelines p.8 |

**Exam-style rules that shape how code should be written** ([S4 p.2](#s4); [S2 p.9](#s2)) [DBE-mandated]:
- "Routines, such as search, sort and selection, must be developed from first principles. You may NOT use the built-in features." The Exam Guidelines extend this to "reading/writing using text files". Use `AssignFile`/`Reset`/`Readln`/`CloseFile` loops and hand-written sorts, not `TStringList.LoadFromFile` or `TArray.Sort`. Database `Filter`, `Sort` and `Locate` are "NOT allowed".
- "Your programs must be coded in such a way that they will work with any data", so no hard-coding of sample data.
- "All data structures must be defined by you, the programmer, unless the data structures are supplied."
- "Answer only what is asked." Unrequested validation earns nothing in exams, although it does earn marks in the PAT.
- Memos accept "an alternate correct solution", so the style rules above are not marked line by line in exams ([S6 p.2](#s6)). Some memos still require structures: using `if` chains where `case` was asked loses marks, and a given constant "must be used at least once" ([S6 pp.3–4](#s6)).

**Exception handling / defensive programming** [DBE-published practice]:
- The Grade 11 Book teaches `FileExists` and `try ... Reset(tFile) ... except ShowMessage(...); Exit; end;` for files ([S5 ch.5](#s5)).
- It teaches validation functions that return Booleans, such as `isReal` with `try StrToFloat ... except`, `CheckEmpty` and `isValidDate` ([S5 ch.6 §6.4](#s5)).
- The PAT explicitly requires "sound defensive programming techniques to produce a robust program" ([S3 p.14](#s3)).

### 3.5 What PAT rubrics reward

Source: DBE Grade 12 PAT 2026 ([S3](#s3)). This is the only nationally published IT PAT. Grade 10 and 11 PATs are teacher-assessed ([S1 PDF p.54](#s1)), and I found no current national Grade 11 PAT on education.gov.za (§5). In practice, Grade 11 PATs are modelled on the Grade 12 structure.

The marks are split into Phase 1 analysis and design (48), coding and testing (86), and final product (16).

Coding criteria, 4 marks each unless stated:
- **Data dictionary:** appropriate types, correct local vs global variables, variable naming such as iNumber and sName, component prefixes such as edt, red and cmb.
- **GUI/HCI:** layout and feedback (screen tips, help), appropriate components, readable I/O, tooltips and shortcuts.
- **Input:** a variety of sources, correct data types, appropriate format, a suitable GUI component.
- **Validation and error catching:** "A variety of validation/error catching for relevant input. Clear and appropriate error messages and exception handling mechanisms". In design, at least four inputs and four data types are validated, including empty fields and "Test if value was selected in a selection component" (p.19).
- **Processing:** algorithm correctness; efficiency, where top marks need "Effective modular design with correct use of own functions and procedures"; complex code such as dynamic components.
- **Output:** layout, readability (columns, headings), formatting such as currency, the most appropriate component.
- **Data structures:** text files, classes and objects, arrays or advanced concepts.
- **Database manipulation**, 3 marks each: sort, search, insert, delete, edit, selection query, complex query, two calculated queries, a two-table query, a dynamic query using a variable.
- **Documentation:** comments and project notes.
- **Exceptional features.**

The general coding instructions (p.14–15) say:
- use OOP principles, reuse code, and use functions, procedures, methods and objects
- use relevant validation procedures and components
- rename components for readability
- generate formatted output
- ensure smooth interaction between classes, forms and tabs

---

## 4. Sources

Primary DBE documents (downloaded and read):
- <a id="s1"></a>**[S1]** DBE, *Curriculum and Assessment Policy Statement (CAPS): Information Technology*, March 2018. https://www.education.gov.za/LinkClick.aspx?fileticket=Jlmhezws890%3D&tabid=2030&portalid=0&mid=7875. Page refs are PDF pages.
- <a id="s2"></a>**[S2]** DBE, *Information Technology Examination Guidelines, Grade 12, 2021* (12 pp.; latest version I found). https://www.education.gov.za/Portals/0/CD/2021%20Exam%20Guidelines/Information%20Technology%20GR%2012%20Exam%20Guidelines%202021%20Eng.pdf
- <a id="s3"></a>**[S3]** DBE, *Information Technology Guidelines for Practical Assessment Tasks, Grade 12, 2026* (34 pp.). https://www.education.gov.za/Portals/0/CD/2026%20PATs/Information%20Technology/Information%20Technology%20PAT%20GR%2012%202026%20Eng.pdf
- <a id="s4"></a>**[S4]** DBE, *NSC Information Technology P1, November 2024* (question paper). https://www.education.gov.za/Portals/0/CD/2024%20November%20past%20papers/Information%20Technology%20P1%20Nov%202024%20Eng.pdf
- <a id="s5"></a>**[S5]** DBE ("Basic Education", epub metadata), *Information Technology Practical Book Grade 11*, 2019, ISBN 978-1-928388-53-1. Annexure A.3 (variables), Annexure B (component prefixes), ch.3 arrays, ch.5 text files, ch.6 methods and validation, ch.8 databases. Hosted at https://www.siyavula.com/downloads/books/it/IT_practical_book_grade11.epub
- <a id="s8"></a>**[S8]** DBE, *2023/24 Annual Teaching Plans: Information Technology Grade 11*. https://www.education.gov.za/LinkClick.aspx?fileticket=OvyOulhnLvM%3D&tabid=3205&portalid=0&mid=10752

Primary DBE documents on third-party mirrors (the content is DBE's; the host is not):

- <a id="s6"></a>**[S6]** DBE, *NSC Information Technology P1 November 2023 Marking Guidelines* (24 pp.). Mirror: https://regenesys.net/reginsights/wp-content/uploads/2024/10/Nov-2023-Information-Technology-Memo-1.pdf
- <a id="s7"></a>**[S7]** DBE, *SC/NSC Information Technology P1 May/June 2023* (question paper). Mirror: https://www.belgiumcampus.ac.za/wp-content/uploads/2024/05/Information-Technology-P1-May-June-2023-Eng.pdf
- <a id="s9"></a>**[S9]** DBE, *Implementation Plan for Standardising Programming Language for Information Technology for 2015* (39 pp.). Mirror: https://delphiorg.github.io/assets/images/2016/05/IT-Tools-Standardisation-Implementation-Plan-Delphi.pdf. Its provenance is not confirmed on a DBE domain.

Secondary (news; history only):

- <a id="s10"></a>**[S10]** ITWeb, "IITPSA questions DBE decision on programming language teaching" (2013). https://www.itweb.co.za/content/YKzQenqjOwnvZd2r
- <a id="s11"></a>**[S11]** IT-Online, "Industry slams DBE's Delphi decision" (10 Oct 2013). https://it-online.co.za/2013/10/10/industry-slams-dbes-delphi-decision/
- <a id="s12"></a>**[S12]** htxt.co.za, "Education department backs down over Delphi" (Dec 2013). https://htxt.co.za/2013/12/education-department-backs-down-over-delphi/
- <a id="s13"></a>**[S13]** MyBroadband, "Delphi, MS-Office SA schools exclusive reversed" (2013). https://mybroadband.co.za/news/government/93659-delphi-ms-office-sa-schools-exclusive-reversed.html

---

## 5. Open questions and unverified items

- **Language transition.** I found no DBE circular or announcement replacing Delphi with Python or anything else, up to 2026-11-02. My checks were web searches of education.gov.za and South African tech news, plus the 2026 PAT and the Nov 2024 P1. I could not read the full DBE circulars archive. A 2025/2026 circular could exist that did not surface. **Check the DBE circulars page and the latest IT Examination Guidelines before relying on this.**
- **Exam Guidelines currency.** The 2021 Grade 12 Exam Guidelines are the latest I found. They still name Delphi 2010, while the 2023/24 ATP lists Delphi 10–10.4 and the Nov 2024 paper accepts 10–12. A newer guideline may exist.
- **The 2023 "abridged CAPS" (Section 4, Annexure B: components, events and methods).** The Exam Guidelines reference a "Grade 12 Abridged Section 4 CAPS document" with a component, event and method list on page 112 ([S2 p.10](#s2)). I did not obtain it. It may be the most authoritative component list, and its prefixes may differ from the Book's.
- **No official layout rule.** No DBE document I read specifies indentation, begin/end placement or casing. The §2.3 layout follows DBE memo code by observation.
- **Prefix variants.** These differ between DBE sources: `chk` (Book) vs `chb` (NSC 2023/2024); `sed` (Book) vs `spn` (NSC); casing of `_U`/`_u`; PascalCase (Book) vs camelCase (NSC) method names. None of these appears to be penalised. Pick one style and use it consistently.
- **Grade 11 PAT.** No national Grade 11 IT PAT was found on education.gov.za; the 2017 Grade 11 PAT page has no IT entry. Grade 11 PATs are set by provinces or teachers, so local rubrics may differ. A "Gr 11 IT PAT 2023" document exists on Scribd but is unverified.
- **Grade 11 exams** are set by provinces or schools, not nationally. I did not review a provincial Grade 11 P1 memo. Grade 11 marking is assumed to follow the NSC memo style.
- The DBE Grade 11 Practical Book's epub lists the publisher as "Basic Education" but says "Copyright in the text remains with the contributors". I treat it as DBE-published, CAPS-aligned material, not policy.
