module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
		end else begin
			if (state == 0) begin // State A
				if (j) begin
					state <= 1; // Transition to State B
				end
			end else begin // State B
				if (k) begin
					state <= 0; // Transition to State A
				end
			end
		end
	end
	
	always @(state) begin
		if (state == 1) begin // State B
			out <= 1;
		end else begin // State A
			out <= 0;
		end
	end

endmodule
