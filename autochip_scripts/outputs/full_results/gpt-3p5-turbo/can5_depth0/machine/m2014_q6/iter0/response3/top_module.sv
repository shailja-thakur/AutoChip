module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state, next_state;

// State assignments
parameter A = 3'b000; // State A
parameter B = 3'b001; // State B
parameter C = 3'b010; // State C
parameter D = 3'b011; // State D
parameter E = 3'b100; // State E
parameter F = 3'b101; // State F

// Outputs
assign z = (state == E || state == F) ? 1'b1 : 1'b0;

// State transitions
always @(posedge clk) begin
	if(reset) begin
		state <= A; // Reset state to A
	end else begin
		state <= next_state; // Transition to next state
	end
end

// State transition logic
always @(state, w) begin
	case(state)
		A: begin
			if(w) begin
				next_state <= A; // Transition to A
			end else begin
				next_state <= B; // Transition to B
			end
		end
		B: begin
			if(w) begin
				next_state <= D; // Transition to D
			end else begin
				next_state <= C; // Transition to C
			end
		end
		C: begin
			if(w) begin
				next_state <= D; // Transition to D
			end else begin
				next_state <= E; // Transition to E
			end
		end
		D: begin
			if(w) begin
				next_state <= A; // Transition to A
			end else begin
				next_state <= F; // Transition to F
			end
		end
		E: begin
			if(w) begin
				next_state <= D; // Transition to D
			end else begin
				next_state <= E; // Transition to E
			end
		end
		F: begin
			if(w) begin
				next_state <= D; // Transition to D
			end else begin
				next_state <= C; // Transition to C
			end
		end
	endcase
end

endmodule
