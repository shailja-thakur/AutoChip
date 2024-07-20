module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8;

assign temp1 = ~a & ~b & ~c & d;
assign temp2 = ~a & ~b & c & ~d;
assign temp3 = ~a & ~b & c & d;
assign temp4 = ~a & b & ~c & ~d;
assign temp5 = ~a & b & ~c & d;
assign temp6 = ~a & b & c & ~d;
assign temp7 = ~a & b & c & d;
assign temp8 = a & ~b & ~c & ~d;

assign q = temp1 | temp2 | temp3 | temp4 | temp5 | temp6 | temp7 | temp8;

endmodule
