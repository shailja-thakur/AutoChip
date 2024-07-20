module top_module (
    input a,
    input b,
    output sum,
    output cout
);

  // Declare internal wire for sum and carry-out
  wire sum_internal, cout_internal;

  // Instantiate the half adder module
  half_adder ha_inst (
    .a(a),
    .b(b),
    .sum(sum_internal),
    .cout(cout_internal)
  );

  // Assign the outputs to the internal wires
  assign sum = sum_internal;
  assign cout = cout_internal;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);

  // Create the logic for the half adder
  assign sum = a ^ b;
  assign cout = a & b;

endmodule
