module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg state, next_state;
	
	localparam STATE_A = 1'b0;
	localparam STATE_B = 1'b1;

	// State transition on clock edge
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= STATE_A;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (j)
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
			STATE_B: begin
				if (k)
					next_state = STATE_A;
				else
					next_state = STATE_B;
			end
			default: next_state = STATE_A;  // Default case to handle unexpected state
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_A: out = 1'b0;
			STATE_B: out = 1'b1;
			default: out = 1'b0;  // Default output
		endcase
	end

endmodule
