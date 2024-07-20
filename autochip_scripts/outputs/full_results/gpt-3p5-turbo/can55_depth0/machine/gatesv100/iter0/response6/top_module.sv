module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

  wire [98:0] shifted_in;
  wire [99:0] in_different;

  // Shift the input signal by one bit
  assign shifted_in = {in[98:0], 1'b0};

  // Perform bit-wise AND operation between the input signals
  assign out_both = in & shifted_in;

  // Perform bit-wise OR operation between the input signals
  assign out_any = in | shifted_in;

  // Perform bit-wise XOR operation between the input signals
  assign in_different = {in[0], shifted_in[99:1]};
  assign out_different = in_different;

endmodule
