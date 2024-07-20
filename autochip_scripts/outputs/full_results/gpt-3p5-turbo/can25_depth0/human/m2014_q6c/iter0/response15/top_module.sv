module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	reg Y2, Y4;
	always @ (y or w)
	begin
		case(y)
			6'b000_001: begin
				Y2 = 1'b1;
				Y4 = 1'b0;
			end
			6'b000_010: begin
				Y2 = 1'b1;
				Y4 = 1'b0;
			end
			6'b000_100: begin
				Y2 = 1'b1;
				Y4 = 1'b0;
			end
			6'b001_000: begin
				Y2 = 1'b0;
				Y4 = 1'b1;
			end
			6'b010_000: begin
				Y2 = 1'b0;
				Y4 = 1'b1;
			end
			6'b100_000: begin
				Y2 = 1'b1;
				Y4 = 1'b0;
			end
			default: begin
				Y2 = 1'b0;
				Y4 = 1'b0;
			end
		endcase
	end
	
endmodule
