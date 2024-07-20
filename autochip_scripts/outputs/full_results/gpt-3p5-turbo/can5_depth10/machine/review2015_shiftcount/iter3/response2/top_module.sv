module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output wire [3:0] q
);

	wire [3:0] q_temp;

	always @(posedge clk) begin
		if (shift_ena) begin
			q_temp <= data;
		end
		if (count_ena) begin
			q_temp <= q_temp - 1;
		end
	end

	assign q = q_temp;

endmodule
