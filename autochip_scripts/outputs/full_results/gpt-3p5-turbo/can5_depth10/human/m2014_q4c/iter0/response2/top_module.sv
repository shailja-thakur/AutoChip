module top_module (
	input clk,
	input d,
	input r,
	output logic q
);
  
  // D Flip Flop with active high synchronous reset
  always_ff @(posedge clk) begin
    if (r) // Reset is active high
      q <= 0; // Reset Q to 0
    else
      q <= d; // Set Q to D value
  end
  
endmodule
