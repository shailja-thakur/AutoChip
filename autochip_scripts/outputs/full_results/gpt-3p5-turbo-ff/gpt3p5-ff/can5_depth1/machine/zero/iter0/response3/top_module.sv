module top_module(
	output reg zero); // Adding 'reg' to specify a register datatype for the 'zero' output

	// Assigning the constant value 0 to the output 'zero'
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			zero <= 1'b0;
		end else begin
			zero <= 1'b0;
		end
	end

endmodule
