module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state; // state register

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b01; // Set initial state to B
	end else begin
		case(state)
			2'b00: begin // State B
				if (in) begin
					state <= 2'b01; // Transition to state A if input is 0
				end
			end
			2'b01: begin // State A
				if (!in) begin
					state <= 2'b00; // Transition to state B if input is 1
				end
			end
		endcase
	end
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is 1 in state A, 0 in state B

endmodule
