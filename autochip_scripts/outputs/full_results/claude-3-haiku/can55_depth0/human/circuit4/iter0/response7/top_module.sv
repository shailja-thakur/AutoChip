module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire and1, and2, and3, and4, and5, and6, and7, and8;

assign and1 = ~a & ~b & ~c & d;
assign and2 = ~a & ~b & c & ~d;
assign and3 = ~a & ~b & c & d;
assign and4 = ~a & b & ~c & ~d;
assign and5 = ~a & b & ~c & d;
assign and6 = ~a & b & c & ~d;
assign and7 = ~a & b & c & d;
assign and8 = a & (~b | ~c | d);

assign q = and1 | and2 | and3 | and4 | and5 | and6 | and7 | and8;

endmodule
