module top_module (
  input [99:0] in,
  output [98:0] out_both,
  output [99:1] out_any,
  output [99:0] out_different
);

  // Wire declarations
  wire [98:0] shifted_in;
  wire [98:0] and_result;
  wire [99:0] or_result;
  wire [99:0] xor_result;
  wire first_bit;

  // Assign shift operation to shifted_in
  assign shifted_in = {in[98:0], 1'b0};

  // Perform bit-wise AND operation
  assign and_result = in[98:0] & shifted_in;

  // Perform bit-wise OR operation
  assign or_result = in | shifted_in;

  // Perform bit-wise XOR operation
  assign xor_result = in ^ shifted_in;

  // Generate first bit of out_different using XOR
  assign first_bit = in[0] ^ shifted_in[99];

  // Assign outputs
  assign out_both = and_result;
  assign out_any = {1'b0, or_result};
  assign out_different = {first_bit, xor_result[99:1]};
  
endmodule
