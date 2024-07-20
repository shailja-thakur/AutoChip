module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);
    
    wire [3:0] temp_index;
    
    assign temp_index = sel * 4;  // Each selection corresponds to a 4-bit block, so multiplying by 4
    
    assign out = in[temp_index +: 4];  // Extracting 4-bit block starting from the calculated index
    
endmodule
