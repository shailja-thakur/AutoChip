module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] reg_data;
	reg [3:0] reg_count;
	always @(posedge clk) begin
		if (count_ena) begin
			reg_count <= reg_count - 1;
		end
		if (shift_ena) begin
			reg_data <= {reg_count[2:0], data};
		end
	end
	
	assign q = reg_data;

endmodule
