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

wire w1, w2;

nand_gate my_nandgate1(.a(p1a), .b(p1b), .c(p1c), .d(p1d), .y(w1));
nand_gate my_nandgate2(.a(p2a), .b(p2b), .c(p2c), .d(p2d), .y(w2));

assign p1y = w1;
assign p2y = w2;

endmodule
