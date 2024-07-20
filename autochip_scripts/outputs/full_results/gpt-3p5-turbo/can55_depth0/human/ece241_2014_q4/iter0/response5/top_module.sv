module top_module (
	input clk,
	input x,
	output z
);
  
  reg [2:0] flip_flop_out;
  wire [2:0] flip_flop_out_complement;
  
  wire xor_input;
  wire and_input;
  wire or_input;
  
  assign xor_input = x ^ flip_flop_out[0];
  assign and_input = x & ~flip_flop_out_complement[1];
  assign or_input = x | ~flip_flop_out_complement[2];
  
  xor_gate xor1 (
    .a(xor_input),
    .b(flip_flop_out[0]),
    .z(flip_flop_out[1])
  );
  
  and_gate and1 (
    .a(and_input),
    .b(~flip_flop_out_complement[1]),
    .z(flip_flop_out[2])
  );
  
  or_gate or1 (
    .a(or_input),
    .b(~flip_flop_out_complement[2]),
    .z(z)
  );
  
  always @(posedge clk)
    flip_flop_out <= {flip_flop_out[1:0], xor_input};
    
  always @(posedge clk)
    flip_flop_out_complement <= {flip_flop_out_complement[1:0], ~flip_flop_out[2]};
  
endmodule
