module top_module(
	output zero);
	
	// always block to assign value LOW to the output
	always @(*) begin
		zero = 0;
	end
	
endmodule
