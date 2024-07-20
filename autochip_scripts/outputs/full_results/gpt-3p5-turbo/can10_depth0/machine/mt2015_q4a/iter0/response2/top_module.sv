module top_module(
  input x,
  input y,
  output z);

  wire xor_out;
  wire and_out;
  
  xor_gate xor1(
    .a(x),
    .b(y),
    .out(xor_out)
  );
  
  and_gate and1(
    .a(xor_out),
    .b(x),
    .out(and_out)
  );
  
  assign z = and_out;
  
endmodule
module xor_gate(
  input a,
  input b,
  output out);
  
  assign out = a ^ b;
  
endmodule
module and_gate(
  input a,
  input b,
  output out);
  
  assign out = a & b;
  
endmodule
