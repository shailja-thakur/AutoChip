module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    // Added a temporary variable to store in[99] to handle the wrapping around
    wire temp = in[99];
    
    assign out_both = in[98:0] & {temp, in[99:1]};
    
    assign out_any = {in[1:0], in[99:2], in[99]};
    
    assign out_different = in ^ {in[99], in[98:0]};

endmodule
