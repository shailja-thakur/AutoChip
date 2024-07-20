module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  // Wire Declarations
  wire [98:0] temp_both;
  wire [99:0] temp_any;
  wire [99:0] temp_different;

  // AND Operation for out_both
  assign temp_both = in[99:1] & in[98:0];
  assign out_both = temp_both;

  // OR Operation for out_any
  assign temp_any = in[99:0] | in[98:1];
  assign out_any = temp_any;

  // XOR Operation for out_different
  assign temp_different = {in[0] ^ in[99], in[99:1]};
  assign out_different = temp_different;

endmodule
