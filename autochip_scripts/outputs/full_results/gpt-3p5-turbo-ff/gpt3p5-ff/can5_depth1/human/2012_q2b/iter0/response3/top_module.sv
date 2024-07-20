module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);
	
	// State Definitions
	parameter A = 6'b000001;
	parameter B = 6'b000010;
	parameter C = 6'b000100;
	parameter D = 6'b001000;
	parameter E = 6'b010000;
	parameter F = 6'b100000;

	// Next State Logic
	always @* begin
		case(y)
			// A Transitions
			A: begin
				if(w)
					y_next = B;
				else
					y_next = A;
			end
			
			// B Transitions
			B: begin
				if(w)
					y_next = C;
				else
					y_next = D;
			end
			
			// C Transitions
			C: begin
				if(w)
					y_next = E;
				else
					y_next = D;
			end
			
			// D Transitions
			D: begin
				if(w)
					y_next = F;
				else
					y_next = A;
			end
			
			// E Transitions
			E: begin
				if(w)
					y_next = E;
				else
					y_next = D;
			end
			
			// F Transitions
			F: begin
				if(w)
					y_next = C;
				else
					y_next = D;
			end
		endcase
	end

	// State Flip-Flops
	always @(posedge clk) begin
		y <= y_next;
	end

	// Output Signals
	assign Y1 = y[1];
	assign Y3 = y[3];

endmodule
