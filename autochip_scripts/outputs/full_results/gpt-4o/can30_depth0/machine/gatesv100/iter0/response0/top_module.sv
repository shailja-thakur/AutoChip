module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;

    assign shifted_in = {in[98:0], 1'b0};  // Shift 'in' by 1 bit to the right

    assign out_both = in[99:1] & shifted_in[98:0];  // 99-bit AND operation
    assign out_any = in | {shifted_in[99:1], 1'b0}; // 100-bit OR operation including the shifted bits
    assign out_different = in ^ {shifted_in[99:1], in[99]};  // 100-bit XOR operation with wrap-around

endmodule
