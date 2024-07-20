module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// State encoding
	typedef enum reg [1:0] {
		S0, // Initial state
		S1, // State after detecting '1'
		S2  // State after detecting '10'
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
				z = 1'b0;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S2;
				z = 1'b0;
			end
			S2: begin
				if (x) begin
					next_state = S1;
					z = 1'b1;
				end else begin
					next_state = S0;
					z = 1'b0;
				end
			end
			default: begin
				next_state = S0;
				z = 1'b0;
			end
		endcase
	end

	// State registers
	always @(negedge aresetn or posedge clk) begin
		if (!aresetn)
			state <= S0;
		else
			state <= next_state;
	end

endmodule
