module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	reg [3:0] q_temp;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q_temp <= 4'b0;
		end else if (load) begin
			q_temp <= data;
		end else if (ena) begin
			q_temp <= {q_temp[2:0], 1'b0};
		end
	end

	always @(posedge clk) begin
		if (load || areset) begin
			q <= q_temp;
		end
	end

endmodule
