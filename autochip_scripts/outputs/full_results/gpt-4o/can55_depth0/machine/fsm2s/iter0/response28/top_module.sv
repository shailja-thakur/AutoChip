module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	localparam STATE_A = 1'b0;
	localparam STATE_B = 1'b1;

	reg state, next_state;

	// State transition logic
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
			default: next_state = STATE_A; // Default case to handle unexpected scenarios
		endcase
	end

	// State update and output logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= STATE_A;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		case (state)
			STATE_A: out = 1'b0;
			STATE_B: out = 1'b1;
			default: out = 1'b0; // Default case to handle unexpected scenarios
		endcase
	end

endmodule
