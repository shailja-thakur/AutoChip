module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states
reg [3:0] state, next_state;

// State constants
parameter A = 4'b0000;
parameter B = 4'b0001;
parameter C = 4'b0010;
parameter S10 = 4'b0011;
parameter S11 = 4'b0100;
parameter S20 = 4'b0101;
parameter S21 = 4'b0110;
parameter S22 = 4'b0111;

// State transition logic
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

// Next state logic
always @* begin
	case (state)
		A:
			if (s)
				next_state = B;
			else
				next_state = state;
		B:
			if (w)
				next_state = S11;
			else
				next_state = S10;
		C:
			if (w)
				next_state = S11;
			else
				next_state = S10;
		S10:
			if (w)
				next_state = S21;
			else
				next_state = S20;
		S11:
			if (w)
				next_state = S22;
			else
				next_state = S21;
		S20:
			next_state = B;
		S21:
			if (w)
				next_state = C;
			else
				next_state = B;
		S22:
			if (w)
				next_state = B;
			else
				next_state = C;
	endcase
end

// Output logic
always @(state) begin
	case (state)
		A, S20, S22:
			z = 0;
		B, C, S10, S11, S21:
			z = 1;
	endcase
end

endmodule
