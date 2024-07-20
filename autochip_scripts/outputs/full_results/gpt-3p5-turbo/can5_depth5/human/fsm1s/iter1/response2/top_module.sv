module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b1; // Reset state B
		end else begin
			state <= next_state;
		end
	end
	
	always @(state, in) begin
		case (state)
			2'b01: begin // State B
				if (in) begin
					next_state <= 2'b01; // Stay in state B
				end else begin
					next_state <= 2'b00; // Transition to state A
				end
			end
			2'b00: begin // State A
				if (in) begin
					next_state <= 2'b00; // Stay in state A
				end else begin
					next_state <= 2'b01; // Transition to state B
				end
			end
			default: begin
				next_state <= 2'b01; // Default state is B
			end
		endcase
	end
	
	assign out = (state == 2'b00) ? 1'b0 : 1'b1; // Output is 0 in state A, 1 in state B

endmodule
