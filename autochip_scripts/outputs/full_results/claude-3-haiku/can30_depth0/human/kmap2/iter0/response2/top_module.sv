module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

wire minterms_0, minterms_1, minterms_2, minterms_3;

assign minterms_0 = (~a) & (~b) & (~c) & d;
assign minterms_1 = (~a) & (~b) & c & d;
assign minterms_2 = (~a) & b & c & d;
assign minterms_3 = a & b & (~c) & (~d);

assign out = minterms_0 | minterms_1 | minterms_2 | minterms_3;

endmodule
