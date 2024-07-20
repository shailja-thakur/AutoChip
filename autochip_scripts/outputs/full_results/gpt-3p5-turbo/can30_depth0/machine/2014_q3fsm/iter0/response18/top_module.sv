module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

parameter A = 0;
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

always @* begin
	next_state = state;
	case (state)
		A: if (s)
				next_state = B;
			else
				next_state = A;
			
		B: if (w)
				next_state = S11;
			else
				next_state = S10;
			
		C: if (w)
				next_state = S11;
			else
				next_state = S10;
			
		S10: if (w)
				next_state = S21;
			else
				next_state = S20;
			
		S11: if (w)
				next_state = S22;
			else
				next_state = S21;
			
		S20: next_state = B;
			
		S21: if (w)
				next_state = C;
			else
				next_state = B;
			
		S22: if (w)
				next_state = B;
			else
				next_state = C;
			
		default: next_state = A;
		
	endcase
end

always @(posedge clk or posedge reset) begin
	if (reset)
		z <= 0;
	else if (state == S10 || state == S20)
		z <= 1;
	else 
		z <= 0;
end

endmodule
