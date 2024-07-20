module top_module (
	input clk,
	input in,
	output logic out
);

  logic prev_out; // variable to store previous output value
  
  always_ff @(posedge clk)
    prev_out <= out;
  
  always_comb
    out = in ^ prev_out;

endmodule
