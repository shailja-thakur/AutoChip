module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

// State enumeration
typedef enum logic[2:0] {S_A, S_B, S_C, S_D, S_E, S_F} state_t;

// State and next state variables
reg state_reg, next_state_reg;

// State assignment
always_ff @(posedge clk, posedge reset) begin
	if (reset) begin
		state_reg <= S_A; // Reset to state A
	end
	else begin
		state_reg <= next_state_reg; // Update state
	end
end

// Next state logic
always_comb begin
	case (state_reg)
		S_A: if (w) next_state_reg = S_A; else next_state_reg = S_B;
		S_B: if (w) next_state_reg = S_D; else next_state_reg = S_C;
		S_C: if (w) next_state_reg = S_D; else next_state_reg = S_E;
		S_D: if (w) next_state_reg = S_A; else next_state_reg = S_F;
		S_E: if (w) next_state_reg = S_D; else next_state_reg = S_E;
		S_F: if (w) next_state_reg = S_D; else next_state_reg = S_C;
	endcase
end

// Output assignment
always_comb begin
	case (state_reg)
		S_E, S_F: z = 1'b1; // Set z to high when in state E or F
		default: z = 1'b0; // Set z to low otherwise
	endcase
end

endmodule
