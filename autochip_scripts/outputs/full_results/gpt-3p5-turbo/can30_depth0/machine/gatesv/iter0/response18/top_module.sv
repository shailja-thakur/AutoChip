module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    // bitwise AND operation between input bits 2-0 and 3-1
    assign out_both = in[2:0] & in[3:1];
    
    // bitwise OR operation between input bits 2-0 and 3-1
    assign out_any = in[2:0] | in[3:1];
    
    // bitwise XOR operation between input and bits 3-1, with exception of bit 0
    assign out_different = in ^ {in[3:1], in[0]};
endmodule
