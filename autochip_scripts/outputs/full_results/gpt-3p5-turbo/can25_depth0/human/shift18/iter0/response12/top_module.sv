module top_module(
	input clk,
	input load,
	input ena,
	input [1:0] amount,
	input [63:0] data,
	output reg [63:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else if (ena) begin
			case(amount)
				2'b00: begin // shift left by 1 bit
					q <= q << 1;
				end
				2'b01: begin // shift left by 8 bits
					q <= q << 8;
				end
				2'b10: begin // shift right by 1 bit (arithmetic right shift)
					q <= q >>> 1;
				end
				2'b11: begin // shift right by 8 bits (arithmetic right shift)
					q <= q >>> 8;
				end
				default: begin
					q <= q;
				end
			endcase
		end
	end
endmodule
