module top_module (
	input clk,
	input in,
	output logic out
);

  logic xor_output;
  logic d;

  assign xor_output = in ^ out;

  always @(posedge clk)
    d <= xor_output;

  always @(posedge clk)
    out <= d;

endmodule
