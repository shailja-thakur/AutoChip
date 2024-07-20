module top_module(
    input a, 
    input b,
    output out
);
   
   or_gate or1(a, b, intermediate);
   not_gate not1(intermediate, out);
   
endmodule
module or_gate(
  input a,
  input b,
  output o
  );
  assign o = a | b;
endmodule
module not_gate(
  input i,
  output o
  );
  assign o = ~i;
endmodule
