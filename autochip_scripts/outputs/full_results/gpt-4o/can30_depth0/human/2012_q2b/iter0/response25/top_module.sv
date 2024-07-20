module top_module (
	input [5:0] y,
	input w,
	output reg Y1,
	output reg Y3
);

	// State encoding
	parameter A = 6'b000001;
	parameter B = 6'b000010;
	parameter C = 6'b000100;
	parameter D = 6'b001000;
	parameter E = 6'b010000;
	parameter F = 6'b100000;

	always @(*) begin
		case (y)
			A: begin
				if (w)
					Y1 = 1; // Transition from A to B
				else
					Y1 = 0; // Stay in A
			end
			B: begin
				if (w)
					Y1 = 0; // Transition from B to C
				else
					Y1 = 0; // Transition from B to D
			end
			C: begin
				if (w)
					Y1 = 0; // Transition from C to E
				else
					Y1 = 0; // Transition from C to D
			end
			D: begin
				if (w)
					Y1 = 0; // Transition from D to F
				else
					Y1 = 1; // Transition from D to A
			end
			E: begin
				if (w)
					Y1 = 0; // Stay in E
				else
					Y1 = 0; // Transition from E to D
			end
			F: begin
				if (w)
					Y1 = 0; // Transition from F to C
				else
					Y1 = 0; // Transition from F to D
			end
			default: Y1 = 0;
		endcase
	end

	always @(*) begin
		case (y)
			A: begin
				if (w)
					Y3 = 0; // Transition from A to B
				else
					Y3 = 0; // Stay in A
			end
			B: begin
				if (w)
					Y3 = 0; // Transition from B to C
				else
					Y3 = 1; // Transition from B to D
			end
			C: begin
				if (w)
					Y3 = 0; // Transition from C to E
				else
					Y3 = 1; // Transition from C to D
			end
			D: begin
				if (w)
					Y3 = 1; // Transition from D to F
				else
					Y3 = 0; // Transition from D to A
			end
			E: begin
				if (w)
					Y3 = 0; // Stay in E
				else
					Y3 = 1; // Transition from E to D
			end
			F: begin
				if (w)
					Y3 = 1; // Transition from F to C
				else
					Y3 = 1; // Transition from F to D
			end
			default: Y3 = 0;
		endcase
	end

endmodule
