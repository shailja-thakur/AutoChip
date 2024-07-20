module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] out_reg;

always @(posedge clk) begin
	if (reset) begin
		state <= BYTE1;
		out_reg <= 0;
	end else begin
		case (state)
			BYTE1: begin
				if (in[2] == 1)
					state <= BYTE2;
				else
					state <= BYTE1;
			end
			BYTE2: begin
				state <= BYTE3;
			end
			BYTE3: begin
				state <= DONE;
			end
			DONE: begin
				if (in[2] == 0)
					state <= BYTE1;
			end
		endcase
		if (state == DONE)
			out_reg <= in;
		else
			out_reg <= {out_reg[15:0], in};
	end
end

assign out_bytes = out_reg;
assign done = (state == DONE);

endmodule
