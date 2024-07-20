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

    assign w = {a, 1'b0, 1'b0}; // Concatenate with leading zeros to make 8 bits
    assign x = {b, 1'b0, 1'b0}; // Concatenate with leading zeros to make 8 bits
    assign y = {c, 1'b0, 1'b0}; // Concatenate with leading zeros to make 8 bits
    assign z = {d, e[4:2]};     // Concatenate with part of e to make 8 bits
endmodule
