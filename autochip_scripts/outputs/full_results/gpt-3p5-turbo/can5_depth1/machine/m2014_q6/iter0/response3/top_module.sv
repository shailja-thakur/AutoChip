module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// Declare state enumeration
typedef enum logic [2:0] {
	A, B, C, D, E, F
} state_t;

// Declare state register
reg [2:0] current_state, next_state;

// State transition logic
always @(posedge clk, posedge reset) begin
	if (reset)
		current_state <= A;
	else
		current_state <= next_state;
end

// Next state logic
always @(current_state, w) begin
	case (current_state)
		A: if (w) next_state <= A; else next_state <= B;
		B: if (w) next_state <= D; else next_state <= C;
		C: if (w) next_state <= D; else next_state <= E;
		D: if (w) next_state <= A; else next_state <= F;
		E: if (w) next_state <= D; else next_state <= E;
		F: if (w) next_state <= D; else next_state <= C;
		default: next_state <= A;
	endcase
end

// Output logic
always @(current_state) begin
	case (current_state)
		E, F: z <= 1'b1;
		default: z <= 1'b0;
	endcase
end

endmodule
