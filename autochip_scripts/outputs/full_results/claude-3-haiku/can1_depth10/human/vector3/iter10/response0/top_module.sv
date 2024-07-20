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

wire [29:0] concatenated_inputs;

assign concatenated_inputs = {a, b, c, d, e, f, 2'b11};

assign w = concatenated_inputs[7:0];
assign x = concatenated_inputs[15:8];
assign y = concatenated_inputs[23:16];
assign z = concatenated_inputs[29:22];

endmodule
