module top_module (
	input clk,
	input x,
	output z
);

  reg d1, d2, d3;
  wire flipflop_out1, flipflop_out2, flipflop_out3;
  
  xor xor_gate (flipflop_out1, x, d1);
  and and_gate (flipflop_out2, x, d2);
  or or_gate (flipflop_out3, x, d3);
  
  d_flipflop ff1 (clk, flipflop_out1, d1);
  d_flipflop ff2 (clk, ~flipflop_out2, d2);
  d_flipflop ff3 (clk, ~flipflop_out3, d3);
  
  xnor xnor_gate (z, flipflop_out1, flipflop_out2, flipflop_out3);
  
endmodule
module d_flipflop (
  input clk,
  input d,
  output reg q
);
  
  always @(posedge clk)
    q <= d;
    
endmodule
module xor (
  output y,
  input a,
  input b
);
  
  assign y = a ^ b;
  
endmodule
module and (
  output y,
  input a,
  input b
);
  
  assign y = a & b;
  
endmodule
module or (
  output y,
  input a,
  input b
);
  
  assign y = a | b;
  
endmodule
module xnor (
  output y,
  input a,
  input b,
  input c
);
  
  assign y = ~(a ^ b ^ c);
  
endmodule
