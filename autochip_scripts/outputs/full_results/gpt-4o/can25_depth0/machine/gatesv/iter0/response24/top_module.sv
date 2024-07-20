module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output [3:0] out_different
);
    
    // Bitwise AND operation between bits 2 through 0 and bits 3 through 1 of 'in'
    assign out_both = in[2:0] & in[3:1];
    
    // Bitwise OR operation between bits 2 through 0 and bits 3 through 1 of 'in'
    assign out_any = {1'b0, in[2:0]} | in[3:0];  // corrected port width to [3:0]
    
    // Bitwise XOR operation between 'in' and bits 3 through 1, with 'in' bit 0 as an exception
    assign out_different = in ^ {in[3:1], in[0]};
    
endmodule
