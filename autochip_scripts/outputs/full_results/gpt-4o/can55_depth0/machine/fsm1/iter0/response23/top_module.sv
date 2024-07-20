module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	// State declarations
	reg state, next_state;
	localparam A = 1'b0, B = 1'b1;

	// State transition logic
	always @(*) begin
		case (state)
			A: if (in)
					next_state = A;
				else
					next_state = B;
			B: if (in)
					next_state = B;
				else
					next_state = A;
			default: next_state = B;
		endcase
	end

	// State register update
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else
			state <= next_state;
	end

	// Output logic
	always @(*) begin
		if (state == B)
			out = 1;
		else
			out = 0;
	end

endmodule
