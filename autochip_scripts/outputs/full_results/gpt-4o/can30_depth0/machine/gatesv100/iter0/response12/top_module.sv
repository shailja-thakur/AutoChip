module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);

    wire [99:0] shifted_in;
    assign shifted_in = {in[98:0], 1'b0}; // Shift the input vector by 1 bit to the right
    
    assign out_both = in[99:1] & in[98:0];            // Performing bit-wise AND, 99-bit wide
    assign out_any = in | shifted_in;                 // Performing bit-wise OR, 100-bit wide
    assign out_different = in ^ {shifted_in[99], in[99:1], in[0]}; // Performing bit-wise XOR, 100-bit wide

endmodule
