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

assign w = {3'b000, concatenated[4:0]};
assign x = {3'b000, concatenated[9:5]};
assign y = {3'b000, concatenated[14:10]};
assign z = {3'b000, concatenated[19:15]};

endmodule
