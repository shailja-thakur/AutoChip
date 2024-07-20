module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);

    // bitwise AND operation
    assign out_both = in[2:0] & in[3:1];
    
    // bitwise OR operation
    assign out_any = {1'b0, in[2:0] | in[3:1]};
    
    // bitwise XOR operation
    assign out_different = in ^ {in[3:1], in[0]};

endmodule
