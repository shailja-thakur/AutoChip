module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	always @(posedge clk) begin
		if (load) begin
			q <= data; // loads shift register with data[99:0] instead of rotating
		end else if (ena == 2'b01) begin
			q <= {q[0], q[99:1]}; // rotates right by one bit
		end else if (ena == 2'b10) begin
			q <= {q[99], q[99:0]}; // rotates left by one bit
		end
	end

endmodule
