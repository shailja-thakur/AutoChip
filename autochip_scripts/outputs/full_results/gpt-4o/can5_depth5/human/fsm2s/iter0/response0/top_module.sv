module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	// State encoding
	typedef enum logic [1:0] {OFF = 2'b00, ON = 2'b01} state_t;
	state_t state, next_state;

	// Next state logic
	always @(*) begin
		case (state)
			OFF: next_state = j ? ON : OFF;
			ON:  next_state = k ? OFF : ON;
			default: next_state = OFF;
		endcase
	end

	// State transition logic
	always @(posedge clk) begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic
	always @(posedge clk) begin
		if (reset)
			out <= 0;
		else
			out <= (state == ON);
	end

endmodule
