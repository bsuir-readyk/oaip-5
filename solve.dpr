uses
  sysutils;


type
  TFillType = (ftRandom, ftSorted, ftReverse);


procedure fill(var arr: array of integer; fillType: TFillType);
var
  i: integer;
begin
  randomize;

  i := low(arr);
  while i <= high(arr) do
  begin
    case fillType of
      ftRandom:  arr[i] := random(2000);
      ftSorted:  arr[i] := i;
      ftReverse: arr[i] := high(arr) - i;
    end;
    Inc(i);
  end;
end;


procedure SortBubbleWFlag(var arr: array of integer; var comparisons, insertions: uint64);
var
  i, j, temp: integer;
  swapped: boolean;
begin
  comparisons := 0;
  insertions := 0;
  
  i := 0;
  swapped := true;
  while (i < length(arr)-1) and swapped do
  begin
    j := 0;
    swapped := false;
    
    while j < length(arr)-1-i do
    begin
      Inc(comparisons);
      
      if arr[j] > arr[j+1] then
      begin
        temp := arr[j];
        arr[j] := arr[j+1];
        arr[j+1] := temp;
        
        Inc(insertions, 3);
        swapped := true;
      end;
      
      Inc(j);
    end;
    
    Inc(i);
  end;
end;


procedure SortShell (var arr: array of integer; var comparisons, insertions: uint64);
var
    i, temp, j, gap: integer;
begin
    gap := length(arr) div 2;
    while gap > 0 do
    begin
        i := 1;
        while i <= length(arr) do
        begin
            temp := arr[i];
            j := i;
            Inc(comparisons);
            while (j > gap) and (temp < arr[j - gap]) do
            begin
                Inc(comparisons);
                arr[j] := arr[j - gap];
                Inc(insertions);
                j := j - gap;
            end;
            arr[j] := temp;
            Inc(insertions);
            Inc(i);
        end;
        gap := gap div 2;
    end;
end;

procedure printPart (var arr: array of integer; var comparisons, insertions: uint64; fillType: TFillType);
begin
  case fillType of
    ftRandom:  write(Format('| Random (%d)', [length(arr)]));
    ftSorted:  write(Format('| Sorted (%d)', [length(arr)]));
    ftReverse: write(Format('| Rev-ed (%d)', [length(arr)]));
  end;

  case length(arr) of
    10:   write('    | ');
    100:  write('   | ');
    2000: write('  | ');
  end;

  fill(arr, fillType);
  SortBubbleWFlag(arr, comparisons, insertions);
write(comparisons:11, ' | ', insertions:10);
  fill(arr, fillType);
  SortShell(arr, comparisons, insertions);
writeln(' | ', comparisons:11, ' | ', insertions:10, ' |');
end;

var
  arr10: array[1..10] of integer;
  arr100: array[1..100] of integer;
  arr2000: array[1..2000] of integer;
  insertions, comparisons: uint64;
begin

writeln('|----------------------------------------------------------------------|');
writeln('|  Array type    | Bubble Sort              | Shell Sort               |');
writeln('|                |--------------------------|--------------------------|');
writeln('|                | Comparisons | Insertions | Comparisons | Insertions |');
writeln('|----------------------------------------------------------------------|');

printPart(arr10, comparisons, insertions, ftRandom);
printPart(arr10, comparisons, insertions, ftSorted);
printPart(arr10, comparisons, insertions, ftReverse);
writeln('|----------------------------------------------------------------------|');
printPart(arr100, comparisons, insertions, ftRandom);
printPart(arr100, comparisons, insertions, ftSorted);
printPart(arr100, comparisons, insertions, ftReverse);
writeln('|----------------------------------------------------------------------|');
printPart(arr2000, comparisons, insertions, ftRandom);
printPart(arr2000, comparisons, insertions, ftSorted);
printPart(arr2000, comparisons, insertions, ftReverse);
writeln('|----------------------------------------------------------------------|');
end.

