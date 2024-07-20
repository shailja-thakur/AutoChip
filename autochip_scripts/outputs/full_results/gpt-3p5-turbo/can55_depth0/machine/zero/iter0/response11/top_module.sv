module top_module(
	output reg zero);  // Add 'reg' keyword to specify that zero is a register output

	always @(posedge clk)  // Add a clock signal to make the module synchronous
	begin
		zero <= 0;  // Assign the value 0 to the output zero
	end

endmodule
