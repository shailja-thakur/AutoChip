module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// Define state encoding
	reg state, next_state;
	
	localparam STATE_A = 1'b0;
	localparam STATE_B = 1'b1;

	// State transition logic
	always @(*) begin
		case (state)
			STATE_A: begin
				if (in) 
					next_state = STATE_A;
				else 
					next_state = STATE_B;
			end
			STATE_B: begin
				if (in)
					next_state = STATE_B;
				else
					next_state = STATE_A;
			end
			default: next_state = STATE_B;
		endcase
	end
	
	// State register update on clock edge or reset
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		if (state == STATE_B)
			out = 1'b1;
		else
			out = 1'b0;
	end

endmodule
