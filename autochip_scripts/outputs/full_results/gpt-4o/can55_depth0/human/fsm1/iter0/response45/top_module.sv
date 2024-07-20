module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg state, next_state;
	
	// State encoding
	localparam A = 1'b0;
	localparam B = 1'b1;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;     // Asynchronously reset to state B
		else
			state <= next_state;
	end

	always @(*) begin
		case (state)
			A: begin
				if (in)
					next_state = A;
				else
					next_state = B;
				out = 1'b0;
			end
			B: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out = 1'b1;
			end
		endcase
	end

endmodule
