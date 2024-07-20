module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// Define the states
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter D = 3;
parameter E = 4;
parameter F = 5;

reg [2:0] state, next_state;

always @(posedge clk) begin
	if (reset) // Reset
		state <= A;
	else
		state <= next_state; // Transition to next state
end

always @(state, w) begin
	case (state)
		A: begin
			if (w == 0)
				next_state <= B;
			else
				next_state <= A;
		end
		B: begin
			if (w == 1)
				next_state <= D;
			else
				next_state <= C;
		end
		C: begin
			if (w == 1)
				next_state <= D;
			else
				next_state <= E;
		end
		D: begin
			if (w == 1)
				next_state <= A;
			else
				next_state <= F;
		end
		E: begin
			if (w == 1)
				next_state <= D;
			else
				next_state <= E;
		end
		F: begin
			if (w == 1)
				next_state <= D;
			else
				next_state <= C;
		end
		default: next_state <= A;
	endcase
end

assign z = (state == E || state == F) ? 1'b1 : 1'b0;

endmodule
