module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b00; // Reset the state to A
	end else begin
		case (state)
			2'b00: begin // State A
				if (j) begin
					state <= 2'b01; // Next state is B
				end
			end
			
			2'b01: begin // State B
				if (k) begin
					state <= 2'b00; // Next state is A
				end
			end
		endcase
	end
end

always @(state) begin
	if (state == 2'b00) // State A
		out <= 1'b0;
	else // State B
		out <= 1'b1;
end

endmodule
