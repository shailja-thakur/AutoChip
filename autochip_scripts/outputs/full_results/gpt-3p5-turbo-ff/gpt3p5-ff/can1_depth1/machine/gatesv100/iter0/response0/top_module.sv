module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  wire [99:0] shifted_in;
  wire [98:0] and_result;
  wire [99:0] or_result;
  wire [99:0] xor_result;
  
  assign shifted_in = {in[98:0], 1'b0};
  assign and_result = in[99:1] & shifted_in;
  assign or_result = in | shifted_in;
  assign xor_result = {in[0] ^ shifted_in[99], in[99:1] ^ shifted_in[98:0]};

  assign out_both = and_result;
  assign out_any = or_result;
  assign out_different = xor_result;

endmodule
