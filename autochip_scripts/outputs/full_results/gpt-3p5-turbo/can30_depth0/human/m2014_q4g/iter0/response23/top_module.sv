module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
  wire xnor_out;
  wire xor_out;
  
  xnor2 #(1) U1 (
    .a(in1),
    .b(in2),
    .f(xnor_out)
  );

  xor2 #(1) U2 (
    .a(xnor_out),
    .b(in3),
    .f(xor_out)
  );

  assign out = xor_out;
endmodule
module xnor2 (
  input a,
  input b,
  output reg f
);
  always @(a, b)
    f = ~(a ^ b);
endmodule
module xor2 (
  input a,
  input b,
  output reg f
);
  always @(a, b)
    f = a ^ b;
endmodule
