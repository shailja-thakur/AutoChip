module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	// State declaration
	reg [1:0] state, next_state;

	// State assignments
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b01;
		else
			state <= next_state;
	end

	// Next state and output logic
	always @(state, in) begin
		case (state)
			2'b00: begin // State A
				if (in)
					next_state = 2'b00;
				else
					next_state = 2'b01;
				out = 1'b0;
			end
			2'b01: begin // State B
				if (in)
					next_state = 2'b00;
				else
					next_state = 2'b01;
				out = 1'b1;
			end
			default: begin
				next_state = 2'b01;
				out = 1'b1;
			end
		endcase
	end

endmodule
