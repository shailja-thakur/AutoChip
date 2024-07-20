module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b01; // reset to state B
	else begin
		case (state)
			2'b00: begin // State A, input '0'
				if (in)
					state <= 2'b01; // transition to state B
				else
					state <= 2'b00; // stay in state A
			end
			2'b01: begin // State B, input '1'
				if (in)
					state <= 2'b01; // stay in state B
				else
					state <= 2'b00; // transition to state A
			end
		endcase
	end
end

always @(state) begin
	case (state)
		2'b00: out = 0; // State A
		2'b01: out = 1; // State B
	endcase
end

endmodule
