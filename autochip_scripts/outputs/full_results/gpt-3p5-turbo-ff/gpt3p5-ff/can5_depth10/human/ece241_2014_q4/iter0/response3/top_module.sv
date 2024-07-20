module top_module (
	input clk,
	input x,
	output z
);
  reg flip_flop_1;
  reg flip_flop_2;
  reg flip_flop_3;

  wire xor_input;
  wire and_input;
  wire or_input;
  wire xnor_output;

  // XOR gate
  assign xor_input = x ^ flip_flop_1;
  xor_gate xor1 (.a(xor_input), .b(flip_flop_1));

  // AND gate
  assign and_input = ~(flip_flop_2);
  and_gate and1 (.a(and_input), .b(flip_flop_2));

  // OR gate
  assign or_input = ~(flip_flop_3);
  or_gate or1 (.a(or_input), .b(flip_flop_3));

  // D flip-flops
  d_flip_flop dff1 (.clk(clk), .d(xor_input), .q(flip_flop_1));
  d_flip_flop dff2 (.clk(clk), .d(and_input), .q(flip_flop_2));
  d_flip_flop dff3 (.clk(clk), .d(or_input), .q(flip_flop_3));

  // XNOR gate
  xnor_gate xnor1 (.a(flip_flop_1), .b(flip_flop_2), .c(flip_flop_3), .z(z));
endmodule
module xor_gate (
  input a,
  input b,
  output z
);
  assign z = a ^ b;
endmodule
module and_gate (
  input a,
  input b,
  output z
);
  assign z = a & b;
endmodule
module or_gate (
  input a,
  input b,
  output z
);
  assign z = a | b;
endmodule
module d_flip_flop (
  input clk,
  input d,
  output q
);
  reg q_reg;
  
  always @(posedge clk) begin
    q_reg <= d;
  end
  
  assign q = q_reg;
endmodule
module xnor_gate (
  input a,
  input b,
  input c,
  output z
);
  assign z = ~(a ^ b ^ c);
endmodule
