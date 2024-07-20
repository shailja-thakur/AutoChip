module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state;
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;
		end else begin
			state <= next_state;
		end
	end

	always @(state, in) begin
		case (state)
			2'b00: begin // A state
				if (in) begin
					next_state = 2'b01; // Transition to B
					out = 1'b0; // Output is 0
				end else begin
					next_state = 2'b00; // Stay in A
					out = 1'b0; // Output is 0
				end
			end
			2'b01: begin // B state
				if (in) begin
					next_state = 2'b01; // Stay in B
					out = 1'b0; // Output is 0
				end else begin
					next_state = 2'b10; // Transition to C
					out = 1'b0; // Output is 0
				end
			end
			2'b10: begin // C state
				if (in) begin
					next_state = 2'b11; // Transition to D
					out = 1'b0; // Output is 0
				end else begin
					next_state = 2'b00; // Transition to A
					out = 1'b0; // Output is 0
				end
			end
			2'b11: begin // D state
				if (in) begin
					next_state = 2'b01; // Transition to B
					out = 1'b1; // Output is 1
				end else begin
					next_state = 2'b10; // Transition to C
					out = 1'b0; // Output is 0
				end
			end
		endcase
	end
endmodule
