module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);

	reg [3:1] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 16'b0000;
			count <= 3'b000;
		end else if (ena[1]) begin
			if (count == 3'b100) begin
				count <= 3'b000;
				q <= q + 16'b0001;
			end else begin
				count <= count + 3'b001;
			end
		end else if (ena[2]) begin
			if (count == 3'b100) begin
				count <= 3'b000;
				q <= q + 16'b0010;
			end else begin
				count <= count + 3'b001;
			end
		end else if (ena[3]) begin
			if (count == 3'b100) begin
				count <= 3'b000;
				q <= q + 16'b0100;
			end else begin
				count <= count + 3'b001;
			end
		end
	end

	assign ena = q[4:2];

endmodule
