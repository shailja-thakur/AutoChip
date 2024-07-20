module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);
	reg [1023:0] in_reg;
	reg [3:0] out_reg;

	always @(in or sel) begin
		out_reg = in_reg[sel +: 4];
	end

	always @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			in_reg <= '0;
			out_reg <= '0;
		end else begin
			in_reg <= in;
			out <= out_reg;
		end
	end
endmodule
