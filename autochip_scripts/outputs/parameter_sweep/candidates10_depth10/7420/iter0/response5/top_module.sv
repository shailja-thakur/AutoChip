module top_module(
	input [7:0] p1,
	output reg p1y,
	input [7:0] p2,
	output reg p2y
);
	reg [3:0] p1_nand;
	reg [3:0] p2_nand;

	always @(p1) begin
		p1_nand[0] = ~(p1[0] & p1[1] & p1[2] & p1[3]);
		p1_nand[1] = ~(p1[4] & p1[5] & p1[6] & p1[7]);
	end

	always @(p2) begin
		p2_nand[0] = ~(p2[0] & p2[1] & p2[2] & p2[3]);
		p2_nand[1] = ~(p2[4] & p2[5] & p2[6] & p2[7]);
	end

	assign p1y = p1_nand[0] & p1_nand[1];
	assign p2y = p2_nand[0] & p2_nand[1];
endmodule
