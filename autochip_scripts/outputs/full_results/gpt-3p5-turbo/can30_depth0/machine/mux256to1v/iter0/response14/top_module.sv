module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    always @(sel, in) begin
        // calculate the starting index of the 4-bit block
        integer start_index = sel * 4;
        
        // extract the 4-bit block from the input vector
        wire [3:0] selected_block = in[start_index +: 4];
        
        // assign the selected block to the output
        assign out = selected_block;
    end
  
endmodule
