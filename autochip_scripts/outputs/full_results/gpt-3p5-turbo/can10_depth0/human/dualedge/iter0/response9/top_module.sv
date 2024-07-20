module top_module(
	input clk,
  	input d,
  	output reg q);
	  
	// Internal variables
	reg q_d; // delayed q value
	
	// Positive edge-triggered flip-flop
	always @(posedge clk) begin
    	q_d <= q; // store the current q value
    	q <= d; // update q with the input d value
	end
	
	// Negative edge-triggered flip-flop
	always @(negedge clk) begin
    	q <= q_d; // update q with the delayed q value
	end
endmodule
