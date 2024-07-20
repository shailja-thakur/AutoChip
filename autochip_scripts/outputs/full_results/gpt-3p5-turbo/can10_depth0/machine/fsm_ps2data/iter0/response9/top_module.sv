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
		if (reset) begin
			state <= BYTE1;
			out_bytes_reg <= 0;
		end else begin
			case (state)
				BYTE1:
					if (in[2]) begin
						state <= BYTE2;
					end else begin
						state <= BYTE1;
						out_bytes_reg <= {out_bytes_reg[15:0], in};
					end
				BYTE2:
					state <= BYTE3;
				BYTE3:
					if (in[2]) begin
						state <= DONE;
					end else begin
						state <= BYTE1;
						out_bytes_reg <= {out_bytes_reg[15:0], in};
					end
				DONE:
					state <= BYTE1;
					out_bytes_reg <= {out_bytes_reg[15:0], in};
			endcase
		end
	end

	assign out_bytes = out_bytes_reg;
	assign done = (state == DONE);

endmodule
