module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] reg_data;
	always @(posedge clk) begin
		if (shift_ena) begin
			reg_data <= {reg_data[2:0], data};
		end else if (count_ena) begin
			reg_data <= reg_data - 1;
		end
	end

	assign q = reg_data;

endmodule
