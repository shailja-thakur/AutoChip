module top_module(
	input [3:0] p1a, 
	input [3:0] p1b, 
	input [3:0] p1c, 
	input [3:0] p1d, 
	output p1y, 
	input [3:0] p2a, 
	input [3:0] p2b, 
	input [3:0] p2c, 
	input [3:0] p2d, 
	output p2y
);
  
  wire [3:0] nand1_out;
  wire [3:0] nand2_out;
  
  nand_gate_4x1 nand1(.x(p1a), .y(p1b), .z(p1c), .w(p1d), .o(nand1_out));
  nand_gate_4x1 nand2(.x(p2a), .y(p2b), .z(p2c), .w(p2d), .o(nand2_out));
  
  nand_gate_2x1 nand3(.x(nand1_out[0]), .y(nand2_out[0]), .o(p1y));
  nand_gate_2x1 nand4(.x(nand1_out[1]), .y(nand2_out[1]), .o(p2y));
  
endmodule
module nand_gate_4x1(
  input [3:0] x,
  input [3:0] y,
  input [3:0] z,
  input [3:0] w,
  output [3:0] o
);
  
  nand_gate_2x1 nand1(.x(x[0]), .y(y[0]), .o(o[0]));
  nand_gate_2x1 nand2(.x(z[0]), .y(w[0]), .o(o[1]));
  
  nand_gate_2x1 nand3(.x(x[1]), .y(y[1]), .o(o[2]));
  nand_gate_2x1 nand4(.x(z[1]), .y(w[1]), .o(o[3]));
  
  nand_gate_2x1 nand5(.x(x[2]), .y(y[2]), .o(o[4]));
  nand_gate_2x1 nand6(.x(z[2]), .y(w[2]), .o(o[5]));
  
  nand_gate_2x1 nand7(.x(x[3]), .y(y[3]), .o(o[6]));
  nand_gate_2x1 nand8(.x(z[3]), .y(w[3]), .o(o[7]));
  
endmodule
module nand_gate_2x1(
  input x,
  input y,
  output o
);
  
  nand nand1(.a(x), .b(y), .o(o));
  
endmodule
module nand(
  input a,
  input b,
  output o
);
  
  assign o = ~(a & b);
  
endmodule
