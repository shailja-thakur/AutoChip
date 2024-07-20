module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// State encoding
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state_reg, state_next;
	
	// Output assignment
	always @(*) begin
		case(state_reg)
			A: z = (state_next == A) ? 0 : 1;
			B: z = (state_next == E) ? 1 : 0;
			C: z = 1;
			D: z = 0;
			E: z = (state_next == C) ? 1 : 0;
			F: z = (state_next == C) ? 1 : 0;
			default: z = 0;
		endcase
	end
	
	// State flip-flops
	always @(posedge clk, posedge reset) begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= state_next;
	end
	
	// State transitions
	always @(state_reg, w) begin
		case(state_reg)
			A: begin
				if (w)
					state_next = B;
				else
					state_next = A;
			end
			B: begin
				if (w)
					state_next = C;
				else
					state_next = D;
			end
			C: begin
				if (w)
					state_next = E;
				else
					state_next = D;
			end
			D: begin
				if (w)
					state_next = F;
				else
					state_next = A;
			end
			E: begin
				if (w)
					state_next = E;
				else
					state_next = D;
			end
			F: begin
				if (w)
					state_next = C;
				else
					state_next = D;
			end
			default: state_next = A;
		endcase
	end

endmodule
