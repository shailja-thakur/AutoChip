module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output [7:0] w,
    output [7:8] x,
    output [7:8] y,
    output [7:8] z
);

    wire [33:0] concat_value;

    assign concat_value = {a, b, c, d, e, f, 2'b11};

    assign w = concat_value[7:0];
    assign x = concat_value[15:8];
    assign y = concat_value[23:16];
    assign z = concat_value[31:24];

endmodule
