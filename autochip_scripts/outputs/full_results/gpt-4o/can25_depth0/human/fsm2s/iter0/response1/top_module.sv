module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);
	// State encoding
	typedef enum reg [1:0] {
		OFF = 2'd0,
		ON = 2'd1
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case(state)
			OFF: begin
				out = 1'b0;
				if (j == 1)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				out = 1'b1;
				if (k == 1)
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
