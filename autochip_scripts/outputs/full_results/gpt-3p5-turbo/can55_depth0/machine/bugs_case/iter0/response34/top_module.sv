module top_module (
	input [7:0] code,
	output reg [3:0] out,
	output reg valid
);

always @(*)
begin
	// Default assignments
	out = 4'd0;
	valid = 1'b1;
	
	// Case statement for assigning out based on code value
	case (code)
		8'h45: out = 4'b0000; // Assign 0 when code is 8'h45
		8'h16: out = 4'b0001; // Assign 1 when code is 8'h16
		8'h1e: out = 4'b0010; // Assign 2 when code is 8'h1e
		8'h26: out = 4'b0011; // Assign 3 when code is 8'h26
		8'h25: out = 4'b0100; // Assign 4 when code is 8'h25
		8'h2e: out = 4'b0101; // Assign 5 when code is 8'h2e
		8'h36: out = 4'b0110; // Assign 6 when code is 8'h36
		8'h3d: out = 4'b0111; // Assign 7 when code is 8'h3d
		8'h3e: out = 4'b1000; // Assign 8 when code is 8'h3e
		8'h46: out = 4'b1001; // Assign 9 when code is 8'h46
		default: valid = 1'b0; // Assign valid to 0 when code doesn't match any case
	endcase
end

endmodule
