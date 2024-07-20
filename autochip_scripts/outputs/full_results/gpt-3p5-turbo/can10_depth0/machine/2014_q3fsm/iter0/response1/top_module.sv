module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// state encoding
parameter A = 0;   // initial state
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

always @(state or s or w) begin
	case (state)
		A: begin
			if (s)
				next_state = B;
			else
				next_state = A;
		end
		
		B: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		
		C: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		
		S10: begin
			if (w)
				next_state = S21;
			else
				next_state = S20;
		end
		
		S11: begin
			if (w)
				next_state = S22;
			else
				next_state = S21;
		end
		
		S20: next_state = B;
		
		S21: begin
			if (w)
				next_state = C;
			else
				next_state = B;
		end
		
		S22: begin
			if (w)
				next_state = B;
			else
				next_state = C;
		end
	endcase
end

always @(posedge clk or posedge reset) begin
	if (reset)
		z <= 0;
	else begin
		case (state)
			A, B, C: z <= 0;
			S10, S11, S20, S21, S22: z <= 1;
		endcase
	end
end

endmodule
