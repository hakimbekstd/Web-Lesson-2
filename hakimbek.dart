import 'dart:math';

void main() {
  List list = [6,6,6,5,3,2];
  int i=0;
  while (true) {
    i++;
    print(i);
  }
  

}


bool yechim3(List list) {
  if(list.length<3 || list[0]>list[1]) return false;
  bool one = true;
  bool two = false;

  for(int i=0;i<list.length-1;i++) {
    if(list[i]<list[i+1]) {
      one = true;
    }

    if(one && two) return false;
    if(list[i]>list[i+1]) {
      two = true;
      one = false;
    }
  }

  return (one==false && two);
}

bool yechim2(List list) {
  int sanoq = 0;
  if(list.length<3) return false;
  for(int i=0;i<list.length-1;i++) {
    if(list[i]<list[i+1]) {
      ++sanoq;
    } else break;
  }
  ++sanoq;

  for(int i=sanoq;i<list.length-1;i++) {
    if(list[i]>list[i+1]) {
      ++sanoq;
    } else break;
  }
  ++sanoq;

  return sanoq==list.length;

}

void yechim1(List list) {
  if(list.length<3) {
    print(false);
    return;
  } 
  
  int index=0;
  
  for(int i=0;i<list.length-1;i++) {
    if(list[i]>list[i+1]) {
      index = i;
      break;
    }
  }
  
  List left = list.sublist(0,index+1);
  left.sort();

  List right = list.sublist(index+1,list.length);
  right.sort();
  right = right.reversed.toList();
  
  for(int i =0;i<list.length;i++) {
    if(list[i]!=(left+right)[i]) {
      print(false);
      return;
    }
  }

  print(true);
}



void binaryToDecimal(int binaryNum) {
  String bnStr = binaryNum.toString();
  int result=0;
  for(int i=0;i<bnStr.length;i++) {
    result += int.parse(bnStr[i]) * pow(2, i).toInt();
  }
  print(result);
}



void decimalToBinary(int decimalNum) {
  String result = "";
  while (true) {
    if(decimalNum < 2) return print(result+decimalNum.toString());
    result += (decimalNum % 2).toString();
    decimalNum = (decimalNum / 2).toDouble().floor();
  }
}


/*
    binary 2
    octal 8
    decimal 10
    hexadecimal 16
*/