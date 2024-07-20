module top_module(
  input p1a,
  input p1b,
  input p1c,
  input p1d,
  input p1e,
  input p1f,
  output p1y,
  input p2a,
  input p2b,
  input p2c,
  input p2d,
  output p2y
);
  
  wire p1and1; // intermediate wire for the first 3-input AND gate
  wire p1and2; // intermediate wire for the second 3-input AND gate
  
  assign p1and1 = p1a & p1b & p1c;
  assign p1and2 = p1d & p1e & p1f;
  
  assign p1y = p1and1 | p1and2;
  
  wire p2and1; // intermediate wire for the first 2-input AND gate
  wire p2and2; // intermediate wire for the second 2-input AND gate
  
  assign p2and1 = p2a & p2b;
  assign p2and2 = p2c & p2d;
  
  assign p2y = p2and1 | p2and2;
  
  // Add your code here
  
endmodule
