module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

reg A, B, C, D, E, F;

always @(y) begin
	A = (y == 6'b000001);
	B = (y == 6'b000010);
	C = (y == 6'b000100);
	D = (y == 6'b001000);
	E = (y == 6'b010000);
	F = (y == 6'b100000);
end

always @(A or B or C or D or E or F or w) begin
	case (1'b1)
		A: begin
			Y2 = 1'b0;
			Y4 = 1'b0;
		end
		B: begin
			Y2 = 1'b0;
			Y4 = 1'b1;
		end
		C: begin
			Y2 = 1'b1;
			Y4 = 1'b0;
		end
		D: begin
			Y2 = 1'b1;
			Y4 = 1'b1;
		end
		E: begin
			Y2 = 1'b1;
			Y4 = 1'b0;
		end
		F: begin
			Y2 = 1'b0;
			Y4 = 1'b1;
		end
		endcase
	end
endmodule
