module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define state encoding
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01,
		C = 2'b10,
		D = 2'b11
	} state_t;

	state_t state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			A: if (in) next_state = B; else next_state = A;
			B: if (in) next_state = B; else next_state = C;
			C: if (in) next_state = D; else next_state = A;
			D: if (in) next_state = B; else next_state = C;
			default: next_state = A;
		endcase
	end

	// State register logic (sequential)
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		out = (state == D) ? 1 : 0;
		end
		
endmodule
