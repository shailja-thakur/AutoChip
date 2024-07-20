module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [4:0] veca, vecb, vecc, vecd, vece;
    wire [24:0] vec1, vec2;

    assign veca = {5{a}};
    assign vecb = {5{b}};
    assign vecc = {5{c}};
    assign vecd = {5{d}};
    assign vece = {5{e}};

    assign vec1 = {veca, vecb, vecc, vecd, vece};
    assign vec2 = {5{a, b, c, d, e}};
    assign out = (~vec1) ^ vec2;

endmodule
