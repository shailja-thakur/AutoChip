module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [0:0] {
		OFF = 1'b0,
		ON = 1'b1
	} state_t;

	state_t state, next_state;

	// State transition logic (combinational)
	always @(*) begin
		case (state)
			OFF: if (j) next_state = ON; else next_state = OFF;
			ON: if (k) next_state = OFF; else next_state = ON;
			default: next_state = OFF;
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end

	// Output logic (Moore)
	always @(*) begin
		case(state)
			OFF: out = 1'b0;
			ON: out = 1'b1;
			default: out = 1'b0;
		endcase
	end
endmodule
