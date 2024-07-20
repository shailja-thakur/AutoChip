module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		// Check if load is high
		if (load) begin
			q <= data; // load data into q
		end else begin
			// Check ena to determine rotation direction
			case (ena)
				2'b01: q <= {q[0], q[99:1]}; // rotate right by one bit
				2'b10: q <= {q[98:0], q[99]}; // rotate left by one bit
				default: q <= q; // no rotation
			endcase
		end
	end

endmodule
