module top_module (
  input a,
  input b,
  input c,
  input d,
  output out,
  output out_n );  
  // Intermediate wires
  wire w1, w2;

  // First layer AND gates
  and gate1(w1, a, b);
  and gate2(w2, c, d);
  
  // Second layer OR gate
  or gate3(out, w1, w2);
  
  // Inverted output
  not gate4(out_n, out);
  
endmodule
module and (
  input a,
  input b,
  output y );
  
  assign y = a & b;
  
endmodule
module or (
  input a,
  input b,
  output y );
  
  assign y = a | b;
  
endmodule
module not (
  input a,
  output y );
  
  assign y = !a;
  
endmodule
