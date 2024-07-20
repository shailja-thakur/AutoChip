module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; // initial state A
		end else begin
			state <= next_state;
		end
	end

	always @* begin
		next_state = state; // default next state is current state

		case (state)
			2'b00: begin // state A
				if (in) begin
					next_state = 2'b01; // change to state B
				end
			end

			2'b01: begin // state B
				if (in) begin
					next_state = 2'b01; // stay in state B
				end else begin
					next_state = 2'b10; // change to state C
				end
			end

			2'b10: begin // state C
				if (in) begin
					next_state = 2'b11; // change to state D
				end else begin
					next_state = 2'b00; // change to state A
				end
			end

			2'b11: begin // state D
				if (in) begin
					next_state = 2'b01; // change to state B
				end else begin
					next_state = 2'b10; // change to state C
				end
			end
		endcase
	end

	assign out = (state == 2'b11); // out is 1 when state is D

endmodule
