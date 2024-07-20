module top_module(
	output reg one); // Added reg keyword to declare one as a register output

	always @(*) begin
		one = 1'b1; // Assign 1'b1 to the output one
	end

endmodule
