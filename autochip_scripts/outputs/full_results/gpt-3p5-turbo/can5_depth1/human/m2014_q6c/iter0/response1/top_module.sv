module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Outputs for Y2 and Y4
	reg Y2;
	reg Y4;
	
	// Next state logic equations
	always @(*)
	case(y)
		6'b000001, 6'b000010: {Y2,Y4} = 2'b00; // State A, B
		6'b000100: {Y2,Y4} = 2'b00; // State C
		6'b001000: {Y2,Y4} = 2'b01; // State D
		6'b010000: {Y2,Y4} = 2'b10; // State E
		6'b100000: {Y2,Y4} = 2'b11; // State F
		default: {Y2,Y4} = 2'b00; // Default state (A)
	endcase

endmodule
