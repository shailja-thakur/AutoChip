module top_module (
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [4:0] e,
    input [4:0] f,
    output reg [7:0] w,
    output reg [7:0] x,
    output reg [7:0] y,
    output reg [7:0] z
);

    // Concatenation
    wire [5:0] concat;
    assign concat = {a, b, c, d, e, f};

    // Output assignments
    assign w = {concat[5:3], 2'b11};
    assign x = {concat[4:2], 2'b11};
    assign y = {concat[3:1], 2'b11};
    assign z = {concat[2:0], 2'b11};

endmodule
