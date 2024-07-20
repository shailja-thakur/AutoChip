module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [9:0] start_index;
    
    // Calculate the starting index of the 4-bit block based on the selection vector (sel)
    assign start_index = sel * 4;
    
    // Extract the 4-bit block from the input vector (in) based on the calculated start index
    assign out = in[start_index +: 4];

endmodule
