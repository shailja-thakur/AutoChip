module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:0] out_any,
    output [99:0] out_different
);
    wire [99:1] in_shifted;

    assign in_shifted = in[98:0];

    // out_both: AND operation between in[99:1] and in[98:0]
    assign out_both = in[99:1] & in_shifted;
    
    // out_any: OR operation between in[99:1] and in[98:0]
    assign out_any = {1'b0, in[99:1] | in_shifted};

    // out_different: XOR operation
    assign out_different = in ^ {in[0], in[99:1]};
    
endmodule
