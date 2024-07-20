module top_module(
	output reg out); // Added "reg" datatype for the output port

	always @(*) begin
		out = 0; // Assign the output port to a constant value of 0
	end

endmodule
