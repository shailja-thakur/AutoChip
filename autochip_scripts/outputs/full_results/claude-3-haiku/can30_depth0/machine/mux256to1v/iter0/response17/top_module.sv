module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    wire [3:0] selected_block;
    
    // Calculate the starting index of the 4-bit block in the input vector
    assign selected_block = in[((sel * 4) + 3) : (sel * 4)];
    
    // Assign the selected 4-bit block to the output
    assign out = selected_block;

endmodule
