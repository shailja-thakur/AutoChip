module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);

    wire [3:0] and_out1;
    wire [3:0] and_out2;
    wire [3:0] nand_out;
    
    assign and_out1 = p1[3:0] & p1[7:4];
    assign and_out2 = p2[3:0] & p2[7:4];
    
    nand_gate nand1(
        .a(p1[3]),
        .b(p1[4]),
        .c(p1[5]),
        .d(p1[6]),
        .y(nand_out[0])
    );
    
    nand_gate nand2(
        .a(p1[7]),
        .b(p1[8]),
        .c(p2[3]),
        .d(p2[4]),
        .y(nand_out[1])
    );
    
    nand_gate nand3(
        .a(p2[5]),
        .b(p2[6]),
        .c(p2[7]),
        .d(p2[8]),
        .y(nand_out[2])
    );
    
    nand_gate nand4(
        .a(p2[9]),
        .b(p2[10]),
        .c(p2[11]),
        .d(p2[12]),
        .y(nand_out[3])
    );
    
    assign p1y = nand_out[0];
    assign p2y = nand_out[1];
    
endmodule
module nand_gate(
    input a,
    input b,
    input c,
    input d,
    output y
);
    assign y = ~(a & b & c & d);
endmodule
