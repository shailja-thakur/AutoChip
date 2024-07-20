module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
reg [23:0] out_bytes_reg;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= 0;
	else begin
		case(state)
			0: begin // BYTE1 state
				if (in[2] == 1)
					state <= 1; // transition to BYTE2
				else
					state <= 0; // transition to itself
			end
			1: begin // BYTE2 state
				state <= 2; // transition to BYTE3
			end
			2: begin // BYTE3 state
				state <= 3; // transition to DONE
			end
			3: begin // DONE state
				if (in[2] == 0)
					state <= 0; // transition back to BYTE1
				else
					state <= 3; // stay in DONE
			end
		endcase
	end
end

always @(posedge clk) begin
	if (state == 3)
		out_bytes_reg <= in;
	else
		out_bytes_reg <= {out_bytes_reg[15:0], in};
end

assign out_bytes = out_bytes_reg;
assign done = (state == 3);

endmodule
