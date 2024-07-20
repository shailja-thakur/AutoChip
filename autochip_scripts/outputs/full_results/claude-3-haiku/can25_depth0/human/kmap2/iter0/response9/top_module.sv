module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire term1, term2, term3, term4;

assign term1 = (~a) & (~b) & (~c) & d;
assign term2 = (~a) & (~b) & c & (~d);
assign term3 = (~a) & b & c & d;
assign term4 = a & b & (~c) & (~d);

assign out = term1 | term2 | term3 | term4;

endmodule
