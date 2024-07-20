module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out,
    output reg out_n
);

    wire w1, w2;

    assign w1 = a & b;
    assign w2 = c & d;

    always @*
    begin
       out = w1 | w2;
       out_n = ~out;
    end

endmodule
