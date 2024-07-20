module top_module(
	input clk,
	input load,
	input [1:0] ena,
	input [99:0] data,
	output reg [99:0] q);

	reg [99:0] temp;

	always @(posedge clk) begin
		if (load == 1'b1) begin
			temp <= data;
		end else begin
			if (ena == 2'b01) begin
				temp <= {temp[98:0], 1'b0};
			end else if (ena == 2'b10) begin
				temp <= {1'b0, temp[99:1]};
			end
		end
	end

	assign q = temp;

endmodule
