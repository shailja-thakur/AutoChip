module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	parameter A = 6'b000001;
	parameter B = 6'b000010;
	parameter C = 6'b000100;
	parameter D = 6'b001000;
	parameter E = 6'b010000;
	parameter F = 6'b100000;

	// Next-state logic for signal Y2
	always @(*)
	begin
		case(y)
			A: Y2 = (w) ? E[2] : B[2];
			B: Y2 = (w) ? D[2] : C[2];
			C: Y2 = (w) ? D[2] : E[2];
			D: Y2 = (w) ? A[2] : F[2];
			E: Y2 = (w) ? D[2] : E[2];
			F: Y2 = (w) ? D[2] : C[2];
			default: Y2 = 1'b0;
		endcase
	end

	// Next-state logic for signal Y4
	always @(*)
	begin
		case(y)
			A: Y4 = (w) ? A[4] : A[4];
			B: Y4 = (w) ? B[4] : B[4];
			C: Y4 = (w) ? C[4] : E[4];
			D: Y4 = (w) ? D[4] : D[4];
			E: Y4 = (w) ? E[4] : F[4];
			F: Y4 = (w) ? D[4] : D[4];
			default: Y4 = 1'b0;
		endcase
	end

endmodule
