module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	reg [511:0] q_temp;

	always @(posedge clk) begin
		if (load)
			q_temp <= data;
		else begin
			q_temp <= {1'b0, q_temp[$bits(q_temp)-2:0]};
		end
	end

	always @(posedge clk) begin
		q <= q_temp;
	end

endmodule
