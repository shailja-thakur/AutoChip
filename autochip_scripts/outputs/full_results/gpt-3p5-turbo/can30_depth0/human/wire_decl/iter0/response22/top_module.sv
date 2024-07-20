module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire intermediate_1;
    wire intermediate_2;

    assign intermediate_1 = a & b;
    assign intermediate_2 = c & d;

    assign out = intermediate_1 | intermediate_2;
    assign out_n = ~out;

endmodule
