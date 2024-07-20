module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	
	// Declare state variables
	reg [5:0] state;
	reg Y2_temp, Y4_temp;
	
	// Next-state logic
	always @*
	begin
		case (state)
			6'b000001: state = (w) ? 6'b000001 : 6'b000010; // A
			6'b000010: state = (w) ? 6'b000001 : 6'b000011; // B
			6'b000100: state = (w) ? 6'b000011 : 6'b000100; // C
			6'b001000: state = (w) ? 6'b000100 : 6'b000101; // D
			6'b010000: state = (w) ? 6'b000101 : 6'b000110; // E
			6'b100000: state = (w) ? 6'b000110 : 6'b000010; // F
			default: state = 6'b000001; // Default state is A
		endcase
	end
	
	// Output logic
	always @*
	begin
		Y2_temp = (state == 6'b000010) ? 1'b1 : 1'b0; // Y2 = 1 if state is B, otherwise 0
		Y4_temp = (state == 6'b001000 || state == 6'b100000) ? 1'b1 : 1'b0; // Y4 = 1 if state is D or F, otherwise 0
	end
	
	assign Y2 = Y2_temp;
	assign Y4 = Y4_temp;
	
endmodule
