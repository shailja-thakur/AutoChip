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
    assign w = {a, 3'b0}; // a followed by padding zeros
    assign x = {b, 3'b0}; // b followed by padding zeros
    assign y = {c, 3'b0}; // c followed by padding zeros
    assign z = {d[3:0],e[3:2],f[1:0],2'b11}; // concatenation of d, e, f, and 11 in bits appropriately padded
endmodule
