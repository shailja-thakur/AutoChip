module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// Define states as constants
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// Define state variable
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A; // Initialize state to A
	end else begin
		// State transition logic
		case (state)
			A: if (s) state <= B;
			B, C: if (w) state <= S11; else state <= S10;
			S10: if (w) state <= S21; else state <= S20;
			S11: if (w) state <= S22; else state <= S21;
			S20: state <= B;
			S21: if (w) state <= C; else state <= B;
			S22: if (w) state <= B; else state <= C;
		endcase
	end
end

// Output logic
always @(state) begin
	case (state)
		A: z <= 0;
		B, S20, S22: z <= 1;
		C: z <= 0;
		S10, S11, S21: z <= 0;
	endcase
end

endmodule
