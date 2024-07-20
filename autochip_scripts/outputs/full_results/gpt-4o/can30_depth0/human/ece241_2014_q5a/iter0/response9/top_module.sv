module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg state, next_state;
	localparam IDLE = 1'b0, NEGATE = 1'b1;

	always @ (posedge clk or posedge areset) begin
		if (areset)
			state <= IDLE;
		else
			state <= next_state;
	end

	always @(*) begin
		case (state)
			IDLE: begin
				if (x == 1'b0)
					next_state = IDLE;
				else
					next_state = NEGATE;
                z = x; // Output the same input in the IDLE state, since it hasn't been negated yet
			end
			NEGATE: begin
				next_state = NEGATE; // Stay in NEGATE state once transitioned
				z = ~x; // Output the negated bit
			end
			default: begin
				next_state = IDLE;
				z = 1'b0;
			end
		endcase
	end
endmodule
