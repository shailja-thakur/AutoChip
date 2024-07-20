module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] in_shifted;
    assign in_shifted = {in[98:0], in[99]}; // Shift the input vector by one bit left

    // Generate out_both: 99-bit AND operation
    assign out_both = in[99:1] & in[98:0];

    // Generate out_any: 100-bit OR operation
    assign out_any = in | {in[98:0], 1'b0}; 

    // Generate out_different: 100-bit XOR operation
    assign out_different = in ^ {in[98:0], in[99]};

endmodule
