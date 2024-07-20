module top_module (
    input clk,
    input x,
    output z
);
  
  reg [2:0] flip_flop_out;
  wire [2:0] flip_flop_complement_out;
  
  assign flip_flop_complement_out[0] = ~flip_flop_out[0];
  assign flip_flop_complement_out[1] = ~flip_flop_out[1];
  assign flip_flop_complement_out[2] = ~flip_flop_out[2];
  
  xor #(.nbits(2)) xor_gate (
    .a(flip_flop_out[0]),
    .b(x),
    .z(flip_flop_out[1])
  );
  
  and #(.nbits(2)) and_gate (
    .a(flip_flop_complement_out[0]),
    .b(x),
    .z(flip_flop_out[0])
  );
  
  or #(.nbits(2)) or_gate (
    .a(flip_flop_complement_out[1]),
    .b(x),
    .z(flip_flop_out[2])
  );
  
  xnor #(.nbits(3)) xnor_gate (
    .a(flip_flop_out[0]),
    .b(flip_flop_out[1]),
    .c(flip_flop_out[2]),
    .z(z)
  );
  
endmodule
