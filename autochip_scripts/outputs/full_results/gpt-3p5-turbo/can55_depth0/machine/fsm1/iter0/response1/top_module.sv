module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b1;
		end else begin
			state <= next_state;
		end
	end

	always @(state, in) begin
		case(state)
			2'b01: begin // State A
				if (in) begin
					next_state <= 2'b01; // Stay in state A
				end else begin
					next_state <= 2'b10; // Transition to state B
				end
			end
			2'b10: begin // State B
				if (in) begin
					next_state <= 2'b10; // Stay in state B
				end else begin
					next_state <= 2'b01; // Transition to state A
				end
			end
		endcase
	end

	assign out = (state == 2'b10) ? 1'b1 : 1'b0;

endmodule
