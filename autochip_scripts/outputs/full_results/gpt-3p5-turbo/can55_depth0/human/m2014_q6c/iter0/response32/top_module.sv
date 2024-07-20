module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// Declare signals
	reg Y2;
	reg Y4;

	always @(*) begin
		// Next-state logic for Y2
		case(y)
			6'b000001 : Y2 = 0;
			6'b000010 : Y2 = 0;
			6'b000100 : Y2 = 0;
			6'b001000 : Y2 = 0;
			6'b010000 : Y2 = 0;
			6'b100000 : Y2 = 1;
			default   : Y2 = 0;
		endcase
		
		// Next-state logic for Y4
		case(y)
			6'b000001 : Y4 = 0;
			6'b000010 : Y4 = 1;
			6'b000100 : Y4 = 0;
			6'b001000 : Y4 = 1;
			6'b010000 : Y4 = 0;
			6'b100000 : Y4 = 1;
			default   : Y4 = 0;
		endcase
	end

endmodule
