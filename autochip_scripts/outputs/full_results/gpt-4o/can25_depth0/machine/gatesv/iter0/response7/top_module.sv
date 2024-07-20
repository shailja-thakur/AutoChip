module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);
    
    // Bitwise AND operation between in[2:0] and in[3:1] (3-bit result)
    assign out_both = in[2:0] & in[3:1];
    
    // Bitwise OR operation between in[2:0] and in[3:1] (4-bit result)
    assign out_any[2:0] = in[2:0] | in[3:1];
    assign out_any[3] = in[3];
    
    // Bitwise XOR operation between in and in[3:1] with in[0] being passed unchanged
    assign out_different[3:1] = in[3:1] ^ in[2:0];
    assign out_different[0] = in[0];
    
endmodule
