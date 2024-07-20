module top_module(
	output reg one);

	always @(1) // Add a dummy sensitivity list with any value to trigger the always block
	begin
		one = 1'b1;
	end

endmodule
