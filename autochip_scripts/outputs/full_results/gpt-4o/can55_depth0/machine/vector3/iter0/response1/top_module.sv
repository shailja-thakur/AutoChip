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
    
    wire [37:0] concat;
    
    assign concat = {a, b, c, d, e, f, 2'b11}; // Total size = 5*6 + 2 = 32

    assign w = concat[37:30];
    assign x = concat[29:22];
    assign y = concat[21:14];
    assign z = concat[13:6];
endmodule
