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

wire [5:0] inputs;
assign inputs = {a, b, c, d, e, f};

assign w = {inputs[5:0], 2'b11};
assign x = {inputs[5:0], 2'b11};
assign y = {inputs[5:0], 2'b11};
assign z = {inputs[5:0], 2'b11};

endmodule
