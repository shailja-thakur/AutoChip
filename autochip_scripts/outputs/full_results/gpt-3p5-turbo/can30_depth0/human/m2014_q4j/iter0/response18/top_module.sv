module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

  wire [3:0] carry;
  wire [3:0] out;

  assign carry[0] = 0;
  
  // Full Adder Instantiations
  full_adder FA0(x[0], y[0], carry[0], sum[0], out[0]);
  full_adder FA1(x[1], y[1], carry[1], sum[1], out[1]);
  full_adder FA2(x[2], y[2], carry[2], sum[2], out[2]);
  full_adder FA3(x[3], y[3], carry[3], sum[3], out[3]);
  
  assign carry[1] = out[0];
  assign carry[2] = out[1];
  assign carry[3] = out[2];
  assign sum[4] = out[3];
  
endmodule
module full_adder (
  input a,
  input b,
  input cin,
  output sum,
  output cout
);
  assign {1'b0, cout, sum} = a + b + cin;
endmodule
