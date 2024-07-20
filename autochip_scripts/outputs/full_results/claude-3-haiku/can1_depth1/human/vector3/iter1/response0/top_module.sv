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

wire [29:0] combined_input;

assign combined_input = {a, b, c, d, e, f, 2'b11};

assign w = combined_input[7:0];
assign x = combined_input[15:8];
assign y = combined_input[23:16];
assign z = combined_input[29:22];

endmodule
