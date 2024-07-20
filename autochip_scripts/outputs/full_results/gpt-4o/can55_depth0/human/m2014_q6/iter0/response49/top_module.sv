module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	typedef enum reg [2:0] {
        state_A = 3'b000,
        state_B = 3'b001,
        state_C = 3'b010,
        state_D = 3'b011,
        state_E = 3'b100,
        state_F = 3'b101
    } state_t;
    
    state_t state, next_state;

	// State Transition
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= state_A;
		else
			state <= next_state;
	end

	// Next State Logic
	always @(*) begin
		case (state)
			state_A: next_state = (w) ? state_A : state_B;
			state_B: next_state = (w) ? state_D : state_C;
			state_C: next_state = (w) ? state_D : state_E;
			state_D: next_state = (w) ? state_A : state_F;
			state_E: next_state = (w) ? state_D : state_E;
			state_F: next_state = (w) ? state_D : state_C;
			default: next_state = state_A; // Default state
		endcase
	end

	// Output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			z <= 1'b0;
		else begin
            case (state)
                state_E, state_F: z <= 1'b1;
                default: z <= 1'b0;
            endcase
        end
	end
endmodule
