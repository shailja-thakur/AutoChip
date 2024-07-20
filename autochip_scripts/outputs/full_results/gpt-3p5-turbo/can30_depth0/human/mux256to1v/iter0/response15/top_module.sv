module top_module (
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out
);

  // Wire declarations
  wire [255:0] sel_out;

  // Select the appropriate 4-bit input based on the sel value
  assign sel_out = in[sel*4 +: 256];

  // Output assignment
  assign out = sel_out[3:0];

endmodule
