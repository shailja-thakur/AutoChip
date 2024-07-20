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

wire [29:0] concat_input;
assign concat_input = {a, b, c, d, e, f};

assign w = {concat_input[4:0], 3'b111};
assign x = {concat_input[9:5], 3'b111};
assign y = {concat_input[14:10], 3'b111};
assign z = {concat_input[19:15], 3'b111};

endmodule
