module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);

    wire [3:0] a;
    wire [3:0] b;

    assign a = {p1[3:0], p2[3:0]};
    assign b = {p1[7:4], p2[7:4]};

    NAND4 a1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(p1y));
    NAND4 a2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(p2y));

endmodule
module NAND4(
    input a, 
    input b, 
    input c, 
    input d, 
    output y
);
    wire [3:0] temp1;
    wire [3:0] temp2;
    wire [3:0] temp3;
    
    NOT u1 (.a(a), .y(temp1[0]));
    NOT u2 (.a(b), .y(temp2[0]));
    NOT u3 (.a(c), .y(temp2[1]));
    NOT u4 (.a(d), .y(temp3[0]));
    
    AND2 u5 (.a(temp1[0]), .b(temp2[0]), .y(temp2[2]));
    AND2 u6 (.a(temp3[0]), .b(temp2[1]), .y(temp2[3]));

    AND2 u7 (.a(temp2[2]), .b(temp2[3]), .y(y));

endmodule
