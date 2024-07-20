module top_module(
	output reg zero); // declared as reg to be able to assign a value later
	// assigning 0 to zero output
	always @(posedge clk)
	begin
		zero <= 0;
	end
endmodule
