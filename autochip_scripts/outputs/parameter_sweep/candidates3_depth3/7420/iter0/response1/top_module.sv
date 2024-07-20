module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);
    wire p1_nand;
    wire p2_nand;
    
    nand_gate u1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(p1_nand));
    nand_gate u2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(p2_nand));
    
    not_gate u3(.a(p1_nand), .y(p1y));
    not_gate u4(.a(p2_nand), .y(p2y));
    
endmodule
module nand_gate(
    input a,
    input b,
    input c,
    input d,
    output y
);
    wire w1;
    wire w2;
    wire w3;
    
    nand u1(.a(a), .b(b), .y(w1));
    nand u2(.a(c), .b(d), .y(w2));
    nand u3(.a(w1), .b(w2), .y(w3));
    nand u4(.a(w3), .b(w3), .y(y));
    
endmodule
module nand(
    input a,
    input b,
    output y
);
    assign y = ~(a & b);
    
endmodule
module not_gate(
    input a,
    output y
);
    assign y = ~a;
    
endmodule
