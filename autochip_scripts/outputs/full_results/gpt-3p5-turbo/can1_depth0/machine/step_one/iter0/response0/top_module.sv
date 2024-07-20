module top_module(
	output reg one); // Add reg keyword to make 'one' a register

	always @* // Use always @* to infer combinational logic
	begin
		one = 1'b1; // Assign 1'b1 to 'one'
	end
endmodule
