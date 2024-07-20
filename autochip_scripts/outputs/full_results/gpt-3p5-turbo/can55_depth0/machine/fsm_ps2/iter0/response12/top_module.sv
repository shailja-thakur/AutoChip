module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [3:0] state;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 4'b0001;
	else begin
		case(state)
			4'b0001: begin // BYTE1 state
				if (in[2] == 1'b1)
					state <= 4'b0010;
				else
					state <= 4'b0001;
			end
			4'b0010: begin // BYTE2 state
				state <= 4'b0011;
			end
			4'b0011: begin // BYTE3 state
				state <= 4'b0100;
			end
			4'b0100: begin // DONE state
				if (in[2] == 1'b0)
					state <= 4'b0001;
				else
					state <= 4'b0010;
			end
		endcase
	end
end

assign done = (state == 4'b0100);

endmodule
