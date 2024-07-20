module top_module (
	input [4:1] x,
	output logic f
);

// Define internal signals
reg x1;
reg x2;
reg x3;
reg x4;

// Assign values to internal signals
assign x1 = x[1];
assign x2 = x[2];
assign x3 = x[3];
assign x4 = x[4];

// Define truth table for f function
always_comb begin
	case ({x3, x4, x1, x2})
		4'b0000: f = 1;
		4'b0001: f = 0;
		4'b0011: f = 1;
		4'b0010: f = 1;
		4'b0110: f = 0;
		4'b0111: f = 0;
		4'b0101: f = 0;
		4'b0100: f = 0;
		4'b1100: f = 1;
		4'b1101: f = 1;
		4'b1111: f = 1;
		4'b1110: f = 0;
		4'b1010: f = 1;
		4'b1011: f = 1;
		4'b1001: f = 0;
		4'b1000: f = 1;
	endcase
end
// End of module
endmodule
