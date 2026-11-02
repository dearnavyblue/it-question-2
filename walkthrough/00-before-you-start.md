# 00 – Before you start

## Step 1: Open the project

1. Open the **Question 2** folder.
2. Double-click the project file. It ends in **`.dpr`**, for example `Question2_P.dpr`. Delphi opens.
3. Press **F9** to compile and run it. The form appears. The buttons do nothing yet. That is normal!
4. Close the running program and go back to Delphi.

> If F9 shows an error about the database, the database file may not be in the right folder. Tell the invigilator.

## Step 2: Find your way around

| Key / place | What it does |
|---|---|
| **F12** | Swap between the **form** (the picture) and the **code** |
| **F9** | Compile and run |
| **Ctrl + S** | Save. Do it often! |
| **Object Inspector** (left side) | Shows the name and settings of whatever you clicked |
| **Events tab** in the Object Inspector | Shows OnClick and the other events |

## Step 3: Write your exam number on line 1

Press **F12** to get to the code. Click at the very top, before `unit`, and type:

```delphi
// Exam number: 1234567890123
```

This is a **DBE rule**. Every unit you code needs it.

## Step 4: Add DateUtils to the uses list

Question 2.5 needs `MonthOf`, and that lives in **DateUtils**. Near the top of the code you will see:

```delphi
uses
  Windows, Messages, SysUtils, ... , Dialogs, StdCtrls;
```

Add `DateUtils` before the `;`:

```delphi
  ... , Dialogs, StdCtrls, DateUtils;
```

## Step 5: How to make an OnClick event

You will do this for **every** question:

1. Press **F12** to see the form.
2. **Double-click** the button, for example `2.1 – Add Record`.
3. Delphi jumps to the code and makes an empty procedure for you:

```delphi
procedure TfrmQ2.btnQ2_1Click(Sender: TObject);
begin

end;
```

4. Type your code between `begin` and `end;`.

> Never type the `procedure ... begin end;` part yourself. Let Delphi make it by double-clicking. If you type it yourself, the button is not connected to it.

## The 4 patterns you will use

Almost every database question is one of these.

**Pattern A: Add a row** (2.1)
```delphi
tblX.Append;          // new empty row
tblX['Field'] := ...; // fill it in
tblX.Post;            // save
```

**Pattern B: Visit every row** (2.2, 2.4, 2.6)
```delphi
tblX.First;
while not tblX.Eof do
begin
  // look at this row
  tblX.Next;   // NEVER forget this
end;
```

**Pattern C: Search and stop** (2.3, 2.5)
```delphi
bFound := False;
tblX.First;
while (not tblX.Eof) and (not bFound) do
begin
  if tblX['Field'] = sWhatIWant then
    bFound := True
  else
    tblX.Next;
end;
```

**Pattern D: Count** (2.4, 2.6)
```delphi
iCount := 0;        // before the loop
...
Inc(iCount);        // inside the loop, when it matches
```

## Naming rules (these earn marks)

| Type | Starts with | Example |
|---|---|---|
| Integer (whole number) | `i` | `iCount` |
| Real (number with a comma) | `r` | `rPercent` |
| String (text) | `s` | `sName` |
| Boolean (True/False) | `b` | `bFound` |

## 3 exam rules to remember

1. **Do not use `Locate`, `Filter` or `Sort`.** Write your own loop.
2. **Your code must work with any data.** Never type in the answer.
3. **Answer only what is asked.** Extras get no marks.
