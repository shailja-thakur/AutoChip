module top_module (
    input [2:0] in,
    output [1:0] out
);

  // Declare wires for intermediate signals
  wire [3:0] sum;

  // Add the 3 input bits
  assign sum = in[2:0] + 1'b1;

  // Assign the result to the output bits
  assign out[1:0] = sum[3:2];

endmodule
