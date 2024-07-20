module top_module (
	input clk,
	input in,
	input reset,
	output out
);

reg [1:0] state;
wire set_out;

always @(posedge clk) begin
	if (reset) begin
		state <= 2'b01; // B state
	end else begin
		case(state)
			2'b00: // A state
				if (in) begin
					state <= 2'b00; // Stay in A state
				end else begin
					state <= 2'b01; // Transition to B state
				end
			2'b01: // B state
				if (in) begin
					state <= 2'b01; // Stay in B state
				end else begin
					state <= 2'b00; // Transition to A state
				end
		endcase
	end
end

assign set_out = (state == 2'b00) ? 1'b0 : 1'b1; // Output 0 in A state, 1 in B state

assign out = set_out;

endmodule
