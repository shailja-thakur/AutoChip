module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// state codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// state flip-flops
	reg [1:0] state_d, state_q;
	
	// state transition logic
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state_q <= A;
		else
			state_q <= state_d;
	end
	
	// state table
	always @(state_q or w)
	begin
		case (state_q)
			A: begin
				if (w)
					state_d <= B;
				else
					state_d <= A;
			end
			B: begin
				if (w)
					state_d <= C;
				else
					state_d <= D;
			end
			C: begin
				if (w)
					state_d <= E;
				else
					state_d <= D;
			end
			D: begin
				if (w)
					state_d <= F;
				else
					state_d <= A;
			end
			E: begin
				if (w)
					state_d <= E;
				else
					state_d <= D;
			end
			F: begin
				if (w)
					state_d <= C;
				else
					state_d <= D;
			end
		endcase
	end
	
	// FSM output
	always @(state_q)
	begin
		case (state_q)
			A, D: z = 0;
			E, F: z = 1;
			default: z = 0;
		endcase
	end
	
endmodule
