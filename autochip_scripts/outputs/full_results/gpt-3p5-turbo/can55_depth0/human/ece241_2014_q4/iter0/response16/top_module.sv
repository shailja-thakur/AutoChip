module top_module (
	input clk,
	input x,
	output z
);
  reg d1, d2, d3;
  wire q1, q2, q3;
  
  xor_gate XOR1(x, q1, d1);
  and_gate AND1(x, q2, d2);
  or_gate OR1(x, q3, d3);
  
  d_flip_flop FF1(.clk(clk), .d(d1), .q(q1));
  d_flip_flop FF2(.clk(clk), .d(d2), .q(q2));
  d_flip_flop FF3(.clk(clk), .d(d3), .q(q3));
  
  xnor_gate XNOR(z, q1, q2, q3);
endmodule
module xor_gate(
  input a, b,
  output y  
);
  assign y = a ^ b;
endmodule
module and_gate(
  input a, b,
  output y  
);
  assign y = a & b;
endmodule
module or_gate(
  input a, b,
  output y  
);
  assign y = a | b;
endmodule
module xnor_gate(
  input a, b, c,
  output y  
);
  assign y = ~(a ^ b ^ c);
endmodule
module d_flip_flop(
  input clk, d,
  output reg q
);
  always @(posedge clk)
    q <= d;
endmodule
