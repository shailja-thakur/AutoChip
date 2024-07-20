module top_module(
	output reg zero
);

	// Assigning the constant value of 0 to the output zero
	always @(posedge clk) begin
		zero <= 0;
	end
	
endmodule
