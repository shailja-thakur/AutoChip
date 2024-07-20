module top_module(
    input a,
    input b,
    output out
);

  // Declare internal wire signals
  wire or_out;

  // Instantiate the OR gate
  // Use the "|" (pipe) operator to perform logical OR operation
  assign or_out = a | b;

  // Instantiate the inverter
  // Use the "~" (tilde) operator to perform logical NOT operation
  assign out = ~or_out;

endmodule
