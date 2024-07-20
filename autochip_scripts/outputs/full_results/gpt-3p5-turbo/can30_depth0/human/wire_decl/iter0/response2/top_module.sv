module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );
  
  wire and1_output;
  wire and2_output;
  
  and gate1 (and1_output, a, b);
  and gate2 (and2_output, c, d);
  or or_gate (out, and1_output, and2_output);
  not not_gate (out_n, out);
  
endmodule
module and(
  output wire y,
  input wire a,
  input wire b
);
  assign y = a & b;
endmodule
module or(
  output wire y,
  input wire a,
  input wire b
);
  assign y = a | b;
endmodule
module not(
  output wire y,
  input wire a
);
  assign y = ~a;
endmodule
