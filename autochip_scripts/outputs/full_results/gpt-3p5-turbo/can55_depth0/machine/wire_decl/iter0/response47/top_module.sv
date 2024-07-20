module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n );

    wire w1 = a & b;
    wire w2 = c & d;
    wire out_logic = w1 | w2;
    wire out_n_logic = ~out_logic;

    assign out = out_logic;
    assign out_n = out_n_logic;

endmodule
