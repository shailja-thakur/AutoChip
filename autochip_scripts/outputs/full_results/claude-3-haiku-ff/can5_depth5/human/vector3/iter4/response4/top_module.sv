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

wire [29:0] concatenated;

assign concatenated = {a, b, c, d, e, f, 2'b11};

assign w = {concatenated[4:0], 3'b0};
assign x = {concatenated[9:5], 3'b0};
assign y = {concatenated[14:10], 3'b0};
assign z = {concatenated[19:15], 3'b0};

endmodule
