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

    wire [39:0] concatenation;
    
    assign concatenation = {a, b, c, d, e, f, 2'b11};
    
    assign w = concatenation[39:32];
    assign x = concatenation[31:24];
    assign y = concatenation[23:16];
    assign z = concatenation[15:8];

endmodule
