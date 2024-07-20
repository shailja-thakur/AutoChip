module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);

    wire [3:0] nand1;
    wire [3:0] nand2;

    assign p1y = nand1[3];
    assign p2y = nand2[3];

    nand2 #(.N(4)) n2(
        .a({p2[7], p2[6], p2[5], p2[4]}),
        .o(nand2)
    );

    nand1 #(.N(4)) n1(
        .a({p1[7], p1[6], p1[5], p1[4]}),
        .o(nand1)
    );

endmodule
