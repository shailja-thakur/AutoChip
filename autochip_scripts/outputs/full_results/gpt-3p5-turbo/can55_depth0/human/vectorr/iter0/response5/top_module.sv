module top_module (
  input [7:0] in,
  output [7:0] out
);

  // Create a temporary variable to hold the reversed bits
  wire [7:0] reversed_bits;

  // Reverse the bit ordering using a for loop
  genvar i;
  generate
    for (i = 0; i < 8; i = i + 1) begin
      assign reversed_bits[i] = in[7 - i];
    end
  endgenerate

  // Assign the reversed bits to the output port
  assign out = reversed_bits;

endmodule
