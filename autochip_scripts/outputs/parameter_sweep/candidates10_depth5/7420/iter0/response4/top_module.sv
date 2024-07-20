module top_module(
    input [7:0] p1,
    input [7:0] p2,
    output p1y,
    output p2y
);

    wire p1_tmp;
    wire p2_tmp;

    nand_gate n1 (p1[0], p1[1], p1[2], p1[3], p1_tmp);
    nand_gate n2 (p2[0], p2[1], p2[2], p2[3], p2_tmp);
    nand_gate n3 (p1[4], p1[5], p1[6], p1[7], p1y);
    nand_gate n4 (p2[4], p2[5], p2[6], p2[7], p2y);

endmodule
module nand_gate (
    input a, 
    input b,
    input c,
    input d,
    output y
);

    assign y = ~(a & b & c & d);

endmodule
