module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output reg out
);

reg [1:0] state; // Two bit register to store the state

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= 2'b0; // Reset state to OFF
	else begin
		case (state)
			2'b00: begin // OFF State
				if (j)
					state <= 2'b01; // Transition to ON state if j = 1
				else
					state <= 2'b00; // Remain in OFF state if j = 0
			end
			2'b01: begin // ON State
				if (k)
					state <= 2'b00; // Transition to OFF state if k = 1
				else
					state <= 2'b01; // Remain in ON state if k = 0
			end
		endcase
	end
end

always @(state) begin
	case (state)
		2'b00: out = 1'b0; // OFF state, output is 0
		2'b01: out = 1'b1; // ON state, output is 1
	endcase
end

endmodule
