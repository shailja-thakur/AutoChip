module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
	end else begin
		case (state)
			0: begin // Idle state
				if (in[3] == 1) begin
					state <= 1; // Transition to byte 1 state
				end
			end
			1: begin // Byte 1 state
				state <= 2; // Transition to byte 2 state
			end
			2: begin // Byte 2 state
				state <= 3; // Transition to byte 3 state
			end
			3: begin // Byte 3 state
				state <= 0; // Transition back to idle state
			end
		endcase
	end
end

assign done = (state == 3);

endmodule
