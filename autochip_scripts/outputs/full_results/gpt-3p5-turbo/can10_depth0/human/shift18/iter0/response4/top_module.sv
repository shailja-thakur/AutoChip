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
			case (amount)
				2'b00: begin // shift left by 1 bit
					q <= {q[62:0], q[63]};
				end
				2'b01: begin // shift left by 8 bits
					q <= {q[55:0], data[63:56]};
				end
				2'b10: begin // shift right by 1 bit
					q <= {q[63], q[63:1]};
				end
				2'b11: begin // shift right by 8 bits
					q <= {data[7:0], q[63:8]};
				end
			endcase
		end
	end

endmodule
