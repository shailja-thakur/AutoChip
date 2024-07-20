module top_module(
	output reg one);   // Add reg keyword for output one

	always @(*)  // Use the combinational block for continuous assignment
	begin
		one = 1'b1;   // Assign the value to output one
	end
endmodule
