module top_module(
	output reg zero); // Adding `reg` datatype to the output declaration.

	always @(*) begin
		zero = 0; // Assigning the output `zero` a value of 0.
	end

endmodule
