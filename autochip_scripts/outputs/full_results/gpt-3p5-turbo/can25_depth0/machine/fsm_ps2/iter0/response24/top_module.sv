module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [1:0] state;
reg done;

always @(posedge clk, posedge reset) begin
	if (reset)
		state <= 2'b00;
	else
		case (state)
			2'b00: begin // BYTE1 state
				if (in[2])
					state <= 2'b01; // transition to BYTE2 state
				else
					state <= 2'b00; // remain in BYTE1 state
			end
			2'b01: begin // BYTE2 state
				state <= 2'b10; // transition to BYTE3 state
			end
			2'b10: begin // BYTE3 state
				state <= 2'b11; // transition to DONE state
			end
			2'b11: begin // DONE state
				if (in[2])
					state <= 2'b01; // transition to BYTE2 state
				else
					state <= 2'b00; // transition to BYTE1 state
			end
		endcase
	end

	assign done = (state == 2'b11);
endmodule
