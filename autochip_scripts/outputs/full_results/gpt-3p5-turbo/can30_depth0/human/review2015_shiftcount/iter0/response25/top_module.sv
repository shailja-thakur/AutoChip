module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] reg_temp;

	always @(posedge clk) begin
		if (shift_ena) begin
			reg_temp <= {q[2:0], data};
		end else if (count_ena) begin
			reg_temp <= reg_temp - 1;
		end
	end

	assign q = reg_temp;

endmodule
