module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State machine logic
	always @* begin
		case(y)
			6'b000001: begin
				Y2 = w ? 1'b0 : 1'b1;
				Y4 = 1'b0;
			end
			6'b000010: begin
				Y2 = 1'b1;
				Y4 = w;
			end
			6'b000100: begin
				Y2 = 1'b0;
				Y4 = w;
			end
			6'b001000: begin
				Y2 = w;
				Y4 = 1'b0;
			end
			6'b010000: begin
				Y2 = w;
				Y4 = 1'b1;
			end
			6'b100000: begin
				Y2 = w;
				Y4 = w;
			end
			default: begin
				Y2 = 1'bx;
				Y4 = 1'bx;
			end
		endcase
	end
	
endmodule
