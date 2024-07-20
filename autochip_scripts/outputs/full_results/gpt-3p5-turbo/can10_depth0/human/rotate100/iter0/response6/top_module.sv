module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		if (load) begin  // check if load is high
			q <= data;  // load the shift register with data
		end else begin
			case (ena)
				2'b01: begin  // rotate right by one bit
					q[0] <= q[99];  // store the shifted-out bit in the opposite end
					q[1:99] <= q[0:98];  // shift the bits to the right
				end
				2'b10: begin  // rotate left by one bit
					q[99] <= q[0];  // store the shifted-out bit in the opposite end
					q[0:98] <= q[1:99];  // shift the bits to the left
				end
				default: begin  // do not rotate
					q <= q;  // no change in the shift register
				end
			endcase
		end
	end

endmodule
