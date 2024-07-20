module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg state;
reg [7:0] counter;
reg [7:0] result;
reg [7:0] xt;
reg z;

// State definition
parameter S_INIT = 1'b0;
parameter S_COMPLEMENT = 1'b1;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		// Reset state and counters
		state <= S_INIT;
		counter <= 8'b0;
		result <= 8'b0;
		xt <= 8'b0;
		z <= 1'b0;
	end else begin
		case (state)
			S_INIT: begin
				// Wait for Reset release
				if (!areset && x) begin
					state <= S_COMPLEMENT;
					xt <= x;
				end
			end

			S_COMPLEMENT: begin
				// Compute 2's complement of input
				if (counter == 8'b11111111) begin
					state <= S_INIT;
					z <= result + 1;
				end else begin
					result <= result + (xt ^ 8'b11111111) + 1;
					counter <= counter + 1;
				end
			end
		endcase
	end
end

endmodule
