module top_module(
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);

  // Wire for bitwise OR
  wire [2:0] bitwise_or;
  // Wire for logical OR
  wire logical_or;
  // Wire for bitwise NOT of a
  wire [2:0] not_a;
  // Wire for bitwise NOT of b
  wire [2:0] not_b;

  // Perform bitwise OR
  assign bitwise_or = a | b;
  // Perform logical OR
  assign logical_or = |a | b;
  // Perform bitwise NOT of a
  assign not_a = ~a;
  // Perform bitwise NOT of b
  assign not_b = ~b;

  // Assign the outputs
  assign out_or_bitwise = bitwise_or;
  assign out_or_logical = logical_or;
  assign out_not = {not_a, not_b};

endmodule
