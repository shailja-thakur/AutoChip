module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in = {in[98:0], 1'b0}; // Shift input signal by one bit

    assign out_both = in[99:1] & shifted_in[99:1]; // 99-bit AND operation
    assign out_any = in | shifted_in; // 100-bit OR operation
    assign out_different = in ^ {shifted_in[98:0], in[99]}; // 100-bit XOR operation with first bit different

endmodule
