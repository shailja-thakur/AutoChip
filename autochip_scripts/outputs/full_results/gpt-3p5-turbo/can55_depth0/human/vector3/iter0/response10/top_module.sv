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

    wire [29:0] input_concatenated;
    wire [31:0] output_concatenated;

    assign input_concatenated = {a, b, c, d, e, f};
    assign output_concatenated = {input_concatenated, 2'b11};

    assign w = output_concatenated[31:24];
    assign x = output_concatenated[23:16];
    assign y = output_concatenated[15:8];
    assign z = output_concatenated[7:0];

endmodule
