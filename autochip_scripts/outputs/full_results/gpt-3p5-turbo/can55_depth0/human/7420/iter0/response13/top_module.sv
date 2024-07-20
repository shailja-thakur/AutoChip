module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);

    wire [3:0] p1nand_out;
    wire [3:0] p2nand_out;

    assign p1y = p1nand_out[0] & p1nand_out[1] & p1nand_out[2] & p1nand_out[3];
    assign p2y = p2nand_out[0] & p2nand_out[1] & p2nand_out[2] & p2nand_out[3];

    nand4 p1n1 (.a(p1[0]), .b(p1[1]), .c(p1[2]), .d(p1[3]), .y(p1nand_out[0]));
    nand4 p1n2 (.a(p1[4]), .b(p1[5]), .c(p1[6]), .d(p1[7]), .y(p1nand_out[1]));

    nand4 p2n1 (.a(p2[0]), .b(p2[1]), .c(p2[2]), .d(p2[3]), .y(p2nand_out[0]));
    nand4 p2n2 (.a(p2[4]), .b(p2[5]), .c(p2[6]), .d(p2[7]), .y(p2nand_out[1]));

endmodule
