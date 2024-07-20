module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg state, next_state;

	// State register
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 0;
		end else begin
			state <= next_state;
		end
	end

	// Assign next state based on current state and input
	always @(state, in) begin
		case (state)
			0: begin // State A
				if (in == 1'b1) begin
					next_state = 0;
				end else begin
					next_state = 1;
				end
			end

			1: begin // State B
				if (in == 1'b1) begin
					next_state = 1;
				end else begin
					next_state = 0;
				end
			end
		endcase
	end

	// Output assignment
	assign out = (state == 1) ? 1'b1 : 1'b0;

endmodule
