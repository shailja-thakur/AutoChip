module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_reg;
	reg [1:0] state;
	wire third_bit;

	assign third_bit = in[2];

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= BYTE1;
			out_reg <= 0;
		end else begin
			case (state)
				BYTE1: begin
					if (third_bit) begin
						state <= BYTE2;
						out_reg <= {out_bytes[15:0], in};
					end else begin
						state <= BYTE1;
						out_reg <= {out_reg[15:0], in};
					end
				end
				BYTE2: begin
					if (third_bit) begin
						state <= BYTE3;
						out_reg <= {out_bytes[7:0], in};
					end else begin
						state <= BYTE1;
						out_reg <= {out_reg[7:0], in};
					end
				end
				BYTE3: begin
					if (third_bit) begin
						state <= DONE;
						out_reg <= {out_bytes[7:0], in};
					end else begin
						state <= BYTE1;
						out_reg <= {out_reg[7:0], in};
					end
				end
				DONE: begin
					if (third_bit) begin
						state <= BYTE2;
						out_reg <= {out_bytes[15:0], in};
					end else begin
						state <= BYTE1;
						out_reg <= {out_reg[15:0], in};
					end
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (state == DONE) begin
			out_bytes <= out_reg;
			done <= 1;
		end else begin
			done <= 0;
		end
	end

endmodule
