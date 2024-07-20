module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	// internal wires
	reg [99:0] temp;

	always @(posedge clk) begin
		if (load == 1'b1) begin
			q <= data;
		end else begin
			case (ena)
				2'b01: begin // shift left
					temp[98:0] <= q[99:1];
					temp[99] <= 1'b0;
					q <= temp;
				end
				2'b10: begin // shift right
					temp[99:1] <= q[98:0];
					temp[0] <= 1'b0;
					q <= temp;
				end
				default: begin // default case
					q <= q;
				end
			endcase
		end
	end

endmodule
