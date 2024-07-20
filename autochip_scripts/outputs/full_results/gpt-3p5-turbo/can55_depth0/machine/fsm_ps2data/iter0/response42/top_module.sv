module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [2:0] state;
reg [23:0] out_bytes_reg;
reg done_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 3'b000;
		out_bytes_reg <= 0;
		done_reg <= 0;
	end
	else begin
		case (state)
			3'b000: begin // BYTE1
				if (in[2] == 1'b1)
					state <= 3'b001; // BYTE2
				else
					state <= 3'b000;
			end

			3'b001: begin // BYTE2
				state <= 3'b010; // BYTE3
			end

			3'b010: begin // BYTE3
				state <= 3'b011; // DONE
			end

			3'b011: begin // DONE
				if (in[2] == 1'b0)
					state <= 3'b000; // BYTE1
				else
					state <= 3'b011;
			end
		endcase
	end
end

always @(posedge clk) begin
	if (reset)
		out_bytes_reg <= 0;
	else if (state == 3'b011)
		out_bytes_reg <= out_bytes_reg;
	else
		out_bytes_reg <= {out_bytes_reg[15:0], in};
end

assign out_bytes = out_bytes_reg;
assign done = (state == 3'b011) ? 1'b1 : 1'b0;

endmodule
