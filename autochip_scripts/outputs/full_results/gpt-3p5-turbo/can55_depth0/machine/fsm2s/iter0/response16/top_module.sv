module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b0; // Initialize state to A
		end else begin
			state <= next_state;
		end
	end

	always @(state or j or k) begin
		case (state)
			2'b00: begin // State A
				if (j) begin
					next_state = 2'b1; // Transition to State B
				end else begin
					next_state = 2'b0; // Remain in State A
				end
			end
			2'b01: begin // State B
				if (k) begin
					next_state = 2'b0; // Transition to State A
				end else begin
					next_state = 2'b1; // Remain in State B
				end
			end
			default: next_state = 2'b0; // Default to State A
		endcase
	end

	always @(state) begin
		if (state == 2'b01) begin
			out = 1'b1; // Output high when in State B
		end else begin
			out = 1'b0; // Output low when in State A
		end
	end

endmodule
