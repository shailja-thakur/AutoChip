module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 3'b000; // start in BYTE1 state
	else begin
		case (state)
			3'b000: begin // BYTE1 state
				if (in[2] == 1'b1)
					state <= 3'b001; // transition to BYTE2 state
				else
					state <= 3'b000; // remain in BYTE1 state
			end
			3'b001: begin // BYTE2 state
				state <= 3'b010; // transition to BYTE3 state
			end
			3'b010: begin // BYTE3 state
				state <= 3'b011; // transition to DONE state
			end
			3'b011: begin // DONE state
				if (in[2] == 1'b1)
					state <= 3'b001; // transition to BYTE2 state
				else
					state <= 3'b000; // transition to BYTE1 state
			end
			default: state <= 3'b000; // default to BYTE1 state
		endcase
	end
end

always @(state) begin
	if (state == 3'b011)
		done = 1'b1; // assert done signal in DONE state
	else
		done = 1'b0; // deassert done signal in other states
end

endmodule
