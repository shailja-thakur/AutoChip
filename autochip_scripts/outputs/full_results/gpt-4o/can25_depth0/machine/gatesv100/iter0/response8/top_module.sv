module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    
    // Shift the input signal by one bit
    assign shifted_in = {in[98:0], 1'b0};

    // Generate the out_both signal
    assign out_both = in[98:0] & shifted_in[98:0];  // 99-bit vector

    // Generate the out_any signal    
    assign out_any = in | shifted_in;  // 100-bit vector

    // Generate the out_different signal
    assign out_different = in ^ {shifted_in[98:0], in[99]};  // First bit: XOR between first bit of 'in' and last bit of 'shifted_in'

endmodule
