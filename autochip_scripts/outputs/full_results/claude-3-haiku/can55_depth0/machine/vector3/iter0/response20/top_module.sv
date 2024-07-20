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

assign w = {a, 3'b111};
assign x = {b, 3'b111};
assign y = {c, 3'b111};
assign z = {d, e[4:3], f[4:2], 2'b11};

endmodule
