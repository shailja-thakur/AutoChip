module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
);

    wire [8:0] sum_ext; // Extended sum to check for overflow

    assign sum_ext = {a[7], a} + {b[7], b}; // Extend with sign bit
    assign s = sum_ext[7:0];
    assign overflow = sum_ext[8] ^ sum_ext[7]; // Overflow occurs if the top two bits are different

endmodule
