module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    // Assign out_both to the result of the bitwise AND operation between in[2:0] and in[3:1]
    assign out_both = in[2:0] & in[3:1];
    
    // Assign out_any to the result of the bitwise OR operation between in[2:0] and in[3:1]
    assign out_any = in[2:0] | in[3:1];
    
    // Assign out_different to the result of the bitwise XOR operation between in[3:1] (except in[0]) and in
    assign out_different = in ^ (in[3:1] & 4'b1110);
endmodule
