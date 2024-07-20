module top_module(
	output reg zero); // Add reg keyword to the output declaration

	always @(posedge clk) // Add a clock input to the module
	begin
		zero <= 0; // Assign value to the output
	end

endmodule
