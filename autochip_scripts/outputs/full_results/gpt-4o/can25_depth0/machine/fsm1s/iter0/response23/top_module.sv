module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// Define state parameters
	parameter STATE_A = 1'b0;
	parameter STATE_B = 1'b1;
	
	// State register
	reg state, next_state;

	// Combinational logic block to determine next state
	always @(*) begin
		case (state)
			STATE_A: next_state = (in) ? STATE_A : STATE_B;
			STATE_B: next_state = (in) ? STATE_B : STATE_A;
			default: next_state = STATE_B; // default to state B on reset or any unknown state
		endcase
	end

	// Sequential logic block, triggered on the rising edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= STATE_B;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(state) begin
		out = (state == STATE_B);
	end

endmodule
