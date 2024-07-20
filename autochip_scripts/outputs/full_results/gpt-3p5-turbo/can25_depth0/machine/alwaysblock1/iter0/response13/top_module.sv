module top_module(
    input a, 
    input b,
    output out_assign,
    output reg out_alwaysblock
);
	
	// Perform logical AND using assign statement
	assign out_assign = a & b;
	
	// Always block to continuously update out_alwaysblock
	always @* begin
		out_alwaysblock = a & b;
	end
	
endmodule
