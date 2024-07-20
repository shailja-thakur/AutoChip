module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    wire [99:0] in_shifted;

    assign in_shifted = {in[98:0], 1'b0}; // shift input by one bit to the left
    
    assign out_both = in[99:1] & in_shifted[99:1]; // out_both retains 99 bits
    assign out_any = in | in_shifted;
    assign out_different = {in[99] ^ in_shifted[0], in[98:0] ^ in_shifted[99:1]};

endmodule
