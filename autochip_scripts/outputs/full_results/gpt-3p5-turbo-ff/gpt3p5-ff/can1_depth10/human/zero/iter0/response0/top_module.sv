module top_module(
	output reg zero); // Adding 'reg' keyword to declare 'zero' as a register
	 
	always @(*) // Use '@(*)' for combinational logic (no inputs)
	begin
		zero = 0; // Assign 'zero' to 0 for a LOW output
	end
	
endmodule
