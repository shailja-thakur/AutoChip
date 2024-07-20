module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [0:0] {
		OFF = 1'b0,
		ON = 1'b1
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			OFF: begin
				out = 0;
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				out = 1;
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: begin
				next_state = OFF;
			end
		endcase
	 end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset)
			state <= OFF;
		else
			state <= next_state;
	end
endmodule
