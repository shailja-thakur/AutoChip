module top_module(
	output reg one);
	
	/**
	 * This module has no inputs.
	 * The output 'one' is always assigned a logic high.
	 */
	always @(*) begin
		one = 1'b1;
	end
	
endmodule
