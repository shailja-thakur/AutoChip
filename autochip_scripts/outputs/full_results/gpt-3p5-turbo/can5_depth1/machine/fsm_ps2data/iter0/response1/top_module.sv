module top_module (
	input clk,
	input reset,
	input [7:0] in,
	output done,
	output [23:0] out_bytes
);
	reg [23:0] out_bytes_reg;
	reg [1:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out_bytes_reg <= 0;
			state <= 2'b00;
		end else begin
			case (state)
				2'b00: begin
					if (in[2] == 1) begin
						state <= 2'b01;
					end else begin
						out_bytes_reg <= {out_bytes_reg[15:0], in};
						state <= 2'b00;
					end
				end
				2'b01: begin
					out_bytes_reg <= {out_bytes_reg[15:0], in};
					state <= 2'b10;
				end
				2'b10: begin
					out_bytes_reg <= {out_bytes_reg[15:0], in};
					if (in[2] == 1) begin
						state <= 2'b11;
					end else begin
						state <= 2'b00;
					end
				end
				2'b11: begin
					out_bytes_reg <= {out_bytes_reg[15:0], in};
					state <= 2'b00;
				end
			endcase
		end
	end

	assign done = (state == 2'b11);
	assign out_bytes = (done) ? out_bytes_reg : 0;

endmodule
