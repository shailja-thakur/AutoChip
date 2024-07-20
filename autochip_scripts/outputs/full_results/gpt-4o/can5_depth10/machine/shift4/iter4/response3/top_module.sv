module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q <= 4'b0000; // On asynchronous reset, set the output register to 0
		end else if (load) begin
			q <= data; // On load, load the data into the output register
		end else if (ena) begin
			q <= {q[2:0], 1'b0}; // On enable, shift the output register left by 1 bit
		end
	end

endmodule
