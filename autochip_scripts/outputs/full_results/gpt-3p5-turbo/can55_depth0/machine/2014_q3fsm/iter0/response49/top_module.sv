module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// Define current_state and next_state registers
reg [2:0] current_state;
reg [2:0] next_state;

// Assign initial state
always @(posedge clk or posedge reset) begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end

// Assign next state based on current state and inputs
always @(current_state) begin
	case (current_state)
		A: if (s) next_state = B;
		B, C: if (w) next_state = S11; else next_state = S10;
		S10: if (w) next_state = S21; else next_state = S20;
		S11: if (w) next_state = S22; else next_state = S21;
		S20: next_state = B;
		S21: if (w) next_state = C; else next_state = B;
		S22: if (w) next_state = B; else next_state = C;
	endcase
end

// Assign output based on current state
always @(current_state) begin
	case (current_state)
		A, B, C, S20, S21, S22: z = 0;
		S10, S11: z = 1;
	endcase
end

endmodule
