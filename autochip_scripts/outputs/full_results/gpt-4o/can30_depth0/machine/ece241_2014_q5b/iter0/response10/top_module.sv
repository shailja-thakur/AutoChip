module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);
	// Define states
	localparam A = 1'b0;
	localparam B = 1'b1;

	// State register
	reg state, next_state;

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				next_state = B;
			end
			default: next_state = A;
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			A: z = x ? 1'b1 : 1'b0;
			B: z = x ? 1'b0 : 1'b1;
			default: z = 1'b0;
		endcase
	end

	// State register update
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

endmodule
