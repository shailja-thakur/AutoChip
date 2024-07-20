module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00; // Initialize state to A
		end else begin
			case(state)
				2'b00: begin // State A
					if (j) begin
						state <= 2'b01; // Transition to State B
					end
				end
				2'b01: begin // State B
					if (k) begin
						state <= 2'b00; // Transition to State A
					end
				end
			endcase
		end
	end

	always @(state) begin
		if (state == 2'b01) begin // State B
			out <= 1'b1; // Output is high
		end else begin // State A
			out <= 1'b0; // Output is low
		end
	end

endmodule
