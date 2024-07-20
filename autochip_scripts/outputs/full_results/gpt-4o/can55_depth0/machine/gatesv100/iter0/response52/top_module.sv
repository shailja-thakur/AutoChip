module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    assign shifted_in = {in[98:0], 1'b0}; // Shift input by one bit

    // Generate out_both: 99-bit AND operation
    assign out_both = in[98:0] & shifted_in[99:1];

    // Generate out_any: 100-bit OR operation
    assign out_any = in | shifted_in;

    // Generate out_different: 100-bit XOR operation
    assign out_different = in ^ {shifted_in[99:1], in[99]};

endmodule
