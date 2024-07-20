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
    wire [35:0] concatenated_inputs;

    assign concatenated_inputs = {a, b, c, d, e, f, 2'b11};

    assign w = concatenated_inputs[35:28];
    assign x = concatenated_inputs[27:20];
    assign y = concatenated_inputs[19:12];
    assign z = concatenated_inputs[11:4];

endmodule
