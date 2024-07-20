module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:0] x,
    output [7:0] y,
    output [7:0] z
);

assign {w, x, y, z} = {{3{a}}, {3{b}}, {3{c}}, {3{d}}, {3{e}}, {3{f}}, 2'b11};

endmodule
