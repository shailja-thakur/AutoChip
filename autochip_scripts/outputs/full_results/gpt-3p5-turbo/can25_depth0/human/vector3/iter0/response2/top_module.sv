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

    reg [29:0] in_vector;
    assign in_vector = {a, b, c, d, e, f};

    reg [31:0] out_vector;
    assign out_vector = {in_vector, 2'b11};

    assign {z, y, x, w} = out_vector;

endmodule
