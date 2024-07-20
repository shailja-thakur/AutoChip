module top_module (
	input clk,
	input reset,
	input w,
	output reg z
);

	// State declarations
	typedef enum reg [2:0] {A, B, C, D, E, F} state_t;
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			A: next_state = (w == 1'b0) ? B : A;
			B: next_state = (w == 1'b1) ? D : C;
			C: next_state = (w == 1'b1) ? D : E;
			D: next_state = (w == 1'b1) ? A : F;
			E: next_state = (w == 1'b1) ? D : E;
			F: next_state = (w == 1'b1) ? D : C;
			default: next_state = A; // Default case to handle undefined states
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
		end
		

	// Output logic
	always @(*) begin
		case (state)
			E: z = 1'b1;
			F: z = 1'b1;
			default: z = 1'b0;
		endcase
	end

endmodule
