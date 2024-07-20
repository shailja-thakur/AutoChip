module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b0;
		else
			state <= next_state;
	end

	always @(state, j, k) begin
		case(state)
			2'b00: begin    // State A
				if (j)
					next_state <= 2'b01;    // Next state is B
				else
					next_state <= 2'b00;    // Next state is A
			end
			2'b01: begin    // State B
				if (k)
					next_state <= 2'b00;    // Next state is A
				else
					next_state <= 2'b01;    // Next state is B
			end
			default: next_state <= 2'b00;    // Default case, state A
		endcase
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
