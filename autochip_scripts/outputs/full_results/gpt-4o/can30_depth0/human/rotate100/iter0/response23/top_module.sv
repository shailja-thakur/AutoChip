module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data;
		end else begin
			case (ena)
				2'b01: q <= {q[0], q[99:1]};  // Rotate right by 1 bit
				2'b10: q <= {q[98:0], q[99]};  // Rotate left by 1 bit
				default: q <= q;  // No rotation for 2'b00 and 2'b11
			endcase
		end
	end
endmodule
