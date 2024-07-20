module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q);

	reg [63:0] temp;

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else if (ena) begin
			case(amount)
				2'b00: begin // shift left by 1 bit
					temp[62:0] <= q[63:1];
					temp[63] <= q[63];
				end
				2'b01: begin // shift left by 8 bits
					temp[55:0] <= q[63:8];
					temp[63:56] <= q[63:56];
				end
				2'b10: begin // shift right by 1 bit (arithmetic right shift)
					temp[63] <= q[63];
					temp[62:0] <= q[63:1];
				end
				2'b11: begin // shift right by 8 bits (arithmetic right shift)
					temp[63:56] <= q[7:0];
					temp[55:0] <= q[55:0];
				end
			endcase
			q <= temp;
		end
	end

endmodule
