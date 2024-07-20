module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

reg [1:0] state, next_state;

// FSM states
parameter A = 2'd0; // Beginning state
parameter B = 2'd1; // State after reset
parameter C = 2'd2; // State after f = 1
parameter D = 2'd3; // State after monitoring x
parameter E = 2'd4; // State after g = 1
parameter F = 2'd5; // State after monitoring y

// Outputs
assign f = (state == C);
assign g = (state == E || state == F);

// Next state logic
always @(posedge clk or negedge resetn) begin
	if (~resetn) begin
		state <= A; // Reset state
	end else begin
		case (state)
			A: begin
				if (resetn) begin
					state <= B; // Transition to B on reset de-assertion
				end
			end
			B: begin
				state <= C; // Transition to C after one clock cycle
			end
			C: begin
				state <= D; // Transition to D after setting f = 1 for one clock cycle
			end
			D: begin
				if (x == 2'b101) begin
					state <= E; // Transition to E after monitoring x = 101
				end
			end
			E: begin
				if (~resetn) begin
					state <= A; // Transition to A on reset assertion
				end else if (y == 1'b1) begin
					state <= F; // Transition to F after monitoring y = 1
				end
			end
			F: begin
				if (~resetn) begin
					state <= A; // Transition to A on reset assertion
				end
			end
		endcase
	end
end

// Initial state
always @(*) begin
	if (~resetn) begin
		state = A; // Set initial state to A on reset assertion
	end
end

endmodule
