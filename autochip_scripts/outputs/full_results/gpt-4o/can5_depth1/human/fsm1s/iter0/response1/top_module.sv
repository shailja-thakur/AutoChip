module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State declarations
	typedef enum reg [1:0] {A=2'b00, B=2'b01} state_t;
	state_t state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= B;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: if (in) next_state = A;
			   else next_state = B;
			B: if (in) next_state = B;
			   else next_state = A;
			default: next_state = B;  // Handle default case to ensure determinism
		endcase
	end

	// Output logic
	always @(state) begin
		case (state)
			A: out = 0;
			B: out = 1;
			default: out = 1;  // Handle default case to ensure determinism
		endcase
	end

endmodule
