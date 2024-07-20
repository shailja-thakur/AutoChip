module top_module (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out_or_bitwise,
  output out_or_logical,
  output [5:0] out_not
);
  
  // Bitwise OR Module
  or_bitwise_module or_bitwise_instance(
    .a(a),
    .b(b),
    .out(out_or_bitwise)
  );

  // Logical OR Module
  or_logical_module or_logical_instance(
    .a(a),
    .b(b),
    .out(out_or_logical)
  );

  // NOT Module for Vector b
  not_module not_b_instance(
    .in(b),
    .out(out_not[5:3])
  );

  // NOT Module for Vector a
  not_module not_a_instance(
    .in(a),
    .out(out_not[2:0])
  );

endmodule
module or_bitwise_module (
  input [2:0] a,
  input [2:0] b,
  output [2:0] out
);
  assign out = a | b; // Bitwise OR operation
endmodule
module or_logical_module (
  input [2:0] a,
  input [2:0] b,
  output out
);
  assign out = a || b; // Logical OR operation
endmodule
module not_module (
  input [2:0] in,
  output [2:0] out
);
  assign out = ~in; // NOT operation
endmodule
