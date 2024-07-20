module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);

    wire [3:0] p1nand;
    wire [3:0] p2nand;
    
    nand4 gate1(.a(p1[3]), .b(p1[2]), .c(p1[1]), .d(p1[0]), .y(p1nand[0]));
    nand4 gate2(.a(p1[7]), .b(p1[6]), .c(p1[5]), .d(p1[4]), .y(p1nand[1]));
    nand4 gate3(.a(p2[3]), .b(p2[2]), .c(p2[1]), .d(p2[0]), .y(p2nand[0]));
    nand4 gate4(.a(p2[7]), .b(p2[6]), .c(p2[5]), .d(p2[4]), .y(p2nand[1]));
    
    nand2 gate5(.a(p1nand[0]), .b(p1nand[1]), .y(p1y));
    nand2 gate6(.a(p2nand[0]), .b(p2nand[1]), .y(p2y));

endmodule
