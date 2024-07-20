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

// Concatenate the inputs
wire [34:0] concat = {a, b, c, d, e, f, 2'b11};

// Assign the concatenated bits to the output ports
assign w = concat[34:27];
assign x = concat[26:19];
assign y = concat[18:11];
assign z = concat[10:3];

endmodule
